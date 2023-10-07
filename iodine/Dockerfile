ARG BUILD_FROM
FROM $BUILD_FROM

# Setup base
ARG DEHYDRATED_VERSION
RUN apk add --no-cache openssl wget iptables iproute2 procps iputils-ping iodine jq


# Copy data for add-on
COPY run.sh /
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]
