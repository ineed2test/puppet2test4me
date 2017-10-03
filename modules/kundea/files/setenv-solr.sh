#!/bin/sh
#
# setenv.sh
#
#
#

### Host settings.
CATALINA_HOME=/home/kundea/solr
CATALINA_BASE=/home/kundea/solr
LD_LIBRARY_PATH=/usr/lib
export CATALINA_HOME CATALINA_BASE LD_LIBRARY_PATH

CATALINA_OPTS="${CATALINA_OPTS}
-Djava.awt.headless=true
-server
-d64
-Xms128m
-Xmx128m
-XX:NewSize=64m
-XX:MaxNewSize=64m
-XX:PermSize=32m
-XX:MaxPermSize=32m"
CATALINA_OPTS="${CATALINA_OPTS} -Dappname=solr -Dfile.encoding=UTF-8"

##solr properties
CATALINA_OPTS="${CATALINA_OPTS} -Dsolr.solr.home=/home/kundea/solr/conf/Catalina/localhost/solr -Denable.master=true -Denable.slave=false"
export CATALINA_OPTS

### Use standard POSIX language.
LANG=C
export LANG

# end of file