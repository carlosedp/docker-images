#!/bin/bash

ARCHITECTURES='amd64 arm64 armhf ppc64le riscv64'
PORTS_ARCH=riscv64
SUITE=unstable
TIMESTAMP='2019-08-01T00:00:00Z'
dir=$(date --date "$TIMESTAMP" -u +%Y%m%d)
VARIANTS='slim'
REPO=carlosedp

for arch in $ARCHITECTURES; do
	args=( --arch="$arch" )
	if [[ $arch =~ $PORTS_ARCH ]]; then
		args+=( --ports )
	fi
	args+=( rootfs )
	args+=( $SUITE )
	args+=( $TIMESTAMP )
	sudo ./build.sh ${args[@]}
done

# for v in '.' $VARIANTS; do
	
# 	cat > "Dockerfile.img" <<-'EOF'
# 	FROM scratch
# 	ARG TARGETARCH
# 	ARG dir
# 	ARG v
# 	ARG SUITE
# 	ADD rootfs/$dir/$TARGETARCH/$SUITE/$v/rootfs.tar.xz /
# 	CMD ['bash']
# 	EOF

# 	if [ $v == '.' ]; then
# 		TAG=''
# 	else
# 		TAG='-slim'
# 	fi

# 	echo docker buildx build --platform linux/arm64,linux/amd64,linux/riscv64,linux/armhf -t $REPO/debian:sid$TAG -f Dockerfile.img --build-arg dir=$dir --build-arg=v=$v --build-arg=SUITE=$SUITE  . --push

# done