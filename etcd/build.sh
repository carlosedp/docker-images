for arch in amd64 arm arm64 riscv64 ppc64le; do CGO_ENABLED=0 GOOS=linux GOARCH=$arch gob -o coredns-$arch .; done

docker buildx build -t ${REPO}/coredns:1.6.2 --platform linux/amd64,linux/arm64,linux/ppc64le,linux/arm,linux/riscv64 --push -f Dockerfile.custom --no-cache .
