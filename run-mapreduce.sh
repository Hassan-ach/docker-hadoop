#!/bin/bash
set -e

JOB_TYPE=${1:-level}

echo "=== Running MapReduce Job: $JOB_TYPE ==="

echo "Copying mapper and reducer to containers..."
docker cp mapreduce/mapper_level.py mapreduce:/app/
docker cp mapreduce/reducer_level.py mapreduce:/app/
docker cp mapreduce/mapper_error_service.py mapreduce:/app/ 2>/dev/null || true
docker cp mapreduce/mapper_service_level.py mapreduce:/app/ 2>/dev/null || true
docker cp mapreduce/mapper_unique_users.py mapreduce:/app/ 2>/dev/null || true
docker cp mapreduce/reducer_unique_users.py mapreduce:/app/ 2>/dev/null || true

echo ""
echo "Finding streaming jar..."
STREAMING_JAR=$(docker exec mapreduce find /opt/hadoop-3.2.1/share/hadoop/tools/lib -name "hadoop-streaming*.jar" | head -1)
echo "Using: $STREAMING_JAR"

MAPPER=""
REDUCER=""

case "$JOB_TYPE" in
level)
	MAPPER="mapper_level.py"
	REDUCER="reducer_level.py"
	;;
error_service)
	MAPPER="mapper_error_service.py"
	REDUCER="reducer_level.py"
	;;
service_level)
	MAPPER="mapper_service_level.py"
	REDUCER="reducer_level.py"
	;;
unique_users)
	MAPPER="mapper_unique_users.py"
	REDUCER="reducer_unique_users.py"
	;;
*)
	echo "Invalid JOB_TYPE: $JOB_TYPE. Using level."
	MAPPER="mapper_level.py"
	REDUCER="reducer_level.py"
	;;
esac

echo ""
echo "Running Hadoop Streaming job..."

docker exec namenode hdfs dfs -rm -r -f /user/hadoopuser/project/output 2>/dev/null || true

docker exec mapreduce hadoop jar "$STREAMING_JAR" \
	-D mapreduce.job.name="${JOB_TYPE}_job" \
	-input /user/hadoopuser/project/logs \
	-output /user/hadoopuser/project/output \
	-mapper "python3 ${MAPPER}" \
	-reducer "python3 ${REDUCER}" \
	-file /app/${MAPPER} \
	-file /app/${REDUCER}

echo ""
echo "Checking output..."
docker exec namenode hdfs dfs -ls /user/hadoopuser/project/output/
docker exec namenode hdfs dfs -cat /user/hadoopuser/project/output/part-*

echo ""
echo "=== MapReduce Job Complete ==="
