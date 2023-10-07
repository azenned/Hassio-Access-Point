ARG BUILD_FROM
FROM $BUILD_FROM

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

ENV LANG C.UTF-8

RUN apk update && \
apk add --no-cache bash jq iw   networkmanager networkmanager-cli net-tools sudo dnsmasq openssl wget iptables iproute2 procps iputils-ping iodine jq && \
rm -rf /var/cache/apk/* /tmp/* 

# Copy data for add-on
COPY run.sh /
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]
