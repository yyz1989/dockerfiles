FROM ubuntu:14.04.2
MAINTAINER Semantic Web Company <y.yang@semantic-web.at>

ENV DEBIAN_FRONTEND noninteractive
ENV PGUSER postgres
ENV PGPASSWORD unifiedviews
ENV VIRTUOSO_USER dba
ENV VIRTUOSO_PASSWORD dba

RUN apt-get update && \
	apt-get upgrade -y && \
    apt-get update

RUN apt-get install -y -q openjdk-7-jdk wget curl nano maven tomcat7 git postgresql-client

RUN apt-get install -y -q openssh-server && \
	mkdir /var/run/sshd && \
	echo "root:root" | chpasswd && \
	sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config

RUN mkdir unifiedviews && \ 
    mkdir /var/log/unifiedviews && \ 
    mkdir /unifiedviews/config

COPY backend.config.properties /unifiedviews/config/

COPY frontend.config.properties /unifiedviews/config/

RUN wget https://github.com/UnifiedViews/Plugin-DevEnv/archive/UV_Plugin-DevEnv_v2.1.1.tar.gz && \
    tar zxf UV_Plugin-DevEnv*.tar.gz && \
    mv Plugin-DevEnv-UV*/ unifiedviews/plugin-devenv && \
    cd /unifiedviews/plugin-devenv && \
    mvn clean install

RUN wget https://github.com/UnifiedViews/Core/archive/UV_Core_v2.1.1.tar.gz && \
    tar zxf UV_Core*.tar.gz && \
    mv Core-UV*/ unifiedviews/core && \
    cp /unifiedviews/config/frontend.config.properties /unifiedviews/core/frontend/src/main/webapp/WEB-INF/config.properties && \ 
    cd /unifiedviews/core && \
    mvn clean install

COPY init.sh /etc/init.d/

RUN chmod 755 /etc/init.d/init.sh && chmod 777 /var/log/unifiedviews

COPY setenv.sh /usr/share/tomcat7/bin/

RUN chmod 755 /usr/share/tomcat7/bin/setenv.sh && chown tomcat7:tomcat7 /usr/share/tomcat7/bin/setenv.sh

WORKDIR /unifiedviews

COPY start.sh ./

ENV MASTER_API_USER unifiedviews
ENV MASTER_API_PASSWORD unifiedviews

EXPOSE 5010 8080 22

CMD ["/bin/bash", "start.sh"]
