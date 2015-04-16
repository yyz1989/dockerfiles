FROM ubuntu:14.04.2
MAINTAINER ProXML <yang@proxml.be>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
	apt-get upgrade -y 

RUN apt-get install -y -q openjdk-7-jdk wget curl nano

RUN apt-get update

RUN apt-get install -y -q openssh-server && \
	mkdir /var/run/sshd && \
	echo "root:root" | chpasswd && \
	sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config

COPY marklogic_8.0-2_amd64.deb /

RUN dpkg -i /marklogic_8.0-2_amd64.deb

COPY start.sh /

EXPOSE 8000 8001 8002 22

CMD ["/bin/bash", "start.sh"]
