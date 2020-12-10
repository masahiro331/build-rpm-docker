FROM centos:8
RUN dnf -y update \
    && dnf --enablerepo=powertools install -y  \
       git openssl openssl-devel nspr nspr-devel nss nss-devel \
       file file-devel popt popt-devel wget tar \
       libarchive libarchive-devel strace gdb-gdbserver libdb-devel lzma xz-devel \
       vim make gcc autoconf automake libtool gettext  gettext-devel zlib-devel libgcrypt-devel
RUN git clone https://github.com/rpm-software-management/rpm.git \
    && cd rpm \
    && git checkout rpm-4.14.2-release \
    && ./autogen.sh --noconfigure \
    && sed -i -e 's/-g -O2/-g3 -O0/g' configure \
    && ./configure --with-external-db "CPPFLAGS=-I/usr/include/libdb -I/usr/include/nss3 -I/usr/include/nspr4" --enable-debug --without-lua \
    && make \
    && make install \
    && mkdir -p /usr/local/var/lib/ \
    && cp -r /var/lib/rpm/ /usr/local/var/lib/
CMD ["gdbserver", ":12345", "/rpm/.libs/rpm", "-qa"]
