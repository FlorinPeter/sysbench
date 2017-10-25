FROM alpine:3.4
MAINTAINER Tobias Jakobsson <jakobsson.tobias@gmail.com>

RUN apk add --virtual .build-deps git build-base automake autoconf libtool mariadb-dev vim --update \
  && git clone https://github.com/akopytov/sysbench.git \
  && cd sysbench \
  && ./autogen.sh \
  && ./configure --disable-shared \
  && make \
  && make install \
  && apk del .build-deps \
  && apk add bash mariadb-client-libs

COPY entrypoint.sh /

RUN chmod 777 /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]


