#!/bin/bash

export HADOOP_COMMON_HOME=/opt/hadoop-3.2.1
export HADOOP_MAPRED_HOME=/opt/hadoop-3.2.1
export HADOOP_HDFS_HOME=/opt/hadoop-3.2.1
export YARN_HOME=/opt/hadoop-3.2.1
export HADOOP_CONF_DIR=/etc/hadoop

export HBASE_HOME=/opt/hbase
export HCAT_HOME=/opt/hive
export ACCUMULO_HOME=/opt/accumulo
export ZOOKEEPER_HOME=/opt/zookeeper

SQOOP_CP="$SQOOP_HOME/lib/*"
SQOOP_CP="$SQOOP_CP:$HADOOP_HOME/share/hadoop/common/*"
SQOOP_CP="$SQOOP_CP:$HADOOP_HOME/share/hadoop/common/lib/*"
SQOOP_CP="$SQOOP_CP:$HADOOP_HOME/share/hadoop/hdfs/*"
SQOOP_CP="$SQOOP_CP:$HADOOP_HOME/share/hadoop/hdfs/lib/*"
SQOOP_CP="$SQOOP_CP:$HADOOP_HOME/share/hadoop/mapreduce/*"
SQOOP_CP="$SQOOP_CP:$HADOOP_HOME/share/hadoop/mapreduce/lib/*"
SQOOP_CP="$SQOOP_CP:$HADOOP_HOME/share/hadoop/yarn/*"
SQOOP_CP="$SQOOP_CP:$HADOOP_HOME/share/hadoop/yarn/lib/*"
SQOOP_CP="$SQOOP_CP:$HADOOP_HOME/share/hadoop/tools/lib/*"

export HADOOP_CLASSPATH="$SQOOP_CP"

exec java -cp "$SQOOP_CP" org.apache.sqoop.Sqoop "$@"
