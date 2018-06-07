#!/bin/sh

# Starting the sqoop metastore

nohup sqoop metastore & 

sqoop job --meta-connect jdbc:hsqldb:hsql://localhost:16000/sqoop --create practical_exercise_1.activitylog -- import --connect jdbc:mysql://localhost/practical_exercise_1 --username root --password-file /user/cloudera/pwd.txt  --table activitylog -m 2 --hive-import --hive-database practical_exercise_1 --hive-table activitylog --incremental append --check-column id --last-value 0

sqoop job --meta-connect jdbc:hsqldb:hsql://localhost:16000/sqoop --password-file /user/cloudera/pwd.txt --exec practical_exercise_1.activitylog

sqoop import --connect jdbc:mysql://localhost/practical_exercise_1 --username root --password-file /user/cloudera/pwd.txt --table user -m 2 --hive-import --hive-overwrite --hive-database practical_exercise_1 --hive-table user



 
