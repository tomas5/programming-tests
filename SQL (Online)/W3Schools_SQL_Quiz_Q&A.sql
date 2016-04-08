/*
	### W3Schools SQL Quiz ###
*/

/*
	Q: What does SQL stand for?
	A: Structured Query Language
*/

/*
	Q: Which SQL statement is used to extract data from a database?
	A: SELECT
*/

/*
	Q: Which SQL statement is used to update data in a database?
	A: UPDATE
*/

/*
	Q: Which SQL statement is used to delete data from a database?
	A: DELETE
*/

/*
	Q: Which SQL statement is used to insert new data in a database?
	A: INSERT INTO
*/

/*
	Q: With SQL, how do you select a column named "FirstName" from a table named "Persons"?
	A: SELECT FirstName FROM Persons
*/

/*
	Q: With SQL, how do you select all the columns from a table named "Persons"?
	A: SELECT * FROM Persons
*/

/*
	Q: With SQL, how do you select all the records from a table named "Persons" where the value of the
		column "FirstName" is "Peter"?
	A: SELECT * FROM Persons WHERE FirstName='Peter'
*/

/*
	Q: With SQL, how do you select all the records from a table named "Persons" where the value of the
		column "FirstName" starts with an "a"?
	A: SELECT * FROM Persons WHERE FirstName LIKE 'a%'
*/

/*
	Q: The OR operator displays a record if ANY conditions listed are true. The AND operator displays a
		record if ALL of the conditions listed are true
	A: True
*/

/*
	Q: With SQL, how do you select all the records from a table named "Persons" where the "FirstName" is
		"Peter" and the "LastName" is "Jackson"?
	A: SELECT * FROM Persons WHERE FirstName='Peter' AND LastName='Jackson'
*/

/*
	Q: With SQL, how do you select all the records from a table named "Persons" where the "LastName" is
		alphabetically between (and including) "Hansen" and "Pettersen"?
	A: SELECT * FROM Persons WHERE LastName BETWEEN 'Hansen' AND 'Pettersen'
*/

/*
	Q: Which SQL statement is used to return only different values?
	A: SELECT DISTINCT
*/

/*
	Q: Which SQL keyword is used to sort the result-set?
	A: ORDER BY
*/

/*
	Q: With SQL, how can you return all the records from a table named "Persons" sorted descending by
		"FirstName"?
	A: SELECT * FROM Persons ORDER BY FirstName DESC
*/

/*
	Q: With SQL, how can you insert a new record into the "Persons" table?
	A: INSERT INTO Persons VALUES ('Jimmy', 'Jackson')
*/

/*
	Q: With SQL, how can you insert "Olsen" as the "LastName" in the "Persons" table?
	A: INSERT INTO Persons (LastName) VALUES ('Olsen')
*/

/*
	Q: How can you change "Hansen" into "Nilsen" in the "LastName" column in the Persons table?
	A: UPDATE Persons SET LastName='Nilsen' WHERE LastName='Hansen'
*/

/*
	Q: With SQL, how can you delete the records where the "FirstName" is "Peter" in the Persons Table?
	A: DELETE FROM Persons WHERE FirstName = 'Peter'
*/

/*
	Q: With SQL, how can you return the number of records in the "Persons" table?
	A: SELECT COUNT(*) FROM Persons
*/
