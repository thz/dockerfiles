FROM alpine:edge
MAINTAINER th-docker@thzn.de

RUN apk add --update nsd

ADD create-zone-config.sh entry.sh /
RUN chmod 0755 /entry.sh /create-zone-config.sh

VOLUME /zones
VOLUME /config

EXPOSE 53/udp
EXPOSE 53

ENTRYPOINT [ "/entry.sh" ]
