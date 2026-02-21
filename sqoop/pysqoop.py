#!/usr/bin/env python3
import subprocess
import sys
import argparse
import pymysql

def get_mysql_connection(host, port, database, user, password):
    return pymysql.connect(
        host=host,
        port=port,
        database=database,
        user=user,
        password=password,
        charset='utf8mb4',
        cursorclass=pymysql.cursors.Cursor
    )

def list_databases(host, port, user, password):
    conn = get_mysql_connection(host, port, None, user, password)
    cursor = conn.cursor()
    cursor.execute("SHOW DATABASES")
    for db in cursor:
        print(db[0])
    cursor.close()
    conn.close()

def list_tables(host, port, database, user, password):
    conn = get_mysql_connection(host, port, database, user, password)
    cursor = conn.cursor()
    cursor.execute("SHOW TABLES")
    for table in cursor:
        print(table[0])
    cursor.close()
    conn.close()

def import_table(host, port, database, user, password, table, target_dir, 
                 fields_terminated_by=',', lines_terminated_by='\n', 
                 where_clause=None, num_mappers=1):
    conn = get_mysql_connection(host, port, database, user, password)
    cursor = conn.cursor()
    
    query = "SELECT * FROM " + table
    if where_clause:
        query += " WHERE " + where_clause
    
    cursor.execute(query)
    columns = [i[0] for i in cursor.description]
    
    tmp_file = "/tmp/" + table + ".csv"
    with open(tmp_file, 'w') as f:
        for row in cursor:
            line = fields_terminated_by.join(str(val) if val is not None else '' for val in row)
            f.write(line + lines_terminated_by)
    
    cursor.close()
    conn.close()
    
    subprocess.run(['hdfs', 'dfs', '-mkdir', '-p', target_dir], check=True)
    subprocess.run(['hdfs', 'dfs', '-copyFromLocal', '-f', tmp_file, target_dir + "/part-m-00000"], check=True)
    subprocess.run(['rm', tmp_file], check=True)
    
    print("Imported " + table + " to " + target_dir)
    print("Fields: " + fields_terminated_by.join(columns))

def main():
    parser = argparse.ArgumentParser(description='Simple Sqoop-like tool for MySQL to HDFS import')
    subparsers = parser.add_subparsers(dest='command', help='Commands')
    
    list_dbs_parser = subparsers.add_parser('list-databases', help='List databases')
    list_dbs_parser.add_argument('--connect', required=True, help='JDBC connection string')
    list_dbs_parser.add_argument('--username', required=True)
    list_dbs_parser.add_argument('--password', required=True)
    
    list_tables_parser = subparsers.add_parser('list-tables', help='List tables')
    list_tables_parser.add_argument('--connect', required=True)
    list_tables_parser.add_argument('--username', required=True)
    list_tables_parser.add_argument('--password', required=True)
    
    import_parser = subparsers.add_parser('import', help='Import table')
    import_parser.add_argument('--connect', required=True)
    import_parser.add_argument('--username', required=True)
    import_parser.add_argument('--password', required=True)
    import_parser.add_argument('--table', required=True)
    import_parser.add_argument('--target-dir', required=True)
    import_parser.add_argument('--fields-terminated-by', default=',')
    import_parser.add_argument('--where', dest='where_clause', default=None)
    import_parser.add_argument('--num-mappers', type=int, default=1)
    
    args = parser.parse_args()
    
    if not args.command:
        parser.print_help()
        return
    
    jdbc_url = args.connect.replace('jdbc:mysql://', '')
    parts = jdbc_url.split('/')
    host_port = parts[0].split(':')
    host = host_port[0]
    port = int(host_port[1]) if len(host_port) > 1 else 3306
    database = parts[1].split('?')[0] if len(parts) > 1 else None
    
    if args.command == 'list-databases':
        list_databases(host, port, args.username, args.password)
    elif args.command == 'list-tables':
        list_tables(host, port, database, args.username, args.password)
    elif args.command == 'import':
        import_table(
            host, port, database, args.username, args.password,
            args.table, args.target_dir,
            args.fields_terminated_by, '\n',
            args.where_clause, args.num_mappers
        )

if __name__ == '__main__':
    main()
