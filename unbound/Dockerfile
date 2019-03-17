ARG IMAGE_PREFIX
FROM ${IMAGE_PREFIX:-}alpine:edge
MAINTAINER th-docker@thzn.de

ADD qemu-statics /usr/bin/

RUN apk add --update unbound vim drill tcpdump

ADD entry.sh /
RUN chmod 0755 /entry.sh

VOLUME /config

EXPOSE 53/udp
EXPOSE 53

RUN rm -v /usr/bin/qemu-*-static
ENTRYPOINT [ "/entry.sh" ]
