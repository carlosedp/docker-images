ARG BASEIMAGE
FROM $BASEIMAGE
ARG TARGETARCH

RUN apt-get update && \
    apt-get install -y conntrack \
        ebtables \
        ipset \
        iptables \
        kmod \
        netbase
