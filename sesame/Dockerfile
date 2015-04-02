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

RUN wget http://apache.belnet.be/tomcat/tomcat-8/v8.0.21/bin/apache-tomcat-8.0.21.tar.gz && \
	wget http://switch.dl.sourceforge.net/project/sesame/Sesame%202/2.8.1/openrdf-sesame-2.8.1-sdk.tar.gz

RUN apt-get install -y -q tar && \
	tar xzvf apache-tomcat*.gz && \
	mv apache-tomcat*/ tomcat

RUN tar xzvf openrdf*.gz && \
	mv openrdf*/ sesame

RUN mv /sesame/war/*.war /tomcat/webapps/

COPY start.sh /

EXPOSE 8080 22

CMD ["/bin/bash", "start.sh"]
