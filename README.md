![](https://img.shields.io/static/v1?label=Exploits&message=Proof%20of%20Concept&color=blue)
![](https://img.shields.io/static/v1?label=Threat%20Level&message=%20%20%20Critical%20%20%20&color=red)
# PoC. Severity critical.
## 2023

### Wordpress plugin Forminator RCE
#### Vulnerability description. CVE-2023-4596. CVSSv3 Score 9.8.
The Forminator plugin for WordPress is vulnerable to arbitrary file uploads due to file type validation occurring after a file has been uploaded to the server in the upload_post_image() function in versions up to, and including, 1.24.6. This makes it possible for unauthenticated attackers to upload arbitrary files on the affected site's server which may make remote code execution possible.
- [Wordpress plugin Forminator RCE Exploit](https://github.com/getdrive/PoC/tree/main/2023/WordPress_plugin_Forminator_RCE)

### OpenTSDB - Remote Code Execution. CVE-2023-25826. CVSSv3 Score 9.8.
#### Vulnerability description.
Due to insufficient validation of parameters passed to the legacy HTTP query API, it is possible to inject crafted OS commands into multiple parameters and execute malicious code on the OpenTSDB host system. This exploit exists due to an incomplete fix that was made when this vulnerability was previously disclosed as CVE-2020-35476. Regex validation that was implemented to restrict allowed input to the query API does not work as intended, allowing crafted commands to bypass validation.
- [OpenTSDB - Remote Code Execution Exploit](https://github.com/getdrive/PoC/tree/main/2023/OpenTSDB_RCE)

### FileMage Gateway - Unauthenticated Directory Traversal. CVE-2023-39026.
#### Vulnerability description.
Directory Traversal vulnerability in FileMage Gateway Windows Deployments v.1.10.8 and before allows a remote attacker to obtain sensitive information via a crafted request to the /mgmt/ component.
- [FileMage Gateway - Directory Traversal Exploit](https://github.com/getdrive/PoC/tree/main/2023/FileMage_Gateway_LFI)

### SonicWall - Authentication Bypass. CVE-2023-34124. CVSSv3 Score 9.8.
#### Vulnerability description.
The authentication mechanism in SonicWall GMS and Analytics Web Services had insufficient checks, allowing authentication bypass. This issue affects GMS: 9.3.2-SP1 and earlier versions; Analytics: 2.5.0.4-R7 and earlier versions.
- [SonicWall - Authentication Bypass Exploit](https://github.com/getdrive/PoC/tree/main/2023/Sonicwall_Shell_Injection)

### Ivanti Endpoint Manager Mobile (EPMM) - Unauthenticated API Access. CVE-2023-35078. CVSSv3 Score 10.0.
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

### Barracuda ESG Command Injection. CVE-2023-2868. CVSSv3 Score 9.8.
#### Vulnerability description.
A remote command injection vulnerability exists in the Barracuda Email Security Gateway (appliance form factor only) product effecting versions 5.1.3.001-9.2.0.006. The vulnerability arises out of a failure to comprehensively sanitize the processing of .tar file (tape archives). The vulnerability stems from incomplete input validation of a user-supplied .tar file as it pertains to the names of the files contained within the archive. As a consequence, a remote attacker can specifically format these file names in a particular manner that will result in remotely executing a system command through Perl's qx operator with the privileges of the Email Security Gateway product. This issue was fixed as part of BNSF-36456 patch. This patch was automatically applied to all customer appliances.The command injection vulnerability exists in the parsing logic for the processing of TAR files. The following code within the product is the focal point of the vulnerability:
`qx{$tarexec -O -xf $tempdir/parts/$part '$f'};`
- [Barracuda ESG Command Injection Exploit](https://github.com/getdrive/PoC/tree/main/2023/Barracuda%20ESG)

### Citrix ADC Gateway - Unauthenticated Remote Code Execution. CVE-2023-3519. CVSSv3 Score 9.8.

- [Citrix ADC Gateway - Unauthenticated Remote Code Execution Exploit](https://github.com/getdrive/PoC/tree/main/2023/Citrix%20ADC%20RCE%20CVE-2023-3519)

### Chamilo Unauthenticated Command Injection. CVE-2023-34960. CVSSv3 Score 9.8.
#### Vulnerability description.
A command injection vulnerability in the wsConvertPpt component of Chamilo v1.11.* up to v1.11.18 allows attackers to execute arbitrary commands via a SOAP API call with a crafted PowerPoint name.
- [Chamilo Unauthenticated Command Injection Exploit](https://github.com/getdrive/PoC/tree/main/2023/Chamilo%20CVE-2023-34960)

### Wordpress WooCommerce plugin Unauthorized Admin Access. CVE-2023-28121. CVSSv3 Score 9.8.
#### Vulnerability description.
An issue in WooCommerce Payments plugin for WordPress (versions 5.6.1 and lower) allows an unauthenticated attacker to send requests on behalf of an elevated user, like administrator. This allows a remote, unauthenticated attacker to gain admin access on a site that has the affected version of the plugin activated.
- [Wordpress WooCommerce plugin Unauthorized Admin Access Exploit](https://github.com/getdrive/PoC/tree/main/2023/WooCommerce_plugin_Unauthorized_Admin_Access)

### Zyxel ZyWALL/USG Remote Code Execution. CVE-2023-28771. CVSSv3 Score 9.8.
#### Vulnerability description.
Improper error message handling in Zyxel ZyWALL/USG series firmware versions 4.60 through 4.73, VPN series firmware versions 4.60 through 5.35, USG FLEX series firmware versions 4.60 through 5.35, and ATP series firmware versions 4.60 through 5.35, which could allow an unauthenticated attacker to execute some OS commands remotely by sending crafted packets to an affected device.
- [Zyxel ZyWALL/USG Remote Code Execution Exploit](https://github.com/getdrive/PoC/tree/main/2023/Zyxel_ZyWALL_USG_RCE)

### CloudPanel Shell Upload. CVE-2023-35885. CVSSv3 Score 9.8. 
#### Vulnerability description.
CloudPanel 2 before 2.3.1 has insecure file-manager cookie authentication. PoC for CVE-2023-35885 could potentially allow an attacker to upload a webshell into the server.
- [CloudPanel Web-Shell Upload Exploit](https://github.com/getdrive/PoC/tree/main/2023/CloudPanel_CVE-2023-35885)

### Adobe ColdFusion Unauthenticated Remote Code Execution. CVE-2023-26360. CVSSv3 Score 9.8.
#### Vulnerability description.
Adobe ColdFusion versions 2018 Update 15 (and earlier) and 2021 Update 5 (and earlier) are affected by an Improper Access Control vulnerability that could result in arbitrary code execution in the context of the current user. Exploitation of this issue does not require user interaction.
- [Adobe ColdFusion Unauthenticated Remote Code Execution Exploit](https://github.com/getdrive/PoC/tree/main/2023/Adobe_Cold_Fusion_CVE-2023-26360)

### Metabase Remote Code Execution. CVE-2023-38646. CVSSv3 Score 9.8.
#### Vulnerability description.
Metabase versions before 0.46.6.1 contain a flaw where the secret setup-token is accessible even after the setup process has been completed. With this token a user is able to submit the setup functionality to create a new database. When creating a new database, an H2 database string is created with a TRIGGER that allows for code execution.
- [Metabase Remote Code Execution Exploit](https://github.com/getdrive/PoC/tree/main/2023/Metabase)

## 2022
### RaspAP Unauthenticated Command Injection. CVE-2022-39986. CVSSv3 Score 9.8.
#### Vulnerability description.
RaspAP is feature-rich wireless router software that just works on many popular Debian-based devices, including the Raspberry Pi. A Command Injection vulnerability in RaspAP versions 2.8.0 thru 2.8.7 allows unauthenticated attackers to execute arbitrary commands in the context of the user running RaspAP via the cfg_id parameter in /ajax/openvpn/activate_ovpncfg.php and /ajax/openvpn/del_ovpncfg.php. Successfully tested against RaspAP 2.8.0 and 2.8.7.
- [RaspAP Unauthenticated Command Injection Exploit](https://github.com/getdrive/PoC/tree/main/2022/RaspAp_RCE)


### F5-BIG-IP Remote Code Execution. CVE-2022-1388. CVSSv3 Score 9.8.
#### Vulnerability description.
This vulnerability may allow an unauthenticated attacker with network access to the BIG-IP system through the management port and/or self IP addresses to execute arbitrary system commands, create or delete files, or disable services.
- [F5-BIG-IP Remote Code Execution Exploit](https://github.com/getdrive/POC/tree/main/2022/F5-Big-IP)

### Zabbix - SAML SSO Authentication Bypass and Remote Code Execution. CVE-2022-23131. CVSSv3 Score 9.8.
#### Vulnerability description.
Zabbix server is affected by an Authentication Bypass vulnerability, located in the SSO endpoint. The root cause of this vulnerability consists in improper user login session verification. If SAML SSO authentication is enabled (disabled by default), a malicious attacker can modify the session data and gain access as a Zabbix user and then execute remote commands on the server by modifying the scripting functionality. The attacker needs to know the username of a Zabbix user to craft the session data. All the versions affected are up to and including 5.4.8, 5.0.18, and 4.0.36.
- [Zabbix - SAML SSO Authentication Bypass Exploit](https://github.com/getdrive/POC/tree/main/2022/Zabbix)

### Oracle E-Business Suite - Remote Code Execution. CVE-2022-21587. CVSSv3 Score 9.8.
#### Vulnerability description.
Oracle Web Applications Desktop Integrator product of Oracle E-Business Suite is affected by a Remote Code Execution vulnerability. The root cause of this vulnerability is a special case treated by doUploadFile method which allows uploading a file using UUE encoding. The attacker can upload a malicious Perl web shell in order to achieve access to the server.
- [Oracle E-Business Suite - Remote Code Execution Exploit](https://github.com/getdrive/PoC/tree/main/2022/Oracle_EBS)

### Confluence Server and Data Center Unauthenticated RCE. CVE-2022-26134. CVSSv3 Score 9.8.
#### Vulnerability description.
In affected versions of Confluence Server and Data Center, an OGNL injection vulnerability exists that would allow an unauthenticated attacker to execute arbitrary code on a Confluence Server or Data Center instance. The affected versions are from 1.3.0 before 7.4.17, from 7.13.0 before 7.13.7, from 7.14.0 before 7.14.3, from 7.15.0 before 7.15.2, from 7.16.0 before 7.16.4, from 7.17.0 before 7.17.4, and from 7.18.0 before 7.18.1.
- [Confluence Server and Data Center RCE Exploit](https://github.com/getdrive/PoC/tree/main/2022/Confluence)

## 2020
### Liferay Portal - Remote Code Execution. CVE-2020-7961. CVSSv3 Score 9.8.
#### Vulnerability description.
Deserialization of Untrusted Data in Liferay Portal prior to 7.2.1 CE GA2 allows remote attackers to execute arbitrary code via JSON web services (JSONWS).
- [Liferay Portal - Remote Code Execution Exploit](https://github.com/getdrive/PoC/tree/main/2020/Liferay_Portal_RCE)

## 2019
### ThinVNC - Arbitrary File Read. CVE-2019-17662. CVSSv3 Score 9.8.
#### Vulnerability description.
ThinVNC 1.0b1 is vulnerable to arbitrary file read, which leads to a compromise of the VNC server. The vulnerability exists even when authentication is turned on during the deployment of the VNC server. The password for authentication is stored in cleartext in a file that can be read via a ../../ThinVnc.ini directory traversal attack vector.
- [ThinVNC - Arbitrary File Read Exploit](https://github.com/getdrive/POC/tree/main/2019/ThinVNC)

### Kibana - Remote Code Execution. CVE-2019-7609. CVSSv3 Score 10.0.
#### Vulnerability description.
Kibana versions before 5.6.15 and 6.6.1 contain an arbitrary code execution flaw in the Timelion visualizer. An attacker with access to the Timelion application could send a request that will attempt to execute javascript code. This could possibly lead to an attacker executing arbitrary commands with permissions of the Kibana process on the host system.
- [Kibana RCE Exploit](https://github.com/getdrive/PoC/tree/main/2019/Kibana_RCE) 
