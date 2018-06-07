# Practical-Exercise-Sqoop-and-Hive

The goal of the exercise is to generate two tables to report the user statistics of a website including the number of inserts, updates, deletes made by the user, whether the user has been active for the past two days, etc and also to record the number of total users in the system and the number of users added from time to time.

### practical_exercise_data_generator.py

- Allows you to repeatedly create a csv file and to load two tables user and activitylog into mysql database. 

- The table `user` has two fields: 
    - **id** - Used to uniquely identify a user in the table. 
    - **name** - indicates the name of the user.

- The table `activitylog` has four fields: 
    - **id** -  indicates the identifier for the activity event.  
    - **user_id** - used to identify a user in the table.
    - **type** - indicates the type of activity - update, insert or delete.
    - **timestamp** - indicates the timestamp at which the particular activity was performed by the user.

### Instructions to run:

```python practical_exercise_data_generator.py --help```
 - provides guidance on the operations that can be performed with the script.

```python practical_exercise_data_generator.py --load_data```
 - Loads two tables user and activitylog into MySQL database.
 
```python practical_exercise_data_generator.py --create_csv```
 - Creates csv containing information regarding what file has been loaded at what time by the user.


### Shell scripts:

**1. sqltohive.sh**

```./mysqltohive.sh```

- For the execution, permissions must be given to execute the file as a program. This can be done by using the check box "Allow executing file as program" under the permissions tab of properties dialog box.

- The script is used to import data from mysql to hive using sqoop.

- The data loaded into MySQL by using practical_exercise_data_generator.py is imported into hive for querying purposes.

**2.csvupload.sh**

```./csvupload.sh```

- The csv files generated will be loaded into /upload folder by practical_exercise_data_generator.py

- The script allows the files to be loaded into hdfs and hive.

**3.user_report.sh**

```./user_report.sh```

- A table is created to report the statistics of all the users.

- The user_report table contains the user id, number of updates, inserts and the deletes that the user has made, the last activity type of the user (Whether the user has done an insert, update or a delete), whether he has been active during the last two days and the number of uploads he has made.

**4. user_total.sh**

```./user_total.sh```

- A table is created to determine the number of users using the website at a certain point of time.

- Every time the script is ran, a new row gets appended at the end of the user_total which records the timestamp at which the entry is made, total number of users, the number of users added.

