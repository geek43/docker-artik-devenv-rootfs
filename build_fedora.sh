#!/bin/bash
set -ev

if [ "$#" -ne 1 ]; then
	echo "Illegal number of parameters"
	exit 1
fi

if [ "$1" = "f710" ]; then
	ROOTFS=fedora-arm-artik710-rootfs-0710GC0F-44F-01QC-20170713.175433-f63a17cbfdaffd3385f23ea12388999a.tar.gz
	URL=https://github.com/SamsungARTIK/fedora-spin-kickstarts/releases/download/release%2FA710_os_2.2.0/$ROOTFS
elif [ "$1" = "f530" ]; then
	ROOTFS=fedora-arm-artik530-rootfs-0530GC0F-44F-01Q4-20170425.192021-1e007ebbf12d9c7499be3a4b9e9d8e6a.tar.gz
	URL=https://github.com/SamsungARTIK/fedora-spin-kickstarts/releases/download/release%2FA530_os_2.0.0/$ROOTFS
elif [ "$1" = "f520" ]; then
	ROOTFS=fedora-arm-artik5-rootfs-0520GC0F-3AF-01Q6-20160928.203457-0e632fcf9ee1badf5724751af6bd0670.tar.gz
	URL=https://github.com/SamsungARTIK/fedora-spin-kickstarts/releases/download/release%2FA520_os_2.0.0/$ROOTFS
else
	echo "Not supported target: $1"
	exit 1
fi

if [ "$1" = "f520" ]; then
	# 520 not support artik.repo
	SCRIPT="wget $URL \
		&& fed-artik-host-init-buildsys -I $ROOTFS \
		&& fed-artik-init-buildsys \
		&& rm $ROOTFS \
		&& sudo -H chroot_fedora /home/work/FED_ARTIK_ROOT/BUILDROOT \"dnf update -y\""
else
	SCRIPT="wget $URL \
		&& fed-artik-host-init-buildsys -I $ROOTFS \
		&& fed-artik-init-buildsys \
		&& rm $ROOTFS \
		&& sudo sed -i 's/#baseurl/baseurl/' /home/work/FED_ARTIK_ROOT/BUILDROOT/etc/yum.repos.d/artik.repo \
		&& sudo -H chroot_fedora /home/work/FED_ARTIK_ROOT/BUILDROOT \"dnf update -y\""
fi

echo $SCRIPT

docker pull webispy/artik_devenv

# The "--privileged" option is required because we should run the
# "mount --bind" command inside the container.
docker run -t --privileged --name $1 webispy/artik_devenv bash -c "$SCRIPT"

# Create a docker image using container
docker commit --change='CMD ["zsh"]' $1 webispy/artik_devenv_$1

# Remove container
docker rm $1

