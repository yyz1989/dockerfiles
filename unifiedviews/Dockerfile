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

RUN mkdir unifiedviews

RUN wget https://github.com/UnifiedViews/Plugin-DevEnv/archive/UV_Plugin-DevEnv_v2.1.1.tar.gz && \
    tar zxf UV_Plugin-DevEnv*.tar.gz && \
    mv Plugin-DevEnv-UV*/ unifiedviews/plugin-devenv && \
    cd /unifiedviews/plugin-devenv && \
    mvn clean install

RUN wget https://github.com/UnifiedViews/Core/archive/UV_Core_v2.1.1.tar.gz && \
    tar zxf UV_Core*.tar.gz && \
    mv Core-UV*/ unifiedviews/core && \
    cd /unifiedviews/core && \
    mvn clean install

WORKDIR /unifiedviews/core/db/postgresql

RUN psql -h ${POSTGRES_PORT_5432_TCP_ADDR} -p ${POSTGRES_PORT_5432_TCP_PORT} -c "create database unifiedviews;"
    psql -h ${POSTGRES_PORT_5432_TCP_ADDR} -p ${POSTGRES_PORT_5432_TCP_PORT} -d unifiedviews -f schema.sql && \
    psql -h ${POSTGRES_PORT_5432_TCP_ADDR} -p ${POSTGRES_PORT_5432_TCP_PORT} -d unifiedviews -f data-core.sql && \
    psql -h ${POSTGRES_PORT_5432_TCP_ADDR} -p ${POSTGRES_PORT_5432_TCP_PORT} -d unifiedviews -f data-permissions.sql

RUN mkdir /var/log/unifiedviews

COPY backend.config.properties /unifiedviews/core/backend/target/config.properties

RUN cp /unifiedviews/core/frontend/target/unifiedviews.war /var/lib/tomcat7/webapps/ && \
    service tomcat7 restart

COPY frontend.config.properties /var/lib/tomcat7/webapps/unifiedviews/WEB-INF/config.properties

EXPOSE 5010 8080 22

COPY start.sh /unifiedviews/

WORKDIR /unifiedviews

CMD ["/bin/bash", "start.sh"]
