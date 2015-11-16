
/*
What is the definition of INNER JOIN in MySQL?

1. Selects all records from the first database table and only those records from the second table that have matching values.

2. Selects records from both database tables with matching values.

3. Select records from both database tables with NO matching values.

4. None of the above.
*/

/* Answer (My guess):
4. None of the above.

Discussion:

13.2.9.2 JOIN Syntax
https://dev.mysql.com/doc/refman/5.7/en/join.html

In MySQL, JOIN, CROSS JOIN, and INNER JOIN are syntactic equivalents (they can replace each other).
In standard SQL, they are not equivalent.
INNER JOIN is used with an ON clause, CROSS JOIN is used otherwise.

SQL INNER JOIN Keyword
http://www.w3schools.com/sql/sql_join_inner.asp

The INNER JOIN keyword selects all rows from both tables as long as there is a match between the columns in both tables.

Using Joins
https://msdn.microsoft.com/en-us/library/ms191472.aspx

Inner joins use a comparison operator to match rows from two tables based on the values in common columns from each table.
*/


/*
Which of the following will be the result of the following SQL query?
*/

-- ALTER TABLE _table_ ADD UNIQUE (_field_);

/*
Availabe options:
1. The new unique field "_field_" will be created in the "_table_" table.

2. The new field "_field_" will be created in the "_table_" table.

3. The "_field_" field in the "_table_"table will get the unique property.

4. None of the above.
*/

/*
Asnwer (my guess):
3. The "_field_" field in the "_table_"table will get the unique property.
*/

/*
Discussion:

In my own words I would explain as: we are creating a unique constraint on the column "_field_" on he existing table "_table_".

Create Unique Constraints
https://msdn.microsoft.com/en-us/library/ms190024.aspx

You can create a unique constraint to ensure no duplicate values are entered in specific columns 
	that do not participate in a primary key.
*/


/*
When you want to display only rows 30 throuh 60 of your results.
*/
SET NOCOUNT ON;
IF OBJECT_ID('tableOfData') IS NOT NULL
    DROP TABLE tableOfData;
GO

CREATE TABLE tableOfData
(
	id INT
)
GO

DECLARE @value int, @dataSize int;
-- CAST(@value AS varchar)
SET @dataSize = 100;
SET	@value = 1;
WHILE @dataSize > 0
	BEGIN
		INSERT tableOfData
			SELECT 
				--NEWID()
				@value
		SET @dataSize -= 1
		SET	@value +=1
	END
GO
/*
Which clause should you add to your SQL query?

1. ROW_NUMBER IS 30-60
2. ROW_NUMBER FROM 30 TO 60
3. LIMIT 30,60
4. LIMIT START 30 END 60
*/

--SELECT * FROM  WHERE ROW_NUMBER IS 3

/*
Answer:
LIMIT 30,60

http://dev.mysql.com/doc/refman/5.7/en/limit-optimization.html
SELECT ... FROM single_table ... ORDER BY non_index_column [DESC] LIMIT [M,]N;
Return the first N rows from the queue. (If M was specified, skip the first M rows and return the next N rows.)
*/

/*
Discussion:

ROW_NUMBER (Transact-SQL)
https://msdn.microsoft.com/en-us/library/ms186734.aspx
*/

-- T-SQL: Include row number
SELECT ROW_NUMBER() OVER(ORDER BY id) AS RowNum, id -- (ORDER BY id DESC)
FROM tableOfData

-- T-SQL: Workaround for the MySQL's LIMIT clause
SELECT *
FROM
(
	-- SELECT *, ROW_NUMBER() OVER (ORDER BY id desc ) as RowNum FROM tableOfData
	SELECT ROW_NUMBER() OVER (ORDER BY id) as RowNum, * FROM tableOfData
) AS something
WHERE RowNum >= 30 and RowNum <= 60
--ORDER BY RowNum DESC

SELECT TOP 30 * FROM tableOfData ORDER BY id desc;

SELECT TOP 50 PERCENT * FROM tableOfData;
-- my own solution would be:
SELECT TOP 60 * FROM (SELECT TOP 30 * FROM tableOfData) as a
