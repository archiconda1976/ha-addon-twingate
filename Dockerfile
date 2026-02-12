ARG BUILD_FROM=ghcr.io/home-assistant/amd64-base:3.19
FROM $BUILD_FROM

RUN apk add --no-cache curl bash python3

RUN curl -L https://binaries.twingate.com/connector/latest/linux_amd64/twingate-connector     -o /usr/bin/twingate-connector && chmod +x /usr/bin/twingate-connector

COPY run.sh /run.sh
RUN chmod +x /run.sh

CMD [ "/run.sh" ]
