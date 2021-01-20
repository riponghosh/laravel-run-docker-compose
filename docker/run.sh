#!/bin/bash
COUNTER=0
(env | awk -F "=" '{print $1}' | grep ".*DB.*") | while read COUNTER; do
    echo The counter is printenv ${!COUNTER}
    mysql -u 'root' --password="$MYSQL_ROOT_PASSWORD" -e "CREATE DATABASE IF NOT EXISTS ${!COUNTER};GRANT ALL ON ${!COUNTER}.* TO '$MYSQL_USER'@'%';";
done
