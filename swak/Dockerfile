FROM thzpub/retain:1.1.0 as retain
FROM alpine:3.10

ENV KUBECTL_VERSION=v1.15.4

RUN apk add --no-cache -U \
    bash \
    bridge-utils \
    ca-certificates \
    conntrack-tools \
    curl \
    iproute2 \
    iptables \
    ipvsadm \
    jq \
    nginx \
    openssh-client \
    rsync \
    socat \
    tcpdump \
    unzip \
    vim

RUN curl -Lo /usr/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl && \
    chmod +x /usr/bin/kubectl && \
    kubectl version --short --client

COPY --from=retain /bin/retain /usr/bin/retain
