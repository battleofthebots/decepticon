# Decepticon

I'm a Decepticon, I BASH in any Autobots that I see!

docker run --rm -p 80:80 ghcr.io/battleofthebots/decepticon

## Description

Based on CVE-2014-6271

This docker container is running an apache2 webserver which competitors will have access to. The webserver doesn't hold the exploit, but rather enables competitors to leverage a vulnerable version of bash (4.2) via a cgi script to gain RCE.

Bash 4.2 is compiled from source: https://ftp.gnu.org/gnu/bash/

Solution script usage: `./solution.sh <server_ip_address> <attacker_ip_address>`

**Note:** The current workingdir for both of these scripts is in */var/www/html/cgi-bin*. The */status* in the endpoints above is aliased to this location.

## Static Flag + Solution

This challenge's static flag will be the associated CVE.

Answer: CVE-2014-6271