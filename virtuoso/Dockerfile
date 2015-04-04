FROM ubuntu:14.04.2
MAINTAINER ProXML <yang@proxml.be>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
	apt-get upgrade -y 

RUN apt-get install -y -q gcc autoconf automake libtool flex bison gperf gawk m4 make libssl-dev libreadline6 libreadline6-dev tar wget curl nano

RUN apt-get install -y -q openssh-server && \
	mkdir /var/run/sshd && \
	echo "root:root" | chpasswd && \
	sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config

RUN wget https://github.com/openlink/virtuoso-opensource/releases/download/v7.2.0.1/virtuoso-opensource-7.2.0_p1.tar.gz

RUN tar xzf virtuoso*.gz && \
	mv virtuoso*/ virtuoso

WORKDIR /virtuoso

RUN ./configure --with-readline 

RUN nice make

RUN nice make install

COPY start.sh /

EXPOSE 8890 22

CMD ["/bin/bash", "start.sh"]
