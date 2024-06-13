import argparse, ipaddress, os, signal, subprocess, sys, time
from colorama import Fore, init
from concurrent.futures import ThreadPoolExecutor, as_completed

init(autoreset=True)
DEFAULT_MAX_TIME = 0.5
SAVE_INTERVAL = 10
output_lines = []
last_save_time = time.time()

def signal_handler(sig, frame):
    print("\nScan interrupted by user.")
    os._exit(0)

def scan_ports(target_host, target_ports, max_time):
    global output_lines
    global last_save_time
    try:
        scanned_count = 0
        for port in target_ports:
            try:
                ip_addresses = []
                try:
                    ip_addresses.append(ipaddress.ip_address(target_host))
                except ValueError:
                    try:
                        network = ipaddress.ip_network(target_host)
                        ip_addresses.extend(network.hosts())
                    except ValueError:
                        ip_addresses = [target_host]
                for ip_address in ip_addresses:
                    ip_str = str(ip_address)
                    try:
                        result = subprocess.run(["curl", "-i", f"{ip_str}:{port}", "--max-time", str(max_time)], stdout=subprocess.PIPE, stderr=subprocess.DEVNULL, timeout=2)
                        output = result.stdout.decode('utf-8', 'ignore')
                        if result.returncode == 0 and "ThinVNC" in output:
                            message = f"ThinVNC found on {ip_str}:{port}\n"
                            print(Fore.GREEN + message, end='', flush=True)
                            output_lines.append(f"{ip_str}:{port}")
                           
                            if time.time() - last_save_time > SAVE_INTERVAL:
                                save_results()
                                last_save_time = time.time()
                        else:
                            message = f"ThinVNC not found on {ip_str}:{port}\n"
                            print(Fore.RED + message, end='', flush=True)
                        scanned_count += 1
                    except subprocess.TimeoutExpired:
                        message = f"Timeout occurred while scanning port {port} on {ip_str}"
                        print(message)
                    except subprocess.CalledProcessError as e:
                        message = f"Error on port {port} on {ip_str}: {e.stderr}\n"
                        print(message)
            except:
                pass
    except KeyboardInterrupt:
        print(f"\nScan on {target_host} interrupted by user.")
    return output_lines

def save_results():
    global output_lines
    global args
    if args.output:
        with open(args.output, "a") as file:
            for line in output_lines:
                file.write(line + "\n")
        output_lines = []

if __name__ == "__main__":
    try:
        parser = argparse.ArgumentParser(description="Port scanner with response check")
        parser.add_argument("host", help="Target host address, CIDR notation or filename")
        parser.add_argument("ports", help="Target ports to scan (individual or range, e.g. '1-10' or '80' or '1-10,80' or 1-10,80-90)")
        parser.add_argument("-o", "--output", help="Output file to save successful results")
        args = parser.parse_args()

        ports_ranges = args.ports.split(',')
        target_ports = []
        for port_range in ports_ranges:
            if '-' in port_range:
                start, end = map(int, port_range.split('-'))
                target_ports.extend(range(start, end + 1))
            else:
                target_ports.append(int(port_range))

        try:
            with open(args.host) as file:
                target_hosts = file.read().splitlines()
        except FileNotFoundError:
            target_hosts = [args.host]

        all_output_lines = []
        signal.signal(signal.SIGINT, signal_handler)

        start_time = time.time()

        with ThreadPoolExecutor(max_workers=37) as executor:
            future_to_host = {executor.submit(scan_ports, host, target_ports, DEFAULT_MAX_TIME): host for host in target_hosts}
            for future in as_completed(future_to_host):
                host = future_to_host[future]
                try:
                    output_lines = future.result()
                    all_output_lines.extend(output_lines)
                except Exception as e:
                    message = f"Error occurred while scanning {host}: {str(e)}"
                    print(message)

        end_time = time.time()
        execution_time = end_time - start_time

        if args.output:
            save_results()

        if execution_time < 60:
            print(f"Script execution time: {execution_time:.2f} sec.")
        else:
            print(f"Script execution time: {execution_time/60:.2f} min.")

    except KeyboardInterrupt:
        print("\nScanning interrupted by user.")
        sys.exit(0)
