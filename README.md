# POC. Severity critical.
## 2023
### Ivanti Endpoint Manager Mobile (EPMM) - Unauthenticated API Access. CVE-2023-35078. CVSSv3 Score 10.
#### Vulnerability description.
Ivanti MobileIron is vulnerable to CVE-2023-35078, a vulnerability that allows unauthenticated access to specific API paths. The root cause of this vulnerability is improper authentication validation. This vulnerability allows an unauthenticated remote attacker to access personally identifiable information (PII) such as names, phone numbers, and other mobile device details for users on a vulnerable system. An attacker can also make other configuration changes, including creating an EPMM administrative account that can make further changes to a vulnerable system.
- [Ivanti Endpoint Manager Mobile (EPMM) Exploit](https://github.com/getdrive/POC/tree/main/2023/Ivanti%20Endpoint%20Manager%20Mobile%20(EPMM))


### PaperCut - Unauthenticated Remote Code Execution. CVE-2023-27350. CVSSv3 Score 9.8.
#### Vulnerability description.
PaperCut is vulnerable to CVE-2023-27350, an Authentication Bypass vulnerability in the SetupCompleted class. The root cause of this vulnerability is improper sanitization of user-provided input. This vulnerability allows a remote unauthenticated attacker to bypass authentication and execute commands within the SYSTEM context.
- [PaperCut - Unauthenticated Remote Code Execution Exploit](https://github.com/getdrive/POC/tree/main/2023/PaperCut)

### Sophos Web Appliance - Remote Code. CVE-2023-1671. CVSSv3 Score 9.8.
#### Vulnerability description.
Sophos Web Appliance is vulnerable to CVE-2023-1671, a Remote Code Execution in the warn-proceed handler. The root cause of this vulnerability is improper sanitization of user-provided input. This vulnerability allows a remote unauthenticated attacker to inject commands through the data field by escaping commands with a single quote.
- [Sophos Web Appliance - Remote Code Exploit](https://github.com/getdrive/POC/tree/main/2023/Sophos%20Web%20Appliance)
    
### Essential Addons for Elementor 5.4.0-5.7.1 - Unauthenticated Privilege Escalation. CVE-2023-32243. CVSSv3 Score 9.8.
#### Vulnerability description. 
Improper Authentication vulnerability in WPDeveloper Essential Addons for Elementor allows Privilege Escalation. This issue affects Essential Addons for Elementor: from 5.4.0 through 5.7.1.
- [Essential Addons Exploit](https://github.com/getdrive/POC/tree/main/2023/Essential%20Addons)

### vBulletin Pre-authentication RCE. CVE-2023-25135. CVSSv3 Score 9.8.
#### Vulnerability description. 
vBulletin before 5.6.9 PL1 allows an unauthenticated remote attacker to execute arbitrary code via a crafted HTTP request that triggers deserialization. This occurs because verify_serialized checks that a value is serialized by calling unserialize and then checking for errors. 
- [vBulletin Pre-authentication RCE Exploit](https://github.com/getdrive/POC/tree/main/2023/vbulletin)

## 2022
### F5-BIG-IP Remote Code Execution. CVE-2022-1388. CVSSv3 Score 9.8.
#### Vulnerability description.
This vulnerability may allow an unauthenticated attacker with network access to the BIG-IP system through the management port and/or self IP addresses to execute arbitrary system commands, create or delete files, or disable services.
- [F5-BIG-IP Remote Code Execution Exploit](https://github.com/getdrive/POC/tree/main/2022/F5-Big-IP)

## 2019
### ThinVNC - Arbitrary File Read. CVE-2019-17662. CVSSv3 Score 9.8.
#### Vulnerability description.
ThinVNC 1.0b1 is vulnerable to arbitrary file read, which leads to a compromise of the VNC server. The vulnerability exists even when authentication is turned on during the deployment of the VNC server. The password for authentication is stored in cleartext in a file that can be read via a ../../ThinVnc.ini directory traversal attack vector.
- [ThinVNC - Arbitrary File Read Exploit](https://github.com/getdrive/POC/tree/main/2019/ThinVNC)
