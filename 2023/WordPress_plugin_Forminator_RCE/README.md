# CVE-2023-4596 
![](https://img.shields.io/static/v1?label=Product&message=Wordpress&color=blue)
![](https://img.shields.io/static/v1?label=Version&message=Forminator%20<=%201.24&color=brighgreen)
![](https://img.shields.io/static/v1?label=Vulnerability&message=CVSSv3:%209.8.%20Unauthenticated%20Remote%20Command%20Execution&color=red)

[NucleiTamplate](https://github.com/projectdiscovery/nuclei-templates/pull/8118/files)

- Shodan dork:
```
http.html:"/wp-content/plugins/forminator"
```
- FOFA dork:
```
body="/wp-content/plugins/forminator"
```
### Usage
```
python3 exploit.py -v -u https://target-IP/
```

