ARG BUILD_FROM
FROM $BUILD_FROM


# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

ENV LANG C.UTF-8
RUN apt-get update
RUN apt-get install -y iodine  bash jq iw   net-tools sudo dnsmasq iptables wget 

# Copy data for add-on
COPY run.sh /
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]
