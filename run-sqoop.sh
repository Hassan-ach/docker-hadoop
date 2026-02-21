#!/bin/bash
set -e

echo "=== Running Sqoop Import ==="

echo "Listing databases in MySQL..."
docker exec sqoop sqoop list-databases \
	--connect jdbc:mysql://mysql:3306/ \
	--username user \
	--password "1234"

echo ""
echo "Listing tables in sqoopdb..."
docker exec sqoop sqoop list-tables \
	--connect jdbc:mysql://mysql:3306/sqoopdb \
	--username user \
	--password "1234"

echo ""
echo "Importing employees table from MySQL to HDFS..."
docker exec sqoop sqoop import \
	--connect jdbc:mysql://mysql:3306/sqoopdb \
	--username user \
	--password "1234" \
	--table employees \
	--target-dir /user/hadoopuser/project/db_data/employees \
	--fields-terminated-by , \
	--where "status='active'" \
	--num-mappers 1

echo ""
echo "Importing orders table from MySQL to HDFS..."
docker exec sqoop sqoop import \
	--connect jdbc:mysql://mysql:3306/sqoopdb \
	--username user \
	--password "1234" \
	--table orders \
	--target-dir /user/hadoopuser/project/db_data/orders \
	--fields-terminated-by , \
	--where "status='completed'" \
	--num-mappers 1

echo ""
echo "Verifying imported data..."
docker exec namenode hdfs dfs -ls /user/hadoopuser/project/db_data/
echo ""
echo "Employees data:"
docker exec namenode hdfs dfs -cat /user/hadoopuser/project/db_data/employees/part-m-00000
echo ""
echo "Orders data:"
docker exec namenode hdfs dfs -cat /user/hadoopuser/project/db_data/orders/part-m-00000

echo ""
echo "=== Sqoop Import Complete ==="
