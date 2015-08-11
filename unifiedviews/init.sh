#!/bin/bash

if [ ! -f /unifiedviews/core/backend/target/config.properties ]; then
    cp /unifiedviews/config/backend.config.properties /unifiedviews/core/backend/target/config.properties
    cd /unifiedviews/core/db/postgresql
    psql -h ${POSTGRES_PORT_5432_TCP_ADDR} -p ${POSTGRES_PORT_5432_TCP_PORT} -c "create database unifiedviews;"
    psql -h ${POSTGRES_PORT_5432_TCP_ADDR} -p ${POSTGRES_PORT_5432_TCP_PORT} -d unifiedviews -f schema.sql
    psql -h ${POSTGRES_PORT_5432_TCP_ADDR} -p ${POSTGRES_PORT_5432_TCP_PORT} -d unifiedviews -f data-core.sql
    psql -h ${POSTGRES_PORT_5432_TCP_ADDR} -p ${POSTGRES_PORT_5432_TCP_PORT} -d unifiedviews -f data-permissions.sql
    cp /unifiedviews/core/frontend/target/unifiedviews.war /var/lib/tomcat7/webapps/
    service tomcat7 restart
    service tomcat7 stop
    cp /unifiedviews/config/frontend.config.properties /var/lib/tomcat7/webapps/unifiedviews/WEB-INF/config.properties    
    exit 0
fi  
