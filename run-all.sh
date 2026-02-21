#!/bin/bash
set -e

echo "=== Big Data Project - Full Setup ==="

echo ""
echo "Step 1: Pulling base Hadoop images..."
docker compose pull namenode datanode resourcemanager nodemanager1 historyserver mysql

echo ""
echo "Step 2: Building custom images..."
docker compose build sqoop flume mapreduce

echo ""
echo "Step 3: Starting all services..."
docker compose up -d

echo ""
echo "Step 4: Waiting for services to be ready..."
echo "Waiting for namenode..."
sleep 30
until docker exec namenode hdfs dfs -ls / >/dev/null 2>&1; do
	echo "Waiting for HDFS to be ready..."
	sleep 10
done

echo ""
echo "Step 5: Initializing HDFS directories..."
./init-hdfs.sh

echo ""
echo "Step 6: Waiting for MySQL to be ready..."
until docker exec mysql mysql -uroot -proot -e "SELECT 1" >/dev/null 2>&1; do
	echo "Waiting for MySQL to be ready..."
	sleep 5
done

echo ""
echo "=== Setup Complete! ==="
echo ""
echo "Services available at:"
echo "  - Namenode UI:    http://localhost:9870"
echo "  - ResourceManager: http://localhost:8088"
echo "  - History Server:  http://localhost:8188"
echo ""
echo "To run Sqoop import, execute:"
echo "  docker exec -it sqoop bash"
echo ""
echo "To run MapReduce job, execute:"
echo "  docker exec -it mapreduce bash"
