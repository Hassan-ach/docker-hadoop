#!/bin/bash
set -e

echo "Sqoop is ready for use."
echo "Example commands:"
echo "  sqoop import --connect jdbc:mysql://mysql:3306/sqoopdb --username user --password 1234 --table employees --target-dir /user/hadoopuser/project/db_data/employees"

tail -f /dev/null
