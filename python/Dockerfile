FROM ubuntu:12.04
MAINTAINER Tenforce <yuanzhe.yang@tenforce.com>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -q update
RUN apt-get -y upgrade
RUN apt-get install -y -q python-software-properties software-properties-common
RUN add-apt-repository -y "deb http://archive.ubuntu.com/ubuntu $(lsb_release -sc) universe"
RUN add-apt-repository -y ppa:chris-lea/node.js
RUN apt-get update

RUN apt-get install -y -q build-essential openssl libreadline6 libreadline6-dev curl git zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt-dev autoconf libc6-dev ncurses-dev automake libtool bison subversion pkg-config libmysqlclient-dev libpq-dev make wget unzip vim nano nodejs mysql-client mysql-server gawk libgdbm-dev libffi-dev postgresql-client openssh-server

RUN apt-get install -y -q python-pip
RUN curl https://bootstrap.pypa.io/ez_setup.py -o - | python
RUN pip install nose
RUN pip install virtualenv
RUN pip install Django

RUN mkdir /var/run/sshd
RUN echo 'root:root' |chpasswd

EXPOSE 8000 22

CMD ["/bin/bash","/vagrant/start.sh"]
