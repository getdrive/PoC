# CVE-2023-25135
![](https://img.shields.io/static/v1?label=Product&message=vBulletin&color=blue)
![](https://img.shields.io/static/v1?label=Version&message=before%205.6.9%20PL1&color=brighgreen)
![](https://img.shields.io/static/v1?label=Vulnerability&message=CVSSv3:%209.8.%20Pre-authentication%20Remote%20Code%20Execution&color=red)


See: https://www.ambionics.io/blog/vbulletin-unserializable-but-unreachable

#### Netlas Dork.
- [Search Link](https://app.netlas.io/responses/?page=1&q=tag.vbulletin.version%3A%3C%3D5.6.9)
```
 tag.vbulletin.version:<=5.6.9
```
- Usage
```
python3 rce_exploit.py --help                 
Usage: rce_exploit.py [-h] [-p PROXY] url command

Exploit for CVE-2023-25135: vBulletin pre-authentication RCE.

Positional Arguments:
  url                   Target URL
  command               Command to execute

Options:
  -h, --help            show this help message and exit
  -p, --proxy PROXY     Proxy to use (optional)
 ```
