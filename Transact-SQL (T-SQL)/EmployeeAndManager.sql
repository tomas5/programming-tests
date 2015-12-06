/*
	SET NOCOUNT { ON | OFF } - Stops the message that shows the count of the number of rows affected by a Transact-SQL statement
	or stored procedure from being returned as part of the result set.
*/
SET NOCOUNT ON;
GO
USE TestOne --database name

/*
IF OBJECT_ID('dbo.TPERSON') IS NOT NULL
    DROP TABLE TPERSON;
GO
*/

DROP TABLE dbo.TPERSON;
CREATE TABLE dbo.TPERSON
(
	personid int PRIMARY KEY NOT NULL,
	lastname varchar(50) NULL,
	firstname varchar(50) NULL,
	salary money NULL,
	managerid int NULL -- foreign key to personid
)
/*
	Please note: setting IDENTITY_INSERT to ON is not a good practice.
	The best practise is to not create identity column, because it generates the values for you otherwise
	you may end up having duplicate values.
	It should be practised if the database is in maintenance mode and set to a single user.
*/

/*
-- following MSDN library documentation example:
CREATE TABLE dbo.tperson
(
	personid	int			identity,
	lastname	varchar(50)	NULL,
	firstname	varchar(50)	NULL,
	salary		money		NULL,
	managerid	int			NULL
);
GO
SET IDENTITY_INSERT tperson ON
INSERT dbo.tperson (personid, lastname, firstname, salary, managerid)
VALUES
	(1, 'Smith', 'Ted', 25000, NULL),
	(2, 'Brown', 'Nancy', 26000, NULL),
	(3, 'Lemon', 'Bob', 27000, NULL);

SET IDENTITY_INSERT tperson OFF
GO
SELECT * FROM tperson;
*/

/*
	The SQL UNION operator combines the result of two or more SELECT statements.
	SQL UNION ALL - selects all values (duplicate values also) while
	UNION selects different values (only distinct values).
*/
INSERT INTO TPERSON (personid, lastname, firstname, salary, managerid)
SELECT 1, 'Stolz', 'Ted', 25000, NULL UNION ALL
SELECT 2, 'Boswell', 'Nancy', 23000, 1 UNION ALL
SELECT 3, 'Hargett', 'Vincent', 22000, 1 UNION ALL
SELECT 4, 'Weekley', 'Kevin', 22000, 3 UNION ALL
SELECT 5, 'Metts', 'Geraldine', 22000, 2 UNION ALL
SELECT 6, 'McBride', 'Jeffrey', 21000, 2 UNION ALL
SELECT 7, 'Xiong', 'Jay', 20000, 3
--SELECT 8, 'James', 'Watson', 15000, NULL

/*
	### Question 1 ###
*/
-- (a) Write a SELECT query to return all the data in the TPERSON table
SELECT * FROM TPERSON;

/*
	(b) Write a SELECT query to return the first name and last name (only two columns)
		of all the people in TPERSON in alphabetical order by their last names
*/
SELECT firstname, lastname FROM TPERSON ORDER BY lastname


-- (c) Write a SELECT query to return the name of the employee(s) with the lowest salary
SELECT firstname, lastname FROM TPERSON WHERE salary = (SELECT MIN(salary) FROM TPERSON)
-- OR with full name in one column
SELECT firstname + ' ' + lastname AS 'Employee with the lowest salary' FROM TPERSON WHERE salary = (SELECT MIN(salary) FROM TPERSON)


-- (d) Write a SELECT query to return the total of all the salaries
SELECT SUM(salary) AS 'Total amount' FROM TPERSON

-- (e) Write a SELECT query to return the name of all employees without a manager
SELECT firstname + ' ' + lastname AS 'Employee without manager' FROM TPERSON WHERE managerid IS NULL

/*
	### Question 2 ###
*/

/*
------------------------------------
Employee Name	|	Manager Name
----------------+-------------------
Ted Stolz		|	No Manager 
Nancy Boswell	|	Ted Stolz 
Vincent Hargett	|	Ted Stolz 
Kevin Weekley 	|	Vincent Hargett 
Geraldine Metts	|	Nancy Boswell 
Jeffrey McBride	|	Nancy Boswell 
Jay Xiong		|	Vincent Hargett 
------------------------------------
*/

/*
	Write a SELECT query to return the name of all employees alongside the name of their manager.
	If the employee has no manager, the manager name column should contain the text ‘No Manager’ i.e.

	[Bonus points for how closely you can get your query to return exactly these results,
	 assuming the 7 rows of data above.]
*/

DROP TABLE TBL_MNG;
CREATE TABLE TBL_MNG
(
	managerid INT DEFAULT NULL, -- int, allows nulls, by default NULL
	name VARCHAR(50) NOT NULL, --string of 50 characters
	constraint pk_managerid PRIMARY KEY(managerid),
	constraint u_managerid UNIQUE(managerid)
);

INSERT INTO TBL_MNG(managerid, name)
SELECT 1, 'Ted Stolz' UNION ALL
SELECT 2, 'Nancy Boswell' UNION ALL
SELECT 3, 'Vincent Hargett' 

/*
	Write a SELECT query to return the name of all employees alongside the name of their manager.
	If the employee has no manager, the manager name column should contain the text ‘No Manager’
*/
SELECT DISTINCT p.firstname + ' ' + p.lastname AS 'Employee Name', CASE WHEN p.managerid IS NULL THEN 'No Manager' ELSE m.name END AS 'Manager Name' 
FROM TPERSON AS p, TBL_MNG AS m
WHERE p.managerid=m.managerid OR p.managerid IS NULL

/*
	Because solution is based on: sorting the result-set by personid, 
	we need to use ORDER BY Keyword for the best solution,
	but we need to improve this quesry to not show ID's column. 
*/
SELECT DISTINCT p.personid, p.firstname + ' ' + p.lastname AS 'Employee Name', CASE WHEN p.managerid IS NULL THEN 'No Manager' ELSE m.name END AS 'Manager Name' 
FROM TPERSON AS p, TBL_MNG AS m
WHERE p.managerid=m.managerid OR p.managerid IS NULL
ORDER BY p.personid 

/*
	Correct (BEST) solution:
	for MySQL - COALESCE() function 
	for SQL Server - ISNULL() function
*/

SELECT (p.firstname + ' ' + p.lastname) AS 'Employee Name', ISNULL(m.name, 'No Manager') AS 'Manager Name' 
FROM TPERSON AS p
LEFT JOIN TBL_MNG AS m
ON p.managerid=m.managerid
 
/*
	### Question 3 ###
	Write a SELECT query to return the names of the employee(s) with the third highest salary.
*/
SELECT firstname, lastname FROM ( SELECT *,RANK() OVER ( Order by salary DESC) as Test FROM TPERSON ) A WHERE Test=3

/*
	### Question 4 ###
	Write an UPDATE query to increase the salaries of all employees by 2%.
*/
UPDATE TPERSON SET salary *= 1.02
 
/*
	### Question 5 ###
	Write a query to add the following user record into the TPERSON table:
	Joe Bloggs, starting on 1st June, with salary of 22500, reporting to Geraldine Metts.
*/

INSERT INTO TPERSON (personid, lastname, firstname, salary, managerid)
	VALUES (8, 'Bloggs', 'Joe', 22500, 4);

INSERT INTO TBL_MNG(managerid, name)
	VALUES (4, 'Geraldine Metts');

/*
	### Question 6 ###
	Ted Stolz retires and Nancy Boswell is promoted to his position as CEO with his same line management responsibilities.
	Write queries to remove Ted from the TPERSON table and to update the rest of the employees’ details as necessary.
*/

-- update salary, equal to previous CEO
UPDATE TPERSON 
SET salary = (SELECT salary FROM TPERSON WHERE firstname = 'Ted' AND lastname = 'Stolz'),
	managerid = NULL
WHERE firstname = 'Nancy' AND lastname = 'Boswell';

-- update employee(s) managerid by reasigning previous CEO to the new CEO
UPDATE TPERSON
SET managerid = (SELECT personid FROM TPERSON WHERE firstname = 'Nancy' AND lastname = 'Boswell')
WHERE managerid = (SELECT personid FROM TPERSON WHERE firstname = 'Ted' AND lastname = 'Stolz')

-- remove Ted from the TPERSON table
DELETE FROM TPERSON
WHERE firstname = 'Ted' AND lastname = 'Stolz';
  
 /*
	### Question 7 (Advanced) ###
	Write a query that calculates the last day of the previous month (at the time it is run).
	For example, if it is run on 15th March 2011, it should return the date 28th February 2011.

	Answer:
	Syntax for CONVERT: CONVERT ( data_type [ ( length ) ] , expression [ , style ] )
	Date and Time Style: 106 = dd mon yyyy
 */
DECLARE @date datetime
SELECT @date = GETDATE() --current date
SELECT CONVERT(VARCHAR(45),DATEADD(dd,-(DAY(@date)),@date),106) AS 'Last day of the previous month'


