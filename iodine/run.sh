#!/usr/bin/with-contenv bashio
#run.sh

set +u

# Enable job control
set -eum

CONFIG_PATH=/data/options.json
IODINE_FLAGS=()

if bashio::config.has_value 'ipv4'; then
    if bashio::config.true 'ipv4'; then
        IODINE_FLAGS+=('-4')
    fi
fi

if bashio::config.has_value 'ipv6'; then
    if bashio::config.true 'ipv6'; then
        IODINE_FLAGS+=('-6')
    fi
fi

if bashio::config.has_value 'skipraw'; then
    if bashio::config.true 'skipraw'; then
        IODINE_FLAGS+=('-r')
    fi
fi

if bashio::config.has_value 'foreground'; then
    if bashio::config.true 'foreground'; then
        IODINE_FLAGS+=('-f')
    fi
fi

if bashio::config.has_value 'fragsize'; then
    TAILSCALED_FLAGS+=('-m', "$(bashio::config 'fragsize')")
fi

if bashio::config.has_value 'namelen'; then
    TAILSCALED_FLAGS+=('-M', "$(bashio::config 'namelen')")
fi

if bashio::config.has_value 'dnsmode'; then
    TAILSCALED_FLAGS+=('-T', "$(bashio::config 'dnsmode')")
fi

if bashio::config.has_value 'encode'; then
    TAILSCALED_FLAGS+=('-O', "$(bashio::config 'encode')")
fi

if bashio::config.has_value 'nameserver'; then
    TAILSCALED_FLAGS+=( "$(bashio::config 'nameserver')")
fi

TAILSCALED_FLAGS+=("$(bashio::config 'topdomain')")

function init_tun(){
    mkdir -p /dev/net
    if [ ! -c /dev/net/tun ]; then
        mknod /dev/net/tun c 10 200
    fi
}

init_tun
echo "launching : iodine -d /dev/net/tun ${IODINE_FLAGS[@]}"
exec iodine -d /dev/net/tun ${IODINE_FLAGS[@]} &  