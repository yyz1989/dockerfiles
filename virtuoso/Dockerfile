FROM ubuntu:14.04.2
MAINTAINER ProXML <yang@proxml.be>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
	apt-get upgrade -y 

RUN apt-get update

RUN apt-get install -y -q gcc autoconf automake libtool flex bison gperf gawk m4 make libssl-dev libreadline6 libreadline6-dev tar wget curl nano

RUN apt-get install -y -q openssh-server && \
	mkdir /var/run/sshd && \
	echo "root:root" | chpasswd && \
	sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# RUN wget --quota=1 https://github.com/openlink/virtuoso-opensource/releases/download/v7.2.1/virtuoso-opensource-7.2.1.tar.gz
COPY virtuoso-opensource-7.2.1.tar.gz /

RUN tar xzf virtuoso*.gz && \
	mv virtuoso*/ virtuoso

WORKDIR /virtuoso

RUN ./configure --with-readline 

RUN make

RUN make install

RUN ln -s /usr/local/virtuoso-opensource/var/lib/virtuoso/ /var/lib/virtuoso

ENV PATH /usr/local/virtuoso-opensource/bin/:$PATH

COPY start.sh /

WORKDIR /var/lib/virtuoso/db

EXPOSE 8890 1111 22

VOLUME /usr/local/virtuoso-opensource/var/lib/virtuoso/db

CMD ["/bin/bash", "/start.sh"]
