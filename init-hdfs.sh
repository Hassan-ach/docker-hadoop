#!/bin/bash
set -e

echo "=== Initializing HDFS directories ==="

HDFS_PATH="/user/hadoopuser/project"

echo "Creating HDFS directory structure..."
docker exec namenode hdfs dfs -mkdir -p $HDFS_PATH/logs
docker exec namenode hdfs dfs -mkdir -p $HDFS_PATH/db_data
docker exec namenode hdfs dfs -mkdir -p $HDFS_PATH/input
docker exec namenode hdfs dfs -mkdir -p $HDFS_PATH/output

echo "Verifying HDFS structure..."
docker exec namenode hdfs dfs -ls -R /user/hadoopuser/project

echo "=== HDFS initialization complete ==="
