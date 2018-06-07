#!/bin/sh


NOW=$(date +"%s")

#Combined

hive -e "drop table practical_exercise_1.user_report;"
hive -e "drop table practical_exercise_1.user_report1;"
hive -e "drop table practical_exercise_1.user_report2;"
hive -e "drop table practical_exercise_1.user_report3;"
hive -e "drop table practical_exercise_1.med1;"



hive -e " create table practical_exercise_1.user_report1 as select user_id, sum(ins) total_updates, sum(ins2) total_inserts, sum(ins1) total_deletes from (select user_id, if(type='UPDATE',cnt,0) ins, if(type='DELETE', cnt, 0) ins1, if(type='INSERT',cnt,0) ins2 from (select user_id,type,count(*) as cnt from practical_exercise_1.activitylog group by user_id,type)a)b group by user_id;"

if [[ $? -ne 0 ]] ; then
    echo "Could not create user_report with inserts, updates and deletes"
    exit 1
fi


hive -e "create table practical_exercise_1.med1 as select user_id, count(*) as cnt from practical_exercise_1.user_upload_dump group by user_id;"

if [[ $? -ne 0 ]] ; then
    echo "Could not overwrite with upload_count"
    exit 1
fi

hive -e "create table practical_exercise_1.user_report2 as select user_report1.user_id, user_report1.total_updates,user_report1.total_deletes,user_report1.total_inserts, med1.cnt upload_count from practical_exercise_1.user_report1 join practical_exercise_1.med1 on med1.user_id=user_report1.user_id;"


if [[ $? -ne 0 ]] ; then
    echo "Could not create user_report2"
    exit 1
fi


hive -e "create table practical_exercise_1.user_report3 as select user_report2.user_id, user_report2.total_updates, user_report2.total_inserts, user_report2.total_deletes, user_report2.upload_count, d.last_active_type, d.is_active from practical_exercise_1.user_report2 join (select c.user_id, t, activitylog.type last_active_type, c.is_active from (select activitylog.user_id, max(timestamp) t, if($NOW-max(timestamp)<=172800,'TRUE','FALSE') is_active from practical_exercise_1.activitylog group by user_id)c right outer join practical_exercise_1.activitylog where c.t=activitylog.timestamp and c.user_id=activitylog.user_id)d on d.user_id=user_report2.user_id;"



if [[ $? -ne 0 ]] ; then
    echo "Could not create user_report3"
    exit 1
fi


hive -e "create table practical_exercise_1.user_report as select user.id, user_report3.total_updates, user_report3.total_inserts, user_report3.total_deletes,user_report3.upload_count,user_report3.last_active_type,user_report3.is_active from practical_exercise_1.user_report3 right outer join practical_exercise_1.user on user.id=user_report3.user_id;"


if [[ $? -ne 0 ]] ; then
    echo "Could not create user_report"
    exit 1
fi











