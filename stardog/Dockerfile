FROM ubuntu:14.04.2
MAINTAINER ProXML <yang@proxml.be>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
	apt-get upgrade -y 

RUN apt-get install -y -q openjdk-7-jdk wget curl nano

RUN apt-get update

RUN 	apt-get install -y -q openssh-server && \
	mkdir /var/run/sshd && \
	echo "root:root" | chpasswd && \
	sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config

COPY stardog-3.0.zip /

RUN apt-get install -y -q unzip && \
	unzip stardog*.zip && \
	mv stardog*/ stardog && \
	export STARDOG_HOME=/stardog

COPY stardog-license-key.bin /stardog/

COPY start.sh /

EXPOSE 5820 22

WORKDIR /stardog

CMD ["/bin/bash", "start.sh"]
