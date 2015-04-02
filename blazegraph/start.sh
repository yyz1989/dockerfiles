#!/bin/bash

service ssh start
java -server -Xmx4g -jar bigdata-bundled.jar
