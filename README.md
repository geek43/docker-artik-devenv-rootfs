[![Build Status](https://travis-ci.org/webispy/docker-artik-devenv-rootfs.svg?branch=master)](https://travis-ci.org/webispy/docker-artik-devenv-rootfs)

# Docker images for Fedora(fed-artik-tools) and Ubuntu(sbuild) ready

These images were created by travis-ci.org and hub.docker.com

## ARTIK 710/530/520 Fedora

[![Docker Pulls](https://img.shields.io/docker/pulls/webispy/artik_devenv_f710.svg)](https://hub.docker.com/r/webispy/artik_devenv_f710/) [![Docker Pulls](https://img.shields.io/docker/pulls/webispy/artik_devenv_f530.svg)](https://hub.docker.com/r/webispy/artik_devenv_f530/) [![Docker Pulls](https://img.shields.io/docker/pulls/webispy/artik_devenv_f520.svg)](https://hub.docker.com/r/webispy/artik_devenv_f520/)

To save time, you can download images that have already completed the **fed-artik-init-buildsys** and **dnf update** tasks.

```sh
$ docker pull webispy/artik_devenv_f710
or
$ docker pull webispy/artik_devenv_f530
or
$ docker pull webispy/artik_devenv_f520
```

You can build a RPM package with following commands. The default user for docker image is set to '**work**' (/home/work/).

```sh
# e.g. my sample sources: /home/user/src/sample
#      build result: /home/user/rpm
$ tree /home/user/src/sample
sample
├── main.c
└── packaging
    └── sample.spec

$ docker run -it --rm --privileged \
    -v /home/user/src/sample:/home/work/sample \
    -v /home/user/rpm:/home/work/FED_ARTIK_ROOT/repos/24/armv7hl/RPMS \
    webispy/artik_devenv_f710 \
    bash -c "cd /home/work/sample && fed-artik-build"

$ ls /home/user/rpm
sample.fc24.armv7hl.rpm
sample-debuginfo.fc24.armv7hl.rpm
```

## ARTIK 710/530 Ubuntu

[![Docker Pulls](https://img.shields.io/docker/pulls/webispy/artik_devenv_u710.svg)](https://hub.docker.com/r/webispy/artik_devenv_u710/) [![Docker Pulls](https://img.shields.io/docker/pulls/webispy/artik_devenv_u530.svg)](https://hub.docker.com/r/webispy/artik_devenv_u530/)

To save time, you can download images that have already completed the **mk-sbuild** and **apt update && apt upgrade** tasks.

```sh
$ docker pull webispy/artik_devenv_u710
or
$ docker pull webispy/artik_devenv_u530
```

You can build a DEB package with following commands. The default user for docker image is set to '**work**' (/home/work/).

```sh
# e.g. my sample sources: /home/user/src/sample
#      build result: /home/user/src
$ tree /home/user/src/sample
sample
├── main.c
└── debian
    ├── changelog
    ├── compat
    ├── control
    ├── copyright
    ├── sample.install
    └── rules

# 710 (arm64)
$ docker run -it --rm --privileged \
    -v /home/user/src/sample:/home/work/sample \
    webispy/artik_devenv_u710 \
    bash -c "cd /home/work/sample && sbuild --chroot xenial-arm64 --arch arm64"

# 530 (armhf)
$ docker run -it --rm --privileged \
    -v /home/user/src/sample:/home/work/sample \
    webispy/artik_devenv_u530 \
    bash -c "cd /home/work/sample && sbuild --chroot xenial-armhf --arch armhf"

$ ls /home/user/src
sample/
sample_arm64.deb
sample-dbg_arm64.deb
sample.tar.gz
```

# How to create a image manually

Please refer to the following files.

## Fedora

[![Docker Pulls](https://img.shields.io/docker/pulls/webispy/artik_devenv_rootfs.svg)](https://hub.docker.com/r/webispy/artik_devenv_rootfs/) [![Docker Build Status](https://img.shields.io/docker/build/webispy/artik_devenv_rootfs.svg)](https://hub.docker.com/r/webispy/artik_devenv_rootfs/)

- [build_fedora.sh](build_fedora.sh)
- [f710/Dockerfile](f710/Dockerfile) - **webispy/artik_devenv** image + ARTIK 710 fedora rootfs
- [f530/Dockerfile](f530/Dockerfile) - **webispy/artik_devenv** image + ARTIK 530 fedora rootfs
- [f520/Dockerfile](f520/Dockerfile) - **webispy/artik_devenv** image + ARTIK 520 fedora rootfs

You can download the rootfs from https://github.com/SamsungARTIK/fedora-spin-kickstarts/releases

## Ubuntu

- [build_ubuntu.sh](build_ubuntu.sh)

More information can be found at https://github.com/SamsungARTIK/ubuntu-build-service

# License

[The MIT License](http://opensource.org/licenses/MIT)

Copyright (c) 2018 Inho Oh <webispy@gmail.com>
