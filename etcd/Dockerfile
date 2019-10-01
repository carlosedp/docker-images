FROM carlosedp/debian:sid-slim
ARG TARGETARCH
ENV arch=$TARGETARCH
ENV ETCD_UNSUPPORTED_ARCH=riscv64
EXPOSE 2379 2380 4001 7001
COPY etcd-$arch /usr/local/bin/etcd
COPY etcdctl-$arch /usr/local/bin/etcdctl
COPY migrate-if-needed.sh migrate /usr/local/bin/
