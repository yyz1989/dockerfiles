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
fi  

exit 0
