#!/bin/bash

service ssh start
/stardog/bin/stardog-admin server start
tail -f /stardog/stardog.log
