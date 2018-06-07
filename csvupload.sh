#!/bin/sh

#CSV to Hadoop

for filename in ~/Downloads/Exercise1/upload/; do 
	echo "$(basename "$filename")"
	HDFS_PATH="/user/cloudera/exe1/"
	if hdfs dfs -test -f $HDFS_PATH$(basename "$filename"); then
    		echo "$(basename "$filename") exists on HDFS"
	
	else
	    echo "$(basename "$filename") exists on HDFS"
            sudo hadoop fs -put $filename $HDFS_PATH
	fi
done





#CSV to Hive

hive -e "drop table practical_exercise_1.user_upload_dump"
if [[ $? -ne 0 ]] ; then
    echo "Could not drop user_upload_dump"
    exit 1
fi



hive -e "create external table practical_exercise_1.user_upload_dump(user_id int, file_name STRING, timestamp int) ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' STORED AS TEXTFILE LOCATION '/user/cloudera/exe1/upload' tblproperties ('skip.header.line.count'='1');"
if [[ $? -ne 0 ]] ; then
    echo "Could not create external table user_upload_dump"
    exit 1
fi


