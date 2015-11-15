USE master
GO

IF OBJECT_ID('people') IS NOT NULL
    DROP TABLE people;
GO

/*
IF OBJECT_ID('people') IS NULL
CREATE TABLE people
(...)
*/

-- Assume a table called 'people' with the following definition:
CREATE TABLE people
(
	id		  int PRIMARY KEY NOT NULL ,
	father_id int NULL, -- foreign key to (person) id
	mother_id int NULL  -- foreign key to (person) id
)

-- and the following data:
BEGIN
	INSERT people VALUES (1, 11, 201), (2, 12, 201), (3, 13, 203), (4, NULL, 205)
	INSERT people VALUES (5, 13, NULL), (6, NULL, NULL), (7, NULL, 206), (8, 16, NULL)
END
GO

/*
Write a SELECT query to return all the data in the 'person'table
*/

SELECT 'All people' AS Title, * 
FROM people

/*
Write a SQL query to find all people who do not have chirdren.
*/

/* Answer */
SELECT 'People_who_do_not_have_chirldren' AS Title, * 
FROM people AS p
WHERE father_id IS NULL AND mother_id IS NULL

/* Discussion */
SELECT 'Example 1' AS Title, * 
FROM people AS p1
JOIN people AS p2 ON p1.id = p2.father_id OR p1.id = p2.mother_id
WHERE p1.id is NULL;

SELECT 'Example 2' AS Title, * 
FROM people AS p
WHERE NOT EXISTS
			(SELECT * FROM people AS p1
			WHERE p1.mother_id = p.id OR p1.father_id =p.id);

-- https://msdn.microsoft.com/en-us/library/ms188336.aspx
SELECT *
FROM people
WHERE EXISTS (SELECT NULL)
-- Returns TRUE if a subquery contains any rows.

SELECT *
FROM people
WHERE NOT EXISTS (SELECT NULL)