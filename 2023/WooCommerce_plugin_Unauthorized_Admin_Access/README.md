##  CVE-2023-28121
![](https://img.shields.io/static/v1?label=Product&message=Wordpress&color=blue)
![](https://img.shields.io/static/v1?label=Version&message=WooCommerce%20plugin%205.6.1%20and%20lower&color=brighgreen)
![](https://img.shields.io/static/v1?label=Vulnerability&message=CVSSv3:%209.8.%20Unauthorized%20Admin%20Access&color=red)



- Google dork:
```
inurl:/wp-content/plugins/woocommerce-payments/
```
- [Hunter](https://hunter.how) dork:
```
web.body="/wp-content/plugins/woocommerce-payments/"
```

### Usage
```
# Edit the Username, Password and Email to your own in the exploit.

# Run:
python3 exploit.py http://target.com
```
