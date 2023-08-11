# CVE-2022-23131
![](https://img.shields.io/static/v1?label=Product&message=Zabbix&color=blue)
![](https://img.shields.io/static/v1?label=Version&message=5.4.0–5.4.8;%206.0.0alpha1&color=brighgreen)
![](https://img.shields.io/static/v1?label=Vulnerability&message=CVSSv3:%209.8.%20SAML%20SSO%20Authentication%20Bypass&color=red)


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
<!-- Here is an Easter Egg for inquiring minds
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
<!-- Here is an Easter Egg for inquiring minds ;-)
RCE - https://habr.com/ru/companies/deiteriylab/articles/656829/
https://rioasmara.com/2022/04/16/exploit-zabbix-for-reverse-shell/
 -->
