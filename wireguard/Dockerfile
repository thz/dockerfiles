ARG IMAGE_PREFIX
FROM ${IMAGE_PREFIX:-}alpine:edge
MAINTAINER th-docker@thzn.de

ADD qemu-statics /usr/bin/


RUN grep main /etc/apk/repositories|sed s/main/testing/ >> /etc/apk/repositories
RUN apk add --update bash curl tcpdump wireguard-tools wireguard-go socat

ADD entry.sh /
RUN chmod 0755 /entry.sh

VOLUME /config

EXPOSE 51820/udp

RUN rm -v /usr/bin/qemu-*-static
ENTRYPOINT [ "/entry.sh" ]
