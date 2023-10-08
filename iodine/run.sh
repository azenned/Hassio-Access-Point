#!/usr/bin/with-contenv bashio
#run.sh

set +u

# Enable job control
set -eum

CONFIG_PATH=/data/options.json
IODINE_FLAGS=()
TUNDEVICE=dns0
if bashio::config.has_value 'tundevice'; then
    if bashio::config.true 'tundevice'; then
        mkdir -p /dev/net
        if [ ! -c /dev/net/tun ]; then
            mknod /dev/net/tun c 10 200
        fi
        IODINE_FLAGS+=('-d tun')
        TUNDEVICE=tun
    fi
fi

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
    IODINE_FLAGS+=("-m $(bashio::config 'fragsize')")
fi

if bashio::config.has_value 'namelen'; then
    IODINE_FLAGS+=("-M $(bashio::config 'namelen')")
fi

if bashio::config.has_value 'dnsmode'; then
    IODINE_FLAGS+=("-T $(bashio::config 'dnsmode')")
fi

if bashio::config.has_value 'encode'; then
    IODINE_FLAGS+=("-O $(bashio::config 'encode')")
fi

if bashio::config.has_value 'password'; then
    IODINE_FLAGS+=("-P $(bashio::config 'password')")
fi

if bashio::config.has_value 'nameserver'; then
    IODINE_FLAGS+=("$(bashio::config 'nameserver')")
fi

IODINE_FLAGS+=("$(bashio::config 'topdomain')")

if bashio::config.has_value 'forward'; then
    if bashio::config.true 'forward'; then
    INTERFACE=wlan0
    if bashio::config.has_value 'networkdevice'; then
        INTERFACE=("$(bashio::config 'networkdevice')")
    fi

    iptables -P FORWARD DROP
    iptables -t nat -A POSTROUTING -o $INTERFACE -j MASQUERADE
    iptables -t filter -A FORWARD -i $INTERFACE -o $TUNDEVICE -m state --state RELATED,ESTABLISHED -j ACCEPT

    if bashio::config.has_value 'iptables'; then
        IPTABLES=("$(bashio::config 'iptables')")
    else
        IPTABLES="iptables -t filter -A FORWARD -i $TUNDEVICE -o $INTERFACE -j ACCEPT" &&
        echo "WARN: Using standard IP tables rules - all traffic will be forwarded."; 
    fi
    $IPTABLES
fi

set -x
echo "launching : iodine ${IODINE_FLAGS[@]}"
exec iodine  ${IODINE_FLAGS[@]}