/*
########################
### People and Loans ###
########################
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

/*
Which SQL query will retrieve the three people with the highest total loans amounts?
Note: The answer solutions are presented in MySQL
*/
-- Option 1

SELECT p.first_name, p.last_name, l.amount
FROM people AS p
LEFT JOIN loans AS l ON l.people_id = p.id
--ORDER BY l.amount LIMIT 3 --MySQL syntax

-- Option 2

SELECT p.first_name, p.last_name, SUM(l.amount) AS amount
FROM people AS p
LEFT JOIN loans AS l ON l.people_id = p.id
GROUP BY p.first_name, p.last_name
-- ORDER BY l.amount DESC LIMIT 3  --MySQL syntax

/* 
SELECT p.first_name, p.last_name, SUM(l.amount) AS amount
FROM people AS p
LEFT JOIN loans AS l ON l.people_id = p.id
GROUP BY p.first_name, p.last_name
ORDER BY l.amount DESC LIMIT 3

Output:
Column "loans.amount" is invalid in the ORDER BY clause 
because it is not contained in either an aggregate function or the GROUP BY clause.
*/

-- Option 3

SELECT p.first_name, p.last_name, COUNT(l.amount) AS amount
FROM people AS p
LEFT JOIN loans AS l ON l.people_id = p.id
GROUP BY p.first_name, p.last_name
--ORDER BY l.amount DESC LIMIT 3  --MySQL syntax

-- Option 4

SELECT *
FROM (SELECT
	  p.first_name,
	  p.last_name,
	  SUM(l.amount) AS amount
	  FROM people AS p
	  LEFT JOIN loans AS l ON l.people_id = p.id
	  GROUP BY p.first_name, p.last_name) AS total
--ORDER BY l.amount DESC LIMIT 3  --MySQL syntax

/*
Answer:
This answer intentionally left blank
*/

/*
Under what circumstances will the following SQL query return TRUE?
Note: The answer solutions are presented in MySQL
*/

/*
SELECT 
	(SELECT YEAR(p.birth_date)
	FROM people AS p
	WHERE p.id = 5) >
	ANY (SELECT YEAR(p.birth_date)
		 FROM people AS p
		 WHERE p.last_name = 'McCarthy')
*/


/*
Options:

1. If the person whose id= is older that any people with last_name = 'McCarthy'
2. If the person whose id=5 is younger than any peoplewith last_name = 'McCarthy'
3. This query will never return TRUE
4. This query will always return TRUE

*/

/*
Answer:
This answer intentionally left blank
*/

/*
Which SQL query will retrieve people that are namesakes for the person whose id = 9?
*/

SELECT *
FROM people AS p
WHERE EXISTS (SELECT * FROM people AS p2 WHERE p2.id = 9)

/*
SELECT *
FROM people AS p
WHERE
(p.first_name, p.last_name) = (SELECT first_name, last_name FROM people WHERE id = 9)

-- Output: An expression of non-boolean type specified in a context where a condition is expected, near ','.
*/

/*
SELECT *
FROM people AS p
WHERE p.id IN (SELECT id FROM people AS p2 WHERE id = 9)
AND p2.first_name = p.first_name AND p2.last_name = p.last_name

-- Output: The multi-part identifier "p2.first_name" could not be bound.
*/

/*
Answer:
This answer intentionally left blank
*/

/*
What will the following SQL query do?
Note: The answer solutions are presented in MySQL
*/

/*
UPDATE loans AS l
INNER JOIN peopleAS p ON p.id = l.people_id
SET l.end_date = DATE_ADD(l.end_date, INTERVAL -1 MONTH)
WHERE p.id = @ID
*/

/*
Options:
1. Increase the loan end date by 1 month for the person whose id = @ID
2. Decrease the loan end date by 1 month for the person whose id = @ID
3. Add a new loan with end date = current date + 1 month for the person whose id = @ID
4. Delete all loans with the end_date less than the current date + 1 month for the person whose id = @ID
*/

/*
Answer:
This answer intentionally left blank
*/