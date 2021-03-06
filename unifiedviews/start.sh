#!/bin/bash

/unifiedviews/init.sh
nohup java -DconfigFileLocation=/unifiedviews/config/backend.config.properties -jar /unifiedviews/core/backend/target/backend-2.1.1.jar > /var/log/unifiedviews/nohup.out &
sleep 5
chmod -R 777 /unifiedviews/target
service tomcat7 restart
service ssh start
/unifiedviews/dpu.sh
tail -f /var/log/tomcat7/catalina.out
