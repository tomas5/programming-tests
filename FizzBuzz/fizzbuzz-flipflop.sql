/*

Write an inline table-valued function that takes a single integer as a parameter and produces a record set with two columns.
The first column should list ascending integers starting from one and continuing up to and including the parameter value.
The second column, of type ‘varchar(8)’, 
should contain the word ‘Flip’ if the integer in the first column is exactly divisible by three,
‘Flop’ if the integer is exactly divisible by five,
and ‘FlipFlop’ if the integer is exactly divisible by both three and five.

*/

/* To make execution time shorter (disable statistics which are printed on the console): */
-- SET NOCOUNT ON; 

USE master
GO

/*
As a solution I would implement a rucursive CTE (Common Table Expression)
to reach desired size of a single integer value.
Then use a query with the CASE expresion to return one of multiple possible result expressions.
*/

/*

CTE ( A Common Table Expression) can be thought of as a temporary result set.
A CTE is not stored as an object and lasts only for the duration of the query.
The basic syntax structure for a CTE:
WITH expression_name [...]
AS
(CTE_query_definition)

Recursion is the process of repeating items in a self-similar way.
For instance, when the surfaces of two mirrors are exactly parallel with each other,
the nested images that occur are a form of infinite recursion.

*/

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

-- Setting a single integer as a parameter to set the END boundaries
-- However there is a limition using rucursive that we cannot exceed cycle more than 100 times.
SELECT * FROM dbo.FlipFlopFunction(50)

-- DROP FUNCTION FlipFlopFunction;

