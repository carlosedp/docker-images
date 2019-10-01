#!/bin/bash

for arch in amd64 arm64 arm riscv64 ppc64le; do docker run --rm busybox:1.31-$arch-builder tar cC rootfs . | xz -z9 > "busybox-$arch.tar.xz";done

for arch in amd64 arm64 arm riscv64 ppc64le; do docker build -t carlosedp/busybox:1.31-$arch -f Dockerfile --build-arg=arch=$arch  . ;done

for arch in amd64 arm64 arm riscv64 ppc64le; do docker push carlosedp/busybox:1.31-$arch ;done

ARCHITECTURES_DOCKER="amd64 arm64 arm ppc64le riscv64"
REPO=carlosedp
DOCKER_IMAGE_NAME=busybox
VERSION=1.31
echo docker manifest create --amend ${REPO}/${DOCKER_IMAGE_NAME}:${VERSION} $(echo ${ARCHITECTURES_DOCKER} | sed -e "s~[^ ]*~${REPO}/${DOCKER_IMAGE_NAME}:${VERSION}\-&~g")

for arch in ${ARCHITECTURES_DOCKER}; do echo docker manifest annotate --arch $arch ${REPO}/${DOCKER_IMAGE_NAME}:${VERSION} ${REPO}/${DOCKER_IMAGE_NAME}:${VERSION}-$arch; done\necho docker manifest push --purge ${REPO}/${DOCKER_IMAGE_NAME}:${VERSION}

for arch in amd64 arm64 arm ppc64le riscv64; do docker rmi carlosedp/busybox:1.31-$arch; done
