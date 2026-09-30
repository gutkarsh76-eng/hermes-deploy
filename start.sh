#!/bin/bash
sed -i 's/set -u//g' install.sh
sed -i 's/set -euo pipefail/set -eo pipefail/g' install.sh

# Force bash to print every command before executing it
sed -i '2i set -x' install.sh

expect -c '
set timeout -1
spawn bash ./install.sh
expect {
    "*key*" { send "$env(MEMBERSHIP_KEY)\r"; exp_continue }
    "*crew*" { send "1\r"; exp_continue }
    "*Telegram*" { send "n\r"; exp_continue }
    eof
}
'
tail -f /dev/null
