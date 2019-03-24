ARG ALPINE_PREFIX
FROM ${ALPINE_PREFIX:-}alpine:latest as arch_select_stage

FROM golang as buildstage

ARG ARCH
ARG RETAINVERSION

# map $ARCH to GOARCH values:
RUN echo amd64 > /tmp/goarch-amd64 \
		&& echo 386 > /tmp/goarch-i386 \
		&& echo arm > /tmp/goarch-arm32v7 \
		&& echo arm64 > /tmp/goarch-arm64v8

RUN env \
	GOPATH=/go \
	GO111MODULE=on \
	GOARCH=`cat /tmp/goarch-$ARCH` \
		go get github.com/thz/retain@v$RETAINVERSION
RUN find /go/bin -name retain | xargs -I^ mv -v ^ /usr/bin

ARG ALPINE_PREFIX
FROM ${ALPINE_PREFIX:-}alpine:latest as runstage
MAINTAINER th-docker@thzn.de

# to allow cross-building of images
ADD qemu-statics /usr/bin/

RUN apk --no-cache add --update ca-certificates bash rsync openssh-client curl jq

COPY --from=buildstage /usr/bin/retain /usr/bin/retain

# cleanup
RUN rm -f /usr/bin/qemu-*-static
