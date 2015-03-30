FROM ubuntu:14.04.2
MAINTAINER ProXML <yang@proxml.be>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
	apt-get upgrade -y 

RUN apt-get install -y -q openjdk-7-jdk wget curl nano

RUN apt-get update && \
	apt-get install -y -q openssh-server && \
	mkdir /var/run/sshd && \
	echo "root:root" | chpasswd && \
	sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config

RUN wget http://mirrors.dotsrc.org/1060NetKernel/dist/1060-NetKernel-SE/1060-NetKernel-SE-5.2.1.jar

COPY start.sh /

EXPOSE 1060 8080

CMD ["/bin/bash", "start.sh"]
