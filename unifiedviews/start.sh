#!/bin/bash

/etc/init.d/init.sh && \
nohup java -DconfigFileLocation=/unifiedviews/core/backend/target/config.properties -jar /unifiedviews/core/backend/target/backend-2.1.1.jar & \ 
sleep 5 & \
service tomcat7 restart & \ 
service ssh start && \ 
tail -f /var/log/tomcat7/catalina.out
