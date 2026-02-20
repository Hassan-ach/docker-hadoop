#!/bin/bash
set -e

: "${HADOOP_HOME:?HADOOP_HOME not set}"
# : "${JOB_TYPE:?JOB_TYPE not set}"

export HDFS_INPUT=${HDFS_INPUT:-/user/hadoopuser/project/input}
export STREAMING_JAR=${STREAMING_JAR:-$HADOOP_HOME/share/hadoop/tools/lib/hadoop-streaming*.jar}
export BASE_OUTPUT=${BASE_OUTPUT:-/user/hadoopuser/project}
export PYTHON_BIN=${PYTHON_BIN:-python3}

run_job() {
    local JOB_NAME=$1
    local MAPPER=$2
    local REDUCER=$3
    local OUTPUT_PATH="${BASE_OUTPUT}/${JOB_NAME}"

    hdfs dfs -rm -r -f "$OUTPUT_PATH" >/dev/null 2>&1 || true

    hadoop jar $STREAMING_JAR \
        -D mapreduce.job.name="$JOB_NAME" \
        -input "$HDFS_INPUT" \
        -output "$OUTPUT_PATH" \
        -mapper "$PYTHON_BIN $MAPPER" \
        -reducer "$PYTHON_BIN $REDUCER" \
        -file "$MAPPER" \
        -file "$REDUCER"
}

case "$JOB_TYPE" in
    level)
        run_job "output_level" \
            "mapper_level.py" \
            "reducer_level.py"
        ;;
    error_service)
        run_job "output_error_service" \
            "mapper_error_service.py" \
            "reducer_level.py"
        ;;
    service_level)
        run_job "output_service_level" \
            "mapper_service_level.py" \
            "reducer_level.py"
        ;;
    unique_users)
        run_job "output_unique_users" \
            "mapper_unique_users.py" \
            "reducer_unique_users.py"
        ;;
    *)
        echo "Invalid JOB_TYPE: $JOB_TYPE"
        tail -f /dev/null
        ;;
esac
