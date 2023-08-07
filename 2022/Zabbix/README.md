# CVE-2022-23131
Zabbix - SAML SSO Authentication Bypass
- Shodan dorks:
```
title:Zabbix html:(SAML)
```
```
http.favicon.hash:892542951
```
```
"html: Zabbix" "html:(SAML)"
```
<!--
```
"html: Zabbix" "html:guest"
```
-->
- Usage
```
python3 zabbix_session_exp.py -t https:target.com -u Admin
```
### Demonstration Video (0:33)
[Zabbix - SAML SSO Authentication Bypass](https://youtu.be/xVY98l0QU-M)
<!-- Here is an egg hunt for inquiring minds ;-)
RCE - https://habr.com/ru/companies/deiteriylab/articles/656829/
https://rioasmara.com/2022/04/16/exploit-zabbix-for-reverse-shell/
 -->
