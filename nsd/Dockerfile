ARG IMAGE_PREFIX
FROM ${IMAGE_PREFIX:-}alpine:edge
MAINTAINER th-docker@thzn.de

ADD qemu-statics /usr/bin/

RUN apk add --update nsd

ADD create-zone-config.sh entry.sh /
RUN chmod 0755 /entry.sh /create-zone-config.sh

VOLUME /zones
VOLUME /config

EXPOSE 53/udp
EXPOSE 53

RUN rm -v /usr/bin/qemu-*-static
ENTRYPOINT [ "/entry.sh" ]
