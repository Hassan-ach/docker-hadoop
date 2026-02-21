#!/bin/bash
set -e

echo "=== Building all custom Docker images ==="

echo "[1/3] Building Flume image..."
docker build -t flume-hdfs:logs ./flume

echo "[2/3] Building Sqoop image..."
docker build -t sqoop:mysql ./sqoop

echo "[3/3] Building MapReduce image..."
docker build -t mapreduce:logs ./mapreduce

echo "=== All images built successfully ==="
docker images | grep -E "flume|sqoop|mapreduce"
