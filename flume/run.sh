#!/bin/bash
set -e

# Required environment variables
: "${HDFS_PATH:?Need to set HDFS_PATH}"
: "${AGENT_NAME:=agent}"

# Substitute HDFS path in config
sed "s|\${HDFS_PATH}|$HDFS_PATH|g" /opt/flume/flume.conf.template > /opt/flume/flume.conf

# Run Flume agent
exec /opt/flume/bin/flume-ng agent \
    --conf /opt/flume/conf \
    --conf-file /opt/flume/flume.conf \
    --name "$AGENT_NAME"
