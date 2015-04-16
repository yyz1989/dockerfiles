#!/bin/bash

service ssh start
/etc/init.d/MarkLogic start
sleep 3s
tail -f /var/opt/MarkLogic/Logs/8001_AccessLog.txt
