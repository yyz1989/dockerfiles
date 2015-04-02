#!/bin/bash

service ssh start
/tomcat/bin/startup.sh
tail -f /tomcat/logs/catalina.out
