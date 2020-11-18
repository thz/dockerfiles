FROM thzpub/retain:1.1.0 as retain
FROM alpine:3.12

ENV KUBECTL_VERSION=v1.18.12

RUN apk add --no-cache -U \
    bash \
    bridge-utils \
    ca-certificates \
    conntrack-tools \
    curl \
    drill \
    iproute2 \
    iptables \
    iputils \
    ipvsadm \
    jq \
    nginx \
    openssh-client \
    rsync \
    socat \
    tcpdump \
    unzip \
    vim \
    wireguard-tools

RUN curl -Lo /usr/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl && \
    chmod +x /usr/bin/kubectl && \
    kubectl version --short --client

COPY --from=retain /bin/retain /usr/bin/retain
