#!/bin/bash
set -e

/opt/sqoop/bin/sqoop2-tool upgrade
/opt/sqoop/bin/sqoop2-tool verify

if [ "$SQOOP_MODE" = "client" ]; then
    echo "Starting Sqoop in Client Mode..."
    /opt/sqoop/bin/sqoop2-shell
else
    echo "Starting Sqoop Server..."
    /opt/sqoop/bin/sqoop2-server start
fi

tail -f /dev/null
