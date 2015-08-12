#!/bin/bash

/etc/init.d/init.sh
nohup java -DconfigFileLocation=/unifiedviews/config/backend.config.properties -jar /unifiedviews/core/backend/target/backend-2.1.1.jar &
sleep 5
chmod -R 777 /unifiedviews/target
service tomcat7 restart
service ssh start
tail -f /var/log/tomcat7/catalina.out
