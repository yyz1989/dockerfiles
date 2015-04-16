#!/bin/bash

touch /var/opt/MarkLogic/Logs/8001_AccessLog.txt
service ssh start
/etc/init.d/MarkLogic start
tail -f /var/opt/MarkLogic/Logs/8001_AccessLog.txt
