#!/bin/sh
set -ev

if [ "$#" -ne 1 ]; then
    echo "Illegal number of parameters"
	exit 1
fi

docker pull webispy/artik_devenv

# The "--privileged" option is required because we should run the
# "mount --bind" command inside the container.
docker create -it --privileged --name $1 webispy/artik_devenv

docker start $1
case "$1" in
	"u710")
		docker exec -t $1 bash -c "mk-sbuild --arch arm64 xenial && sudo sed -i 's/^union-type=.*/union-type=overlay/' /etc/schroot/chroot.d/sbuild-xenial-arm64 && sbuild-update xenial-arm64 && sbuild-upgrade xenial-arm64"
		;;

	"u530")
		docker exec -t $1 bash -c "mk-sbuild --arch armhf xenial && sudo sed -i 's/^union-type=.*/union-type=overlay/' /etc/schroot/chroot.d/sbuild-xenial-armhf && sbuild-update xenial-armhf && sbuild-upgrade xenial-armhf"
		;;

	"u710cross")
		docker exec -t $1 bash -c "mk-sbuild --target arm64 xenial && sudo sed -i 's/^union-type=.*/union-type=overlay/' /etc/schroot/chroot.d/sbuild-xenial-amd64-arm64 && sbuild-update xenial-amd64-arm64 && sbuild-upgrade xenial-amd64-arm64"
		;;

	"u530cross")
		docker exec -t $1 bash -c "mk-sbuild --target armhf xenial && sudo sed -i 's/^union-type=.*/union-type=overlay/' /etc/schroot/chroot.d/sbuild-xenial-amd64-armhf && sbuild-update xenial-amd64-armhf && sbuild-upgrade xenial-amd64-armhf"
		;;
	*)
		exit 1
esac
docker stop $1

# Create a docker image using container
docker commit --change='CMD ["zsh"]' $1 webispy/artik_devenv_$1

# Remove container
docker rm $1

