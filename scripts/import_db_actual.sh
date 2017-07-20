#!/bin/sh
# docker exec -i -t gsmdocker_publisher_db bash /root/scripts/import_db_actual.sh
remoteDbName="dev001"
remoteDbHost="sdsp-vpc-db-001.cyquzquo3ds0.us-east-1.rds.amazonaws.com"
remoteDbUser="dev001"
remoteDbPass="masterkey"

localDbName="publisher"
localDbHost="localhost"
localDbUser="root"
localDbPass="1"


echo "Loading db dump ...";
mysqldump -h $remoteDbHost -u $remoteDbUser -p$remoteDbPass $remoteDbName |
sed -e 's/DEFINER[ ]*=[ ]*[^*]*\*/\*/' |
sed -e 's/ROW_FORMAT=COMPACT/ROW_FORMAT=DYNAMIC/' |
sed -e '/ROW_FORMAT/!s/^) ENGINE=InnoDB/) ENGINE=InnoDB ROW_FORMAT=DYNAMIC/' |
mysql -h $localDbHost -u $localDbUser -p$localDbPass $localDbName
