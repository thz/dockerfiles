ARG RETAINVERSION
FROM thzpub/retain:${RETAINVERSION} as retain

ARG ARCH_PREFIX
FROM ${ARCH_PREFIX:-}postgres:12.0-alpine
MAINTAINER th-docker@thzn.de

ADD qemu-statics /usr/bin/

RUN apk --update add \
	bash \
	curl \
	jq \
	py-pip \
	python \
	socat
RUN pip install awscli

COPY --from=retain /bin/retain /usr/bin/retain

ENTRYPOINT [ "/bin/bash" ]
