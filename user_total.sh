#!/bin/sh

NOW=$(date +"%s")
echo $NOW

hive -e "create table if not exists user_total(time_ran int, total_users int, users_added int);"

if [[ $? -ne 0 ]] ; then
    echo "Could not create the table user_total"
    exit 1
fi

hive -e "insert into user_total select $NOW, sub1.t , case when sub2.t1 is NULL then sub1.t when sub2.t1 is not NULL then sub1.t-sub2.t1 end from (select count(distinct id) as t from practical_exercise_1.user)sub1, (select max(total_users) t1 from user_total) sub2;"

if [[ $? -ne 0 ]] ; then
    echo "Couldn't append a row in user_total"
    exit 1
fi







