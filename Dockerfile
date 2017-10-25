FROM alpine:3.4
MAINTAINER Tobias Jakobsson <jakobsson.tobias@gmail.com>

RUN apk --update --no-cache add \
	g++ \
	git \
	mariadb-dev \
	bash \
	automake \
	libtool \
	autoconf \
	make \
	vim \
	&& git clone https://github.com/akopytov/sysbench.git \
	&& cd /sysbench && ./autogen.sh && ./configure && make && make install

COPY entrypoint.sh /

RUN chmod 777 /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]


