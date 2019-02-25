#!/bin/sh

# docker exec -i -t gsmdocker_publisher_db_1 bash /root/scripts/import_db_actual.sh remote_host remote_user remote_password remote_db_name

echo "Loading db dump ...";
mysqldump --defaults-file="./backup.cnf" -h $1 -u $2 -p$3 $4 |
sed -e 's/DEFINER[ ]*=[ ]*[^*]*\*/\*/' |
sed -e 's/ROW_FORMAT=COMPACT/ROW_FORMAT=DYNAMIC/' |
sed -e '/ROW_FORMAT/!s/^) ENGINE=InnoDB/) ENGINE=InnoDB ROW_FORMAT=DYNAMIC/' |
mysql -h localhost -u root -p1 publisher
