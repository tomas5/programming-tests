/*
###################################
#### Employee & Manager Test.2 ####
###################################
*/

/*
	SET NOCOUNT { ON | OFF } - Stops the message that shows the count of the number of rows affected by a Transact-SQL statement
	or stored procedure from being returned as part of the result set.
*/
SET NOCOUNT ON;

/*
	### Part I ###
*/

DROP TABLE TBL_EMP;
DROP TABLE TBL_MNG;

CREATE TABLE TBL_EMP
(
	empid INT IDENTITY(1,1),--integer, primary key, identity starting at 1, increments by 1
	managerid INT DEFAULT NULL, -- int, allows nulls, by default NULL
	name VARCHAR(50) NOT NULL, --string of 50 characters
	salary MONEY NOT NULL, --money
	constraint pk_empid PRIMARY KEY(empid),
	constraint u_empid UNIQUE(empid),
	constraint ck_salary CHECK(salary >= 0)
	/*
	constraint fk_managerid FOREIGN KEY(managerid)
		references TBL_MNG(managerid)
	*/
);

CREATE TABLE TBL_MNG
(
	managerid INT DEFAULT NULL, -- int, allows nulls, by default NULL
	name VARCHAR(50) NOT NULL, --string of 50 characters
	constraint pk_managerid PRIMARY KEY(managerid),
	constraint u_managerid UNIQUE(managerid)
);
SET IDENTITY_INSERT TBL_EMP ON

INSERT INTO TBL_EMP (empid, managerid, name, salary)
SELECT 1, 123, 'Luke Brown', 15000 UNION ALL
SELECT 2, NULL, 'Adam Smith', 20000 UNION ALL
SELECT 3, 156, 'Jon London', 30000 UNION ALL
SELECT 4, 145, 'Adam Lemon', 40000 UNION ALL
SELECT 5, NULL, 'Kate Smith', 55000 UNION ALL
SELECT 6, 145, 'Jack Sugar', 60000 UNION ALL
SELECT 7, NULL, 'Debbie Bond', 65000 UNION ALL
SELECT 8, 111, 'Adam Orange', 70000


INSERT INTO TBL_MNG(managerid, name)
SELECT 123, 'Ahmed' UNION ALL
SELECT 145, 'Bob' UNION ALL
SELECT 156, 'Alex' UNION ALL
SELECT 111, 'Daniel'

SET IDENTITY_INSERT TBL_EMP OFF


/*
	### Populate with an odd number of rows of test data ###
*/
SELECT * 
FROM (SELECT *, ROW_NUMBER() OVER (ORDER BY empid) AS RowNumber FROM TBL_EMP) A
WHERE RowNumber%2=1	-- MOD(RowNUmber,2)=1



/*
	BETWEEN, logical operator used to indicate an interval that includes the end points.
*/


UPDATE TBL_EMP
SET salary +=
CASE
	WHEN salary BETWEEN 20000 AND 39999 THEN 5000 
	WHEN salary BETWEEN 40000 AND 54999 THEN 7000
	WHEN salary BETWEEN 55000 AND 64999 THEN 9000
	/* 
		If the employee's salary it's more than £65000,
		the pay rise should be also increased by £9000
	*/
	WHEN salary >= 65000 THEN 9000
	ELSE 0
    END
WHERE salary >= 20000 AND salary <= 65000 --If based on scheme from Q1


/*
	Write a query which returns the name of each employee along with their manager’s name,
	or ‘No Manager’ if no manager is defined for the employee
*/

SELECT DISTINCT e.name AS 'Name', CASE WHEN e.managerid IS NULL THEN 'No Manager' ELSE m.name END AS 'Manager' 
FROM TBL_EMP AS e, TBL_MNG AS m
WHERE e.managerid=m.managerid OR e.managerid IS NULL
ORDER BY e.name


/*
	Write a query to return the name of the employee(s) with the second lowest salary.
	Query is used to find the second lowest salary of the table.
*/
SELECT empid, managerid, name, salary FROM ( SELECT *,RANK() OVER ( ORDER BY salary) AS Test FROM TBL_EMP ) A WHERE Test=2


/*
	### Part II ###
*/

/*
	### Question 4 ###
	You are working for an organization which has not upgraded from SQL Server 2000.
	This question asks you to generate row numbers in SQL Server 2000 (where the ROW_NUMBER(),
	RANK() functions are not available!) in a single SELECT query.
*/

/* How would you write a query to return employees names with:
- IDs
- in descending name order
-  but with ascending row numbers?
*/

/*
------------------------				------------------------------------
| empid |	name    |				| empid |	name   | rownum |
----------+------------				---------+-----------+-------------
|  1		|	Diana	|				|  1	  	|	Diana	|		1		 |
|  2		|	Alex		|  		 => 	|  3		|	Clark	|   	2		 |
|  3		|	Clark	|				|  4		|	Buffi		|		3		 |
|  4 		|	Buffi		|				|  2 		|	Alex		|		4		 |
-----------------------				-------------------------------------
*/

/* For  SQL Server 2005+ */
SELECT empid, name, ROW_NUMBER() OVER(ORDER BY name DESC) AS 'rownum'
FROM TBL_EMP

/* For  SQL Server 2000 */
/*
	IDENTITY property uses three parameters:
		Datatype of the identity column
		Seed - starting value
		Increment - value that is added to the identity value (seed)
*/

SELECT CAST(empid AS INT)empid ,name, IDENTITY(INT,1,1) AS 'rownum'
INTO TBL_TEMP
FROM TBL_EMP
ORDER BY name DESC 

SELECT * FROM TBL_TEMP
DROP TABLE TBL_TEMP

/* 
	### Question 4 - Alternative (option) answer ###
	To declare table variables in procedure with the DECLARE statement and assigning values by using SELECT statement.
*/
DECLARE @TBL_TEMP TABLE (
	empid INT,
    name VARCHAR(45),
	rownum INT IDENTITY(1,1)
)

INSERT INTO @TBL_TEMP
SELECT empid, name
FROM TBL_EMP
ORDER BY name DESC

SELECT * FROM @TBL_TEMP


/*
	### Question 5 ###
*/
/*
	(i) What is wrong with the following method?

	Answer:
	We cannot use Identity statement in Select because it has to be used while creating TBL_TEMP
*/

/*
	(ii) How would you fix it with as few code changes as possible?
*/
DROP TABLE #TEMPOUT;

SELECT CAST(empid as int)empid, name, identity(int,1,1) AS rownumber
INTO #TEMPOUT
FROM TBL_EMP e
ORDER BY name desc

SELECT * FROM #TEMPOUT

/*
	### Question 6 ###

	Write a trigger which, when the salary of any employee(s) is updated,
	inserts a single record into this audit table with the total amount of the change across all employees.

	e.g. if five employees were given £1000 pay cuts in a single update statement,
	the audit table should contain one row with values delta = £–5000, notes = ‘Salaries updated’

	Trigger documentation and implementation can be found at:
	http://msdn.microsoft.com/en-us/library/ms189799.aspx
*/

DROP TABLE TBL_EMP_AUDIT;

CREATE TABLE TBL_EMP_AUDIT
( 
	auditid int primary key identity(1,1),
	notes varchar(200),
	delta money,
	--to answer Q7
	updatetime datetime  --YYYY-MM-DD hh:mm:ss[.mmm]
);

-- Delete Trigger if INSTEAD OF UPDATE trigger already exists on this object.
IF OBJECT_ID('EMP_Table_Trigger') IS NOT NULL
	DROP TRIGGER EMP_Table_Trigger;

/*
	DML (Data Manipulation Language) triggers use the deleted and inserted logical (conceptual) tables.
	They are structurally similar to the table on which the trigger is defined,
	that is, the table on which the user action is tried.
	The deleted and inserted tables hold the old values or new values of the rows
	that may be changed by the user action. 

*/

GO
CREATE TRIGGER EMP_Table_Trigger
ON TBL_EMP
INSTEAD OF UPDATE
AS 
BEGIN
	DECLARE @originalSalary money;
	SET @originalSalary = (SELECT SUM(salary) FROM TBL_EMP WHERE empid in (SELECT empid FROM inserted))

	DECLARE @updatedSalary money;
	SET @updatedSalary = (SELECT SUM(salary) FROM inserted);

	DECLARE @finalSalary money;
	SET @finalSalary = (@updatedSalary - @originalSalary)

	INSERT TBL_EMP_AUDIT(notes, delta, updatetime)
	Values('Salaries updated', @finalSalary, GETDATE() );
END

GO
UPDATE TBL_EMP
SET salary -= 10000
WHERE managerid = 145

GO
SELECT * FROM TBL_EMP_AUDIT;

/*
UPDATE TBL_EMP
SET salary -= 10000
WHERE managerid=145

INSERT INTO TBL_EMP_AUDIT VALUES ('Salaries updated', '-5000', GETDATE());
INSERT INTO TBL_EMP_AUDIT VALUES ('Salaries updated', '-10000', GETDATE());

SELECT * FROM TBL_EMP_AUDIT
*/

/* 
	### Question 7 ###
	How would you add a column to the audit table to hold the time of the update, without altering the trigger written in (6)?

	Answer:
	I would insert an extra column with datetime Data Type in TBL_EMP_AUDIT table to hold the time of the update.
	Such as seen in 188 code line.
*/


/*
	### Question 8 ###

	Write an inline table-valued function that takes a single integer as a parameter and produces a record set with two columns.
	The first column should list ascending integers starting from one and continuing up to and including the parameter value.
	The second column, of type ‘varchar(8)’, 
	should contain the word ‘Flip’ if the integer in the first column is exactly divisible by three,
	‘Flop’ if the integer is exactly divisible by five,
	and ‘FlipFlop’ if the integer is exactly divisible by both three and five.
*/

/*
As a solution I would implement a rucursive CTE (Common Table Expression)
to reach desired size of a single integer value.
Then use query with CASE expresion to return one of multiple possible result expressions.

Please note limitation:
The statement terminated. The maximum recursion 100 has been exhausted before statement completion.
*/
GO
CREATE FUNCTION dbo.FlipFlopFunction
( 
	@firstColumn INT
)
RETURNS TABLE
AS
RETURN (

WITH FlipFlopTable (number) AS (
	SELECT 1 UNION ALL
	SELECT 1 + number FROM FlipFlopTable WHERE number < @firstColumn
	)
	SELECT number,
		FlipFlop= CASE
			WHEN number % 3 = 0 AND number % 5 = 0 THEN 'FlipFlop'
			WHEN number % 3 = 0 THEN 'Flip'
			WHEN number % 5 = 0 THEN 'Flop'
			ELSE CAST(number AS VARCHAR(8)) END
	FROM FlipFlopTable
)
GO

-- With the given task I will assume "a single integer as a parameter" sets END boundaries
SELECT * FROM dbo.FlipFlopFunction(15)

DROP FUNCTION FlipFlopFunction;

/*
--Solution without creating function
DECLARE @FizzBuzzTable TABLE(Number int, FizzBuzz varchar(45));
DECLARE @i int = 1;
WHILE @i <= 15
BEGIN
 INSERT INTO @FizzBuzzTable
   (Number, FizzBuzz)
 SELECT @i, FizzBuzz = CASE WHEN @i % 3 = 0 AND @i % 5 = 0 THEN 'Fizz Buzz'
   WHEN @i % 3 = 0 THEN 'Fizz'
   WHEN @i % 5 = 0 THEN 'Buzz'
   ELSE CAST(@i AS varchar(45)) END
 SET @i += 1
END

SELECT Number, FizzBuzz FROM @FizzBuzzTable
*/

/*
--Multi-Statement Table-Valued Function
-- @i - parameter value
GO
CREATE FUNCTION dbo.FizzBuzzFunction (@limit INT)
RETURNS @FizzBuzzTable TABLE (Number int, FizzBuzz varchar(8))
AS
BEGIN
 DECLARE @i int = 1;
 WHILE @i <= @limit
 BEGIN
	 INSERT INTO @FizzBuzzTable
	   (Number, FizzBuzz)
	 SELECT @i, FizzBuzz = CASE WHEN @i % 3 = 0 AND @i % 5 = 0 THEN 'FizzBuzz'
	   WHEN @i % 3 = 0 THEN 'Fizz'
	   WHEN @i % 5 = 0 THEN 'Buzz'
	   ELSE CAST(@i AS varchar(8)) END
	 SET @i += 1
 END
 RETURN;
END

GO
SELECT * FROM dbo.FizzBuzzFunction(15);
DROP FUNCTION FizzBuzzFunction;


*/
