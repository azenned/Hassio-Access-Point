#!/usr/bin/env bash
#run.sh

set +u

CONFIG=/data/options.json

NAMESERVER="$(jq --raw-output '.nameserver' $CONFIG)"
TOPDOMAIN="$(jq --raw-output '.topdomain' $CONFIG)"
PASSWORD="$(jq --raw-output '.password' $CONFIG)"
FRAGSIZE="$(jq --raw-output '.fragsize' $CONFIG)"
NAMELEN="$(jq --raw-output '.namelen' $CONFIG)"
DNSMODE="$(jq --raw-output '.dnsmode' $CONFIG)"
ENCODE="$(jq --raw-output '.encode' $CONFIG)" 

function init_tun(){
    mkdir -p /dev/net
    if [ ! -c /dev/net/tun ]; then
        mknod /dev/net/tun c 10 200
    fi
}

init_tun
exec iodine -d /dev/net/tun -c -f -m ${FRAGSIZE} -M ${NAMELEN} -P "${PASSWORD}" -T ${DNSMODE} -r -O ${ENCODE} ${NAMESERVER} ${TOPDOMAIN}  "$@"