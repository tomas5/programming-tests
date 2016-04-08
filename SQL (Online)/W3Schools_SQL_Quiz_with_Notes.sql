/*
##########################
### W3Schools SQL Quiz ###
##########################
*/

-- 1. What does SQL stand for?

PRINT 'Structured Query Language'

GO
-- https://msdn.microsoft.com/en-us/library/ms176047.aspx
DECLARE @PrintMessage nvarchar(50);
SET @PrintMessage = N'This message was printed on '
    + RTRIM(CAST(GETDATE() AS nvarchar(30)))
    + N'.';
PRINT @PrintMessage;
GO

-- 2. Which SQL statement is used to extract data from a database?

SELECT

-- 3. Which SQL statement is used to update data in a database?

UPDATE

-- 4. Which SQL statement is used to delete data from a database?

DELETE

-- 5. Which SQL statement is used to insert new data in a database?

INSERT INTO

-- 6. With SQL, how do you select a column named "FirstName" from a table named "Persons"?

SELECT FirstName FROM Persons

-- 7. With SQL, how do you select all the columns from a table named "Persons"?

SELECT * FROM Persons

-- 8. With SQL, how do you select all the records from a table named "Persons" where the value of the column "FirstName" is "Peter"?

SELECT * FROM Persons WHERE FirstName='Peter'

-- 9. With SQL, how do you select all the records from a table named "Persons" where the value of the column "FirstName" starts with an "a"?

SELECT * FROM Persons WHERE FirstName LIKE 'a%'

-- 10. The OR operator displays a record if ANY conditions listed are true. The AND operator displays a record if ALL of the conditions listed are true

PRINT 'True'

DECLARE @OR_operator_displays_a_record_if_ANY_conditions_listed_are_true BIT = 'TRUE',
		@AND_operator_displays_a_record_if_ALL_of_the_conditions_listed_are_true BIT = 'TRUE';

IF	@OR_operator_displays_a_record_if_ANY_conditions_listed_are_true
	& 
	@AND_operator_displays_a_record_if_ALL_of_the_conditions_listed_are_true
	<>
	'False'
BEGIN
    PRINT N'True';
END
ELSE
    PRINT N'False';
GO

-- 11. With SQL, how do you select all the records from a table named "Persons" where the "FirstName" is "Peter" and the "LastName" is "Jackson"?

SELECT * FROM Persons WHERE FirstName='Peter' AND LastName='Jackson'

-- 12. With SQL, how do you select all the records from a table named "Persons" where the "LastName" is alphabetically between (and including) "Hansen" and "Pettersen"?

SELECT * FROM Persons WHERE LastName BETWEEN 'Hansen' AND 'Pettersen'


-- 13. Which SQL statement is used to return only different values?

SELECT DISTINCT

-- 14. Which SQL keyword is used to sort the result-set?

ORDER BY

-- 15. With SQL, how can you return all the records from a table named "Persons" sorted descending by "FirstName"?

SELECT * FROM Persons ORDER BY FirstName DESC

-- 16. With SQL, how can you insert a new record into the "Persons" table?

INSERT INTO Persons VALUES ('Jimmy', 'Jackson')

-- 17. With SQL, how can you insert "Olsen" as the "LastName" in the "Persons" table?

INSERT INTO Persons (LastName) VALUES ('Olsen')

-- 18. How can you change "Hansen" into "Nilsen" in the "LastName" column in the Persons table?

UPDATE Persons SET LastName='Nilsen' WHERE LastName='Hansen'

-- 19. With SQL, how can you delete the records where the "FirstName" is "Peter" in the Persons Table?

DELETE FROM Persons WHERE FirstName = 'Peter'

-- 20. With SQL, how can you return the number of records in the "Persons" table?

SELECT COUNT(*) FROM Persons