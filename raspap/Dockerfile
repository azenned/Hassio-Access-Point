ARG BUILD_FROM
# hadolint ignore=DL3006
FROM ${BUILD_FROM}

# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN apt-get update
RUN apt-get install -y software-properties-common 
RUN add-apt-repository ppa:ondrej/php
RUN apt-get install -y git iptables iproute2 iw wpasupplicant net-tools
RUN apt-get install -y hostapd qrencode dnsmasq lighttpd vnstat
RUN apt-get install -y dhcpcd5
RUN apt-get install -y php7.4
RUN apt-get install -y netfilter-persistent
RUN apt-get install -y wget
RUN apt-get install -y sudo
RUN apt-get install -y curl
RUN apt-get install -y systemd
RUN apt-get install -y procps
 

RUN curl -sL https://install.raspap.com | bash -s -- --yes --adblock 0 --openvpn 0
 
COPY /rootfs / 
# TODO wpa_supplicant -Dnl80211 -i wlan0 -c/etc/wpa_supplicant/wpa_supplicant.conf

#RUN cp /var/www/html/config/50-raspap-router.conf /etc/lighttpd/conf-available
#RUN rm -rf /etc/lighttpd/conf-enabled/50-raspap-router.conf
#RUN ln -s /etc/lighttpd/conf-available/50-raspap-router.conf /etc/lighttpd/conf-enabled/50-raspap-router.conf

# Build arguments
ARG BUILD_ARCH
ARG BUILD_DATE
ARG BUILD_REF
ARG BUILD_VERSION

# Labels
LABEL \
    io.hass.name="raspap" \
    io.hass.description="raspap" \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION} \
    maintainer="ZENNED <azenned@gmail.com>" \
    org.label-schema.description="raspap" \
    org.label-schema.build-date=${BUILD_DATE} \
    org.label-schema.name="raspap" \
    org.label-schema.schema-version="1.0" \
    org.label-schema.url="https://github.com/azenned/hassio-addons-directory/" \
    org.label-schema.usage="https://github.com/azenned/hassio-addons-directory/tree/master/raspap/tree/master/README.md" \
    org.label-schema.vcs-ref=${BUILD_REF} \
    org.label-schema.vcs-url="https://github.com/azenned/hassio-addons-directory/tree/master/raspap" \
    org.label-schema.vendor="ZENNED"
    
