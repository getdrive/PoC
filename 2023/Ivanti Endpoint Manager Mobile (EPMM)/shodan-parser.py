import ipaddress
import json
import os
import time

import click


@click.command(context_settings=dict(help_option_names=['-h', '--help']))
@click.version_option(version='1.0.0', prog_name="Shodan Parser")
@click.argument('shodan_json_file')
@click.option('-o', '--output', show_default=True, default='targets.txt',
              help='Path to output file with parsed data. IP:PORT format, one entry per line')
@click.option('-v', '--verbose', is_flag=True, show_default=True, help='Verbose mode')
@click.option('-n', '--log-every', show_default=True, default=100,
              help='Show log after specified number of entries parsed. Effective only in verbose mode')
def cli(shodan_json_file, output, verbose, log_every):
    """This script will parse JSON data exported from SHODAN and create IP:PORT formatted list to be used
        with other tools. To run specify path to a file with JSON data from SHODAN."""

    if not os.path.exists(shodan_json_file):
        print('\nError: Provided input file does not exist')
        exit(1)

    with open(shodan_json_file) as jsonFile, open(output, 'w') as fileToWrite:
        print('\n[+] STARTING')
        printIfVerbose(verbose, f'[+] Opened [{jsonFile.name}] to parse json data from')
        printIfVerbose(verbose, f'[+] Opened [{fileToWrite.name}] to write to')

        correctIpCounter = 0
        incorrectIpCounter = 0
        loopCounter = 0

        printIfVerbose(verbose, '[+] Parsing data')
        startTime = time.time()

        for line in jsonFile:
            jsonObject = json.loads(line)
            ip = jsonObject.get('ip_str')
            port = str(jsonObject.get('port'))

            try:
                if ipaddress.ip_address(ip):
                    writableOutput = f'{ip}:{port}'
                    fileToWrite.write("%s\n" % writableOutput)
                    correctIpCounter += 1
            except ValueError:
                incorrectIpCounter += 1
                printIfVerbose(verbose, '[!] Incorrect IP found')

            if loopCounter % log_every == 0 and loopCounter != 0:
                printIfVerbose(verbose,
                               f'[+] Lines parsed so far: {loopCounter} | Time elapsed: {round(time.time() - startTime, 3)} seconds')

            loopCounter += 1

        print('\n[+] FINISHED')
        print(f'[+] Finished parsing in {round(time.time() - startTime, 3)} seconds')
        print('\n[+] RESULTS')
        print(f'[+] IPs parsed correctly: {correctIpCounter}')
        print(f'[+] IPs incorrect: {incorrectIpCounter}')


def printIfVerbose(isVerbose, message):
    if isVerbose:
        print(message)


if __name__ == '__main__':
    cli()
