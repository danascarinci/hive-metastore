#!/bin/sh

export JAVA_HOME=/usr/local/openjdk-8
export HADOOP_HOME=/opt/hadoop-${HADOOP_VERSION}
export HADOOP_CLASSPATH=${HADOOP_HOME}/share/hadoop/tools/lib/aws-java-sdk-bundle-1.11.375.jar:${HADOOP_HOME}/share/hadoop/tools/lib/hadoop-aws-3.2.0.jar
export METASTORE_DB_HOSTNAME=${METASTORE_DB_HOSTNAME:-localhost}


echo "Init apache hive metastore on ${METASTORE_DB_HOSTNAME}:${METASTORE_DB_PORT} ..."


/opt/apache-hive-metastore-3.0.0-bin/bin/schematool -initSchema -dbType postgres
/opt/apache-hive-metastore-3.0.0-bin/bin/start-metastore