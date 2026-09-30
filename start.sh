#!/bin/bash
./install.sh <<INNER_EOF
$MEMBERSHIP_KEY
1
n
INNER_EOF
tail -f /dev/null
