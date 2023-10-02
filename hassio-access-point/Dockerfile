ARG BUILD_FROM
FROM $BUILD_FROM

MAINTAINER Matt Longman <git@mattlongman.com>

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

ENV LANG C.UTF-8

RUN apk update && \
apk add --no-cache bash jq iw hostapd networkmanager networkmanager-cli net-tools sudo dnsmasq iptables && \
rm -rf /var/cache/apk/*

COPY hostapd.conf /
COPY dnsmasq.conf /

RUN mkdir -p "/lib/firmware/cypress"
RUN mkdir -p "/lib/firmware/brcm"
COPY cyfmac43455-sdio-minimal.bin /lib/firmware/cypress/
RUN ln -sf /lib/firmware/cypress/cyfmac43455-sdio-minimal.bin /lib/firmware/brcmfmac43455-sdio.bin
RUN ln -sf /lib/firmware/cypress/cyfmac43455-sdio-minimal.bin /lib/firmware/brcmfmac43455-sdio.raspberrypi,4-model-b.bin
RUN chmod +x /lib/firmware/cypress/* 
RUN chmod +x /lib/firmware/*

COPY run.sh /
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]
