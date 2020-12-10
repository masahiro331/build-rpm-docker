# Build RPM command

## Quick Build

```
$ git clone https://github.com/masahiro331/build-rpm-docker.git
$ docker build -t masahiro331/rpm .
```

## Update rpm command

```
$ docker run -it masahiro331/rpm /bin/bash
$ cd /rpm
$ # edit rpm source code....
$ : vim rpm.c
$ make
$ make install
```

## Test rpmdb

```
$ # If you want to test Packages(rpmdb) file
$ # Update Packages(rpmdb) file
$ : dnf install nodejs
$ cp -r /var/lib/rpm/ /usr/local/var/lib/
$ rpm -q nodejs --qf "%{NAME} %{EPOCH} %{MODURALITYLABEL}"
```
