USE master
GO

/* Questions & Answers */

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
Which of these will complete the followin SQL query so that it returns all people 
whose last_name contains only two instances of the letter "a" (case-insensitive)?

SELECT * FROM people AS p WHERE ...

Note:
LENGTH on MySQL (https://dev.mysql.com/doc/refman/5.7/en/string-functions.html#function_length)
LEN on T-SQL (https://msdn.microsoft.com/en-us/library/ms190329.aspx)
*/

IF OBJECT_ID('people') IS NOT NULL
    DROP TABLE people;
GO

CREATE TABLE people
(
	id		  int PRIMARY KEY NOT NULL ,
	first_name varchar(50) NULL,
	last_name varchar(50) NULL
)

INSERT people VALUES (1, 'John','ab'), (2, 'Jaycob', 'aba'), (3, 'James', 'abbaa'), (4, 'Jo','ABRACADABRA')

SELECT *
FROM people AS p
WHERE LEN(p.last_name) - LEN(REPLACE(LOWER(p.last_name), 'a', '')) = 2
-- WHERE LENGTH (p.last_name) - LENGTH (REPLACE(LOWER(p.last_name), 'a', '')) = 2

/*
SELECT *
FROM people AS p
WHERE LEN(p.last_name) - INSTR(p.last_name, 'a')
-- INSTR(str,substr) https://dev.mysql.com/doc/refman/5.7/en/string-functions.html#function_instr
*/

SELECT LOWER(id), LOWER(last_name)
FROM people AS p
WHERE LOWER(p.last_name) LIKE '%a%a'

SELECT *
FROM people AS p
WHERE p.last_name LIKE '%a%a'

/*
Which of the following SQL queries will retrieve people whose minumum loan amount is more than $1000?
*/

IF OBJECT_ID('loans') IS NOT NULL
    DROP TABLE loans;
GO

CREATE TABLE loans
(
	loan_id int PRIMARY KEY NOT NULL, -- foreign key to people_id
	people_id  int NULL , 
	amount int NULL,
	end_date datetime
)

INSERT loans VALUES (1, 1, 500, '2015-12-21'), (2, 2, 1000,'2015-11-21'), (3, 3, 1500, '2015-12-19'), (4, 4, 2000, '2015-11-15')

/*
-- Invalid solution.
SELECT p.id, p.first_name, p.last_name
FROM people AS p, loans AS l
GROUP BY p.id, p.first_name, p.last_name
-- you cannot use WHERE clause after an aggregate
WHERE p.id = l.people_id AND MIN(l.amount) > 1000
*/

/*
-- Invalid solution.
SELECT p.id, p.first_name, p.last_name
FROM people AS p, loans AS l
WHERE p.id = l.people_id AND MIN(l.amount) > 1000

Query execution output:
An aggregate may not appear in the WHERE clause unless it is in a subquery contained in a HAVING clause or a select list, and the column being aggregated is an outer reference.
*/

SELECT p.first_name, p.last_name
FROM people AS p, loans AS l
WHERE p.id = l.people_id
GROUP BY p.id, p.first_name, p.last_name
HAVING MIN(l.amount) > 1000

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
The following SQL query will return alist of people ...
*/
SELECT
p.id,
p.first_name,
p.last_name,
-- SUM(CASE WHEN l.end_date < CURDATE() THEN l.amount ELSE 0 END) total
SUM(CASE WHEN l.end_date < GETDATE() THEN l.amount ELSE 0 END) total -- or 'AS total'
FROM people as p, loans AS l
WHERE l.people_id = p.id
GROUP BY p.id, p.first_name, p.last_name

/*
Output:

id          first_name                                         last_name                                          total
----------- -------------------------------------------------- -------------------------------------------------- -----------
1           John                                               ab                                                 0
2           Jaycob                                             aba                                                0
3           James                                              abbaa                                              0
4           Jo                                                 ABRACADABRA                                        2000
*/

/*
with the number of their overdue payments
with the sum of their remaining payments
with the number of their remaining payments
with the sum of their overdue payments
*/

/*
Answer:
with the sum of their overdue payments
*/

/*
Which of these will complete the following SQL query so that it returns the list of people who have no loans?

SELECT p.id, p.first_name, p.last_name
FROM people AS p
WHERE ... (SELECT * FROM loans AS l WHERE l.people_id = p.id)

Available options:
- EXISTS
- NOT EXISTS
- p.id NOT IN
- p.id IN

*/

/*
Output of:
WHERE p.id NOT IN (SELECT * FROM loans AS l WHERE l.people_id = p.id)
and
WHERE p.id IN (SELECT * FROM loans AS l WHERE l.people_id = p.id)
is:
Only one expression can be specified in the select list when the subquery is not introduced with EXISTS.
*/

-- Answer:
SELECT p.id, p.first_name, p.last_name
FROM people AS p
WHERE NOT EXISTS (SELECT * FROM loans AS l WHERE l.people_id = p.id)


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

/*
Which of these will complete the following SQL query so that it returns the number of loans for each person in the PEOPLE table?

SELECT p.first_name, p.last_name, count(*) AS loans_number
FROM people AS p
... JOIN loan l ON p.id = l.people.id
GROUP BY p.first_name, p.last_name

Available options:
- INNER
- LEFT
- RIGHT
- Empty space
*/

SELECT p.first_name, p.last_name, count(*) AS loans_number
FROM people AS p
JOIN loans l ON p.id = l.people_id
GROUP BY p.first_name, p.last_name

/*
Answer: - Empty space

Discussion:
JOIN performs an INNER JOIN by default.
*/