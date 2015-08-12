#!/bin/bash
### BEGIN INIT INFO
# Provides:          init.sh
# Required-Start:    $local_fs $remote_fs $network $syslog
# Required-Stop:     $local_fs $remote_fs $network $syslog
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Initialize unifiedviews
# Description:       Initialize unifiedviews backend and frontend, run only once
### END INIT INFO

if [ ! -f /unifiedviews/core/backend/target/config.properties ]; then
    cp /unifiedviews/config/backend.config.properties /unifiedviews/core/backend/target/config.properties
    cd /unifiedviews/core/db/postgresql
    psql -h ${POSTGRES_PORT_5432_TCP_ADDR} -p ${POSTGRES_PORT_5432_TCP_PORT} -c "create database unifiedviews;"
    psql -h ${POSTGRES_PORT_5432_TCP_ADDR} -p ${POSTGRES_PORT_5432_TCP_PORT} -d unifiedviews -f schema.sql
    psql -h ${POSTGRES_PORT_5432_TCP_ADDR} -p ${POSTGRES_PORT_5432_TCP_PORT} -d unifiedviews -f data-core.sql
    psql -h ${POSTGRES_PORT_5432_TCP_ADDR} -p ${POSTGRES_PORT_5432_TCP_PORT} -d unifiedviews -f data-permissions.sql
    cp /unifiedviews/core/frontend/target/unifiedviews.war /var/lib/tomcat7/webapps/
    cd /unifiedviews/config
    sed -i "s#\${POSTGRES_PORT_5432_TCP_ADDR}#${POSTGRES_PORT_5432_TCP_ADDR}#g" frontend.config.properties
    sed -i "s#\${POSTGRES_PORT_5432_TCP_PORT}#${POSTGRES_PORT_5432_TCP_PORT}#g" frontend.config.properties
    sed -i "s#\${PGUSER}#${PGUSER}#g" frontend.config.properties
    sed -i "s#\${PGPASSWORD}#${PGPASSWORD}#g" frontend.config.properties
    sed -i "s#\${VIRTUOSO_PORT_1111_TCP_ADDR}#${VIRTUOSO_PORT_1111_TCP_ADDR}#g" frontend.config.properties
    sed -i "s#\${VIRTUOSO_PORT_1111_TCP_PORT}#${VIRTUOSO_PORT_1111_TCP_PORT}#g" frontend.config.properties
    sed -i "s#\${VIRTUOSO_USER}#${VIRTUOSO_USER}#g" frontend.config.properties
    sed -i "s#\${VIRTUOSO_PASSWORD}#${VIRTUOSO_PASSWORD}#g" frontend.config.properties
    sed -i "s#\${MASTER_API_USER}#${MASTER_API_USER}#g" frontend.config.properties
    sed -i "s#\${MASTER_API_PASSWORD}#${MASTER_API_PASSWORD}#g" frontend.config.properties
fi  

exit 0
