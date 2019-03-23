ARG ALPINE_PREFIX
FROM ${ALPINE_PREFIX:-}alpine:edge
MAINTAINER th-docker@thzn.de
ARG ARCH
ARG PROMVERSION

# to allow cross-building of images
ADD qemu-statics /usr/bin/

RUN apk --no-cache add --update ca-certificates

# map $ARCH to simplified prometheus release architecture
RUN echo amd64 > /tmp/prom-arch-amd64 \
	&& echo 386 > /tmp/prom-arch-i386 \
	&& echo armv7 > /tmp/prom-arch-arm32v7 \
	&& echo arm64 > /tmp/prom-arch-arm64v8

# extract in tmp dir `x`
RUN mkdir -p x /etc/prometheus /usr/share/prometheus
RUN wget -O prometheus.tar.gz \
		https://github.com/prometheus/prometheus/releases/download/v$PROMVERSION/prometheus-$PROMVERSION.linux-`cat /tmp/prom-arch-$ARCH`.tar.gz

RUN tar -C x --strip-components=1 -xzf prometheus.tar.gz
RUN mv x/prometheus x/promtool /bin/ && \
    mv x/prometheus.yml /etc/prometheus/prometheus.yml && \
    mv x/consoles x/console_libraries x/NOTICE x/LICENSE /usr/share/prometheus/

RUN ln -s /usr/share/prometheus/console_libraries /usr/share/prometheus/consoles/ /etc/prometheus/

# cleanup
RUN rm -r x prometheus.tar.gz
RUN rm -f /usr/bin/qemu-*-static

EXPOSE     9090
VOLUME     [ "/prometheus" ]
WORKDIR    /prometheus
ENTRYPOINT [ "/bin/prometheus" ]
CMD        [ "--config.file=/etc/prometheus/prometheus.yml", \
             "--storage.tsdb.path=/prometheus", \
             "--web.enable-admin-api", \
             "--web.console.libraries=/usr/share/prometheus/console_libraries", \
             "--web.console.templates=/usr/share/prometheus/consoles" ]
