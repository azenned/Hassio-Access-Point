ARG BUILD_ARCH
FROM homeassistant/${BUILD_ARCH}-base-debian:latest

ARG BUILD_ARCH

ENV LANG C.UTF-8
RUN apt update
RUN apt install -y wget iptables iproute2 procps iputils-ping iodine jq

# Use legacy iptables not nftables, see https://wiki.debian.org/iptables
RUN update-alternatives --set iptables /usr/sbin/iptables-legacy
RUN update-alternatives --set ip6tables /usr/sbin/ip6tables-legacy


# Copy data for add-on
COPY run.sh /
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]
