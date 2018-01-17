[![Docker Pulls](https://img.shields.io/docker/pulls/webispy/artik_devenv_rootfs.svg)](https://hub.docker.com/r/webispy/artik_devenv_rootfs/) [![Docker Build Status](https://img.shields.io/docker/build/webispy/artik_devenv_rootfs.svg)](https://hub.docker.com/r/webispy/artik_devenv_rootfs/)

# ARTIK Developer environment with rootfs

## Fedora

- ARTIK 710/530/520 Fedora root file system ready.

```sh
# ARTIK 710 Fedora
$ docker pull webispy/artik_devenv_rootfs:f710

# ARTIK 530 Fedora
$ docker pull webispy/artik_devenv_rootfs:f530

# ARTIK 520 Fedora
$ docker pull webispy/artik_devenv_rootfs:f520
```

- To use fed-artik-tools, you need to perform the following steps.

```sh
$ docker run -it --privileged --name f710 webispy/artik_devenv_rootfs:f710
➜  ~ fed-artik-init-buildsys
### You may need to wait long time(>5 minutes) to synchronize rpmdb
...
➜  ~ fed-artik-chroot
Disable sslverify option of fedora
[root@e8f619fb9ef8 /]# dnf update
[root@e8f619fb9ef8 /]# exit
➜  ~ exit
```

## Ubuntu

TODO

# Docker images for fed-artik-tools ready 

[![Build Status](https://travis-ci.org/webispy/docker-artik-devenv-rootfs.svg?branch=master)](https://travis-ci.org/webispy/docker-artik-devenv-rootfs)

To save time, you can download images that have already completed the **fed-artik-init-buildsys** and **dnf update** tasks.

```sh
$ docker pull webispy/artik_devenv_f710
$ docker pull webispy/artik_devenv_f530
$ docker pull webispy/artik_devenv_f520
```

These images were created by travis-ci.org.

[![Docker Pulls](https://img.shields.io/docker/pulls/webispy/artik_devenv_f710.svg)](https://hub.docker.com/r/webispy/artik_devenv_f710/) [![Docker Pulls](https://img.shields.io/docker/pulls/webispy/artik_devenv_f530.svg)](https://hub.docker.com/r/webispy/artik_devenv_f530/) [![Docker Pulls](https://img.shields.io/docker/pulls/webispy/artik_devenv_f520.svg)](https://hub.docker.com/r/webispy/artik_devenv_f520/)

# License

[The MIT License](http://opensource.org/licenses/MIT)

Copyright (c) 2018 Inho Oh <webispy@gmail.com>