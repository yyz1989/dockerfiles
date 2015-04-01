#!/bin/bash

service ssh start
/sparqlverse/rel/bin/configure_thp
/sparqlverse/rel/bin/sbxstart --force
