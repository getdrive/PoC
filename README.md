# POC. Severity critical.
## 2023
### Ivanti Endpoint Manager Mobile (EPMM) - Unauthenticated API Access. CVE-2023-35078. CVSSv3 Score 10.
#### Vulnerability description.
Ivanti MobileIron is vulnerable to CVE-2023-35078, a vulnerability that allows unauthenticated access to specific API paths. The root cause of this vulnerability is improper authentication validation. This vulnerability allows an unauthenticated remote attacker to access personally identifiable information (PII) such as names, phone numbers, and other mobile device details for users on a vulnerable system. An attacker can also make other configuration changes, including creating an EPMM administrative account that can make further changes to a vulnerable system.
- [2023/Ivanti Endpoint Manager Mobile (EPMM) Exploit](https://github.com/getdrive/POC/tree/main/2023/Ivanti%20Endpoint%20Manager%20Mobile%20(EPMM))


### PaperCut - Unauthenticated Remote Code Execution. CVE-2023-27350. CVSSv3 Score 9.8.
#### Vulnerability description.
Oracle Web Applications Desktop Integrator product of Oracle E-Business Suite is affected by a Remote Code Execution vulnerability. The root cause of this vulnerability is a special case treated by doUploadFile method which allows uploading a file using UUE encoding. The attacker can upload a malicious Perl web shell in order to achieve access to the server.
- [PaperCut - Unauthenticated Remote Code Execution Exploit](https://github.com/getdrive/POC/tree/main/2023/PaperCut)

### Sophos Web Appliance - Remote Code. CVE-2023-1671. CVSSv3 Score 9.8.
#### Vulnerability description.
Sophos Web Appliance is vulnerable to CVE-2023-1671, a Remote Code Execution in the warn-proceed handler. The root cause of this vulnerability is improper sanitization of user-provided input. This vulnerability allows a remote unauthenticated attacker to inject commands through the data field by escaping commands with a single quote.
- [Sophos Web Appliance - Remote Code Exploit](https://github.com/getdrive/POC/tree/main/2023/Sophos%20Web%20Appliance)
    
### Nuxt Framework - Remote Code Execution. CVE-2023-3224. CVSSv3 Score 9.8.
#### Vulnerability description.
Nuxt Framework is affected by a Remote Code Execution vulnerability inside the nuxt-root.vue component. The root cause of this vulnerability is improper sanitization of user-provided input in the URL by accessing /__nuxt_component_test__/ endpoint. This allows an unauthenticated malicious attacker to execute commands on the Node.js server.
- [Nuxt Framework - Remote Code Execution Exploit]()
