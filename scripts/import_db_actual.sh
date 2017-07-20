#!/bin/sh
# docker exec -i -t gsmdocker_publisher_db_1 bash /root/scripts/import_db_actual.sh
remoteDbName="dev001"
remoteDbHost="sdsp-vpc-db-001.cyquzquo3ds0.us-east-1.rds.amazonaws.com"
remoteDbUser="dev001"
remoteDbPass="masterkey"

localDbName="publisher"
localDbHost="localhost"
localDbUser="root"
localDbPass="1"

rawDump="/root/dump_raw.sql"
fixedDump="/root/fixed_dump.sql"

echo "Making a dump of a database (this operation may take several minutes)";
mysqldump -h $remoteDbHost -u $remoteDbUser -p$remoteDbPass $remoteDbName > $rawDump

echo "Remove DEFINER, set ROW_FORMAT=DYNAMIC"
cat $rawDump |
sed -e 's/DEFINER[ ]*=[ ]*[^*]*\*/\*/' |
sed -e 's/ROW_FORMAT=COMPACT/ROW_FORMAT=DYNAMIC/' |
sed -e '/ROW_FORMAT/!s/^) ENGINE=InnoDB/) ENGINE=InnoDB ROW_FORMAT=DYNAMIC/' > $fixedDump

echo "Uploading database to local host"
mysql -h $localDbHost -u $localDbUser -p$localDbPass $localDbName < $fixedDump

