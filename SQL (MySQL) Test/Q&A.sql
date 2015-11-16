/* 
###########################
### Questions & Answers ###
###########################
*/

USE master
GO

/*
When  need to concatenate the results of two independent queries with an equal set of fields, e.g.


(SELECT 1, 2 FROM A1) ... (SELECT 1, 2 FROM A2)

we should use the keyword:
- JOIN
- CONCATENATE
- PLUS
- UNION

Answer:
UNION (Transact-SQL)
https://msdn.microsoft.com/en-us/library/ms180026.aspx

*/

/*
OBJECT_ID (Transact-SQL)

https://msdn.microsoft.com/en-us/library/ms190328.aspx

IF OBJECT_ID('TableName', 'U') IS NULL

Table does not exist or do not have permissions
U = Table (user-defined)
More info:
sys.objects (Transact-SQL)
https://technet.microsoft.com/en-us/library/ms190324.aspx
*/




/*
Which function is used to get the current time in MySQL?

- DateTime.Now()
- Now()
- DateTime()
- Time()
- GetTime()
- CurTime()
- None of the above

Answer:
https://dev.mysql.com/doc/refman/5.7/en/date-and-time-functions.html#function_curtime

mysql> SELECT CURTIME();
        -> '23:50:26'

*/
-- In T-SQL
SELECT CURRENT_TIMESTAMP;
SELECT GETDATE();
SELECT CONVERT(time, GETDATE());

SELECT CONVERT(VARCHAR(8),GETDATE(),108) AS HourMinuteSecond
-- CONVERT (Transact-SQL) https://msdn.microsoft.com/en-us/library/ms187928.aspx


/*
What is the difference between the following two statements?

DELETE * FROM [simple_table_without_indexes_and_keys]
TRUNCATE TABLE [simple_table_without_indexes_and_keys]

Available options:
1. The TRUNCATE statement will drop and recreate the same table while the DELETE statement will just delete all data.

2. The TRUNCATE statement will delete the table while the DELETE statement will delete all data

3. The DELETE statement will drop and recreate the same table while the TRUNCATE statement will just delete all data.

4. These two statements are functionally identical.

*/

-- Answer: 4. These two statements are functionally identical.

/*
Discussion:

In T-SQL:
DELETE FROM [simple_table_without_indexes_and_keys]
TRUNCATE TABLE [simple_table_without_indexes_and_keys]

TRUNCATE TABLE (Transact-SQL)
https://msdn.microsoft.com/en-us/library/ms177570.aspx
TRUNCATE TABLE removes all rows from a table, but the table structure and its columns, constraints, indexes, and so on remain.

DELETE (Transact-SQL)
https://msdn.microsoft.com/en-us/library/ms189835.aspx
The DELETE statement removes rows one at a time and records an entry in the transaction log for each deleted row. 

DROP TABLE (Transact-SQL)
https://msdn.microsoft.com/en-us/library/ms173790.aspx
Removes one or more table definitions and all data, indexes, triggers, constraints, and permission specifications for those tables.
Any view or stored procedure that references the dropped table must be explicitly dropped by using DROP VIEW or DROP PROCEDURE. 

*/