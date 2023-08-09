##  CVE-2023-28121
Wordpress WooCommerce plugin Unauthorized Admin Access

- Google dork:
```
inurl:/wp-content/plugins/woocommerce-payments/
```
- Hunter dork:
```
web.body="/wp-content/plugins/woocommerce-payments/"
```

### Usage
```
# Edit the Username, Password and Email to your own in the exploit.

# Run:
python3 exploit.py http://target.com
```
