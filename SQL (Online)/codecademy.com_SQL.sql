/*
www.codecademy.com

SQLite Relational Database Management System (RDBMS)

https://www.codecademy.com/articles/sql-rdbms?r=master
https://www.codecademy.com/articles/sql-commands?r=master

A relational database is a database that organizes information into one or more tables.
A table is a collection of data organized into rows and columns. Tables are sometimes referred to as relations.

A column is a set of data values of a particular type.
A row is a single record in a table.
All data stored in a relational database is of a certain data type.

SQL statement - valid command. Statements always end in a semi-colon ;

CREATE TABLE is a clause. Clauses can also be referred to as commands.

culumn_1 data_type, column_2 type, etc.
is a parameter.
A parameter is a list of columns, data types, or values that are passed to a clause as an argument.

(id INTEGER, name TEXT, age INTEGER) is a list of parameters defining each column in the table and its data type

we will learn how to write queries to retrieve information from the database.
*/
CREATE TABLE celebs (id INTEGER, name TEXT, age INTEGER);


-- INSERT statement inserts new rows into a table.
-- VALUES is a clause that indicates the data being inserted
INSERT INTO celebs(id, name, age)
VALUES (1, 'justin bieber', 21);

SELECT * FROM celebs;

/*
SELECT statements are used to fetch data from a database.

SELECT is a clause that indicates that the statement is a query. You will use SELECT every time you query data from a database.

SELECT statements always return a new table called the result set.

* is a special wildcard character, it allows to select every column in a table without having to name each one individually.
*/

UPDATE celebs
SET age = 22
WHERE id = 1;

SELECT * FROM celebs;

/*
the UPDATE statement edits a row in the table. Use it when you want to change existing records.

UPDATE is a clause that edits a row in the table.
SET is a clause that indicates the column to edit.
WHERE is a clause that indicates which row(s) to update with the new column value.
*/

ALTER TABLE celebs ADD COLUMN
twitter_handle TEXT;

SELECT * FROM celebs;

/*
the ALTER TABLE statement added a new column to the table. Use it when you want to add columns to a table.

ALTER TABLE is a clause that lets you make the specified changes.

ADD COLUMN is a clause that lets you add a new column to a table.

*/

UPDATE celebs
SET twitter_handle = '@taylorswift13'
WHERE id = 4;

SELECT * FROM celebs;

DELETE FROM celebs WHERE twitter_handle IS NULL;

SELECT * FROM celebs;

/*
WHERE is a clause that lets you select which rows you want to delete.
IS NULL - is a condition in AQL that returns true when the value is NULL and false otherwise

*/

/*
SQL is a programming language designed to manipulate and manage data stored in relational databases.
A statement is a string of characters that the database recognizes as a valid command.
*/

SELECT name, imdb_rating FROM movies;


SELECT DISTINCT genre FROM movies;
-- SELECT DISTINCT is used to return unique values in the result set. It filters out all duplicate values.

SELECT * FROM movies WHERE imdb_rating > 8;
-- WHERE is a clause that indicates you want to filter the result set to include only rows where the following condition is true.

/*
> is an operator. Operators create a condition that can be evaluated as either true or false.
*/

SELECT * FROM movies
WHERE name LIKE 'Se_en';

-- LIKE is a special operator that can be used in a WHERE clause. To search for a specific pattern in a column.

-- name LIKE Se_en is a condition evaluating the name column for a specific pattern.

-- underscore '_' a wildcard character. The '_' means you can substitute any individual character here without breaking the pattern/

SELECT * FROM movies
WHERE name LIKE 'a%';

SELECT * FROM movies
WHERE name LIKE '%man%';

-- % is a wildcard character that matches zero or more missing letters in the pattern.
-- SQL is not case sensitive 

SELECT * FROM movies
WHERE name BETWEEN 'A' and 'J';

SELECT * FROM movies
WHERE year BETWEEN 1990 and 2000;

-- the BETWEEN operator is used to filter the result set within a certain range. The values can be numbers, text or dates.


SELECT * FROM movies
WHERE year BETWEEN 1990 and 2000 -- first condition in the WHERE clause.
AND genre = 'comedy'; -- is the second condition in the WHERE clause.

-- AND is an operator that combines two conditions.


SELECT* FROM movies
WHERE genre = 'comedy'
OR year < 1980;

-- oR is an operator that filters the result set to only include rows where either condition is true.

SELECT * FROM movies
ORDER BY imdb_rating DESC;

-- ORDER BY is a clause that indicates you want to sort the result set by a particular column either alphabetically or numerically.
-- DESC - descending order - high to low or Z-A
-- ASC - ascending order (low to high or A-Z)

SELECT * FROM movies
ORDER BY imdb_rating ASC
LIMIT 3;

-- LIMIT is a clause that lets you specify the maximum number of rows the result set will have.


/* ### Aggregate functions ### */

-- we are going to learn how to perform calculations using SQL

SELECT * FROM fake_apps;

SELECT COUNT(*) FROM fake_apps;

-- COUNT() is a function that takes the name of a column as an argument and counts the number of rows where the column is not NULL

SELECT COUNT(*) FROM fake_apps
WHERE price = 0;

SELECT price, COUNT(*) FROM fake_apps
GROUP BY price;

-- GROUP BY is a clause in SQL that is only used with aggregate functions.
--  It is used in collaboration with the SELECT statement to arrange identical data into groups

SELECT price, COUNT(*) FROM fake_apps
WHERE downloads > 20000
GROUP BY price;

SELECT price, COUNT(*), downloads FROM fake_apps
WHERE downloads > 20000
GROUP BY price;

-- here, it adds all the values in the downloads column.
SELECT SUM(downloads) FROM fake_apps;

-- SUM() is a function that takes the name of a column as an argument and returns the sum of all the values in that column.


SELECT category, SUM(downloads) FROM fake_apps
GROUP BY category;


SELECT MAX(downloads) FROM fake_apps;
-- MAX() is a function that takes the name of the column as an argument and returns the largest value in that column.

-- return the names of the most downloaded apps in each category:
SELECT name, category, MAX(downloads)
FROM fake_apps
GROUP BY category;


SELECT MIN(downloads) FROM fake_apps;
SELECT name, MIN(downloads) FROM fake_apps;
-- MIN() is a function that takes the name of a column as an argument and returns the smallest value in that column.


SELECT name, category, MIN(downloads)
FROM fake_apps
GROUP BY category;

-- The AVG() function works by taking  column name as an argument and returns the average value for that column.
SELECT AVG(downloads) FROM fake_apps;


SELECT price, AVG(downloads) FROM fake_apps
GROUP BY price;

-- ROUND() is a function that takes a column name and an integer as an argument. 
--  It rounds the values in the column to the number of decimal places specified by the integer.
SELECT price, ROUND(AVG(downloads), 2) FROM fake_apps
GROUP BY price;

-- round the average number of downloads to the nearest integer for each price:
SELECT price, ROUND(AVG(downloads))
FROM fake_apps
GROUP BY price;

/* ### Multiple Tables #### */

-- This is one of the most powerful features of relational databases.

CREATE TABLE artists (id INTEGER PRIMARY KEY, name TEXT);

/*
A primary key serves as a unique identifier for each row or record in a given table.

The primary key is literally an ID value for a record ( a table can not have more than one PRIMARY KEY column.

By specifying that the ID column is the PRIMARY KEY, SQL makes sure that:
- None of the values in this column are NULL
- Each value in this column is unique
*/

SELECT * FROM albums;
SELECT * FROM artists;


SELECT * FROM artists WHERE id = 3;
SELECT * FROM albums WHERE artist_id = 3;

/*
A foreign key is a column that contains the primary key of another table in the database.

We use foreign keys and primary keys to connect rows in two different tables.


*/

-- a single query that combines data from  both tables:
-- multiple table names separated by a comma. This is also known as a cross join
-- table_name.column_name
-- the result of this cross join is not very useful. It combines every row of the artists table with every row of the albums table.
SELECT albums.name, albums.year, artists.name 
FROM albums, artists;


SELECT * FROM albums
JOIN artists ON albums.artist_id = artists.id;
-- JOIN artists ON - specifies the type of join we are going to use as well as the name of the second table


/* Outer joins also combine rows from two or more tables, but unlike inner joins, they do not require the join condition to be met.
NULL value used to fill in the columns from the right side.
*/
SELECT * FROM albums
LEFT JOIN artists ON albums.artist_id = artists.id;



SELECT 
  albums.name AS 'Album',
  albums.year,
  artists.name AS 'Artist'
 FROM
 	albums
 JOIN artists ON
 	albums.artist_id = artists.id
 WHERE
 	albums.year > 1980;

-- AS is a keyword in SQL that allows you to rename a column or table using an alias.

-- Foreign Key is a column that contains the primary key to another table in the database. It is used to identify a particular row in the referenced table.
