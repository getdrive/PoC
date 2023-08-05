# CVE-2023-25135

### Pre-authentication RCE

See: https://www.ambionics.io/blog/vbulletin-unserializable-but-unreachable

#### Netlas Dork.
- [Search Link](https://app.netlas.io/responses/?page=1&q=tag.vbulletin.version%3A%3C%3D5.6.9)
```
 tag.vbulletin.version:<=5.6.9

```

```
python3 rce_exploit.py --help                 
Usage: rce_exploit.py [-h] [-p PROXY] url command

Exploit for CVE-2023-25135: vBulletin pre-authentication RCE.

Positional Arguments:
  url                   Target URL
  command               Command to execute

Options:
  -h, --help            show this help message and exit
  -p, --proxy PROXY     Proxy to use (optional)
 ```
