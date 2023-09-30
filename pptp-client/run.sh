#!/usr/bin/env bash
#run.sh

set +u

CONFIG=/data/options.json

SERVER="$(jq --raw-output '.server' $CONFIG)"
USERNAME="$(jq --raw-output '.username' $CONFIG)"
PASSWORD="$(jq --raw-output '.password' $CONFIG)"
TUNNEL="vpn"

cat > /etc/ppp/peers/${TUNNEL} <<_EOF_
pty "pptp ${SERVER} --nolaunchpppd"
name "${USERNAME}"
password "${PASSWORD}"
remotename PPTP
require-mppe-128
require-mschap-v2
persist  
maxfail 10 
holdoff 15 
file /etc/ppp/options.pptp
ipparam "${TUNNEL}"
_EOF_

cat > /etc/ppp/ip-up <<"_EOF_"
#!/bin/sh
ip route add 0.0.0.0/1 dev $1
ip route add 128.0.0.0/1 dev $1
_EOF_

cat > /etc/ppp/ip-down <<"_EOF_"
#!/bin/sh
ip route del 0.0.0.0/1 dev $1
ip route del 128.0.0.0/1 dev $1
_EOF_

exec pon ${TUNNEL} debug dump logfd 2 nodetach persist "$@"