# ARTIK 710 Ubuntu
#

FROM webispy/artik_devenv:latest
LABEL maintainer="webispy@gmail.com" \
      version="0.1" \
      description="ARTIK Development environment for ARTIK 710 Ubuntu"

ENV ROOTFS=ubuntu-arm-artik710-rootfs-0710GC0F-44U-01Q3-20171113.171659-d159d7ed4107f1a6124c7937c24327aa.tar.gz \
    SYSROOT=/opt/sysroot/ \
    CROSS_COMPILE=/usr/bin/aarch64-linux-gnu- \
    CMAKE_PKG_CONFIG_PATH=$SYSROOT/usr/lib/aarch64-linux-gnu/pkgconfig/ \
    CHROOT_PATH=/var/lib/schroot/chroots/artik710-arm64

RUN wget https://github.com/SamsungARTIK/ubuntu-build-service/releases/download/release%2FA710_os_3.1.0/$ROOTFS \
		&& sudo mkdir -p $CHROOT_PATH \
		&& sudo tar xvf $ROOTFS -C $CHROOT_PATH >/dev/null\
		&& rm $ROOTFS \
		&& sudo cp /usr/bin/qemu-aarch64-static $CHROOT_PATH/usr/bin/ \
		&& sudo mkdir -p /opt/sysroot/usr/ \
		&& sudo ln -s $CHROOT_PATH/usr/include /opt/sysroot/usr/ \
		&& sudo ln -s $CHROOT_PATH/usr/lib /opt/sysroot/usr/ \
		&& sudo ln -s $CHROOT_PATH/lib /opt/sysroot/

COPY sbuild-artik710-arm64 /etc/schroot/chroot.d/

CMD ["zsh"]
