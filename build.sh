#!/bin/sh
set -e

if [ "$#" -ne 1 ]; then
    echo "Illegal number of parameters"
	exit 1
fi

docker pull webispy/artik_devenv_rootfs:$1

# The "--privileged" option is required because we should run the
# "mount --bind" command inside the container.
docker create -it --privileged --name $1 webispy/artik_devenv_rootfs:$1

docker start $1
docker exec -t $1 bash -c 'fed-artik-init-buildsys && sudo -H chroot_fedora /home/work/FED_ARTIK_ROOT/BUILDROOT "dnf update -y"'
docker stop $1

# Create a docker image using container
docker commit $1 webispy/artik_devenv_$1

# Remove container
docker rm $1

