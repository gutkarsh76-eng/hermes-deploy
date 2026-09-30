#!/bin/bash

# Remove strict bash checking that causes the unbound variable crash
sed -i 's/set -u//g' install.sh
sed -i 's/set -euo pipefail/set -eo pipefail/g' install.sh

# Run the installer inside a simulated virtual terminal
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

# Keep the container running
tail -f /dev/null
