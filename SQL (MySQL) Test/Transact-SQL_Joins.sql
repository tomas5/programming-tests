/*
###########################
### Working with Tables ###
###########################
*/

/* Write a query which returns the following 'result' table. */
/*
    tbl1             tbl2                     result
------------    --------------      --------------------------
|id | name |    |id | letter |      |id | name | id | letter |
|----------|    |------------|      |------------------------|
|1  |  A   |    |2  |   D    |      | 1 |  A   |NULL|  NULL  | 
|2  |  B   |    |3  |   E    |      | 2 |  B   | 2  |   D    | 
|3  |  C   |    |4  |   F    |      | 3 |  C   | 3  |   E    | 
------------    --------------      --------------------------
*/

/*
SSMS (SQL Server Management Studio) use CTRL+T, 
	to tell the client application (SSMS) to show / render the results of the query in TEXT format.

Using CTRL+D in SSMS will show the results of the query in GRID format.
*/

IF OBJECT_ID('tbl1') & OBJECT_ID('tbl2') IS NOT NULL
BEGIN
	DROP TABLE tbl1
	DROP TABLE tbl2
END

CREATE TABLE tbl1
(
	id	int PRIMARY KEY NOT NULL,
	name varchar(50) NULL
)

CREATE TABLE tbl2
(
	id	int PRIMARY KEY NOT NULL,
	letter varchar(50) NULL
)

INSERT tbl1 VALUES (1, 'A'), (2, 'B'), (3, 'C')
INSERT tbl2 VALUES (2, 'D'), (3, 'E'), (4, 'F')

/* Answer */

SELECT * FROM tbl1
LEFT JOIN tbl2 ON tbl1.id = tbl2.id;

/*
id          name                                               id          letter
----------- -------------------------------------------------- ----------- --------------------------------------------------
1           A                                                  NULL        NULL
2           B                                                  2           D
3           C                                                  3           E
*/

/* Disccusion */

SELECT * FROM tbl1
FULL JOIN  tbl2
ON tbl1.id = tbl2.id

/*
id          name                                               id          letter
----------- -------------------------------------------------- ----------- --------------------------------------------------
1           A                                                  NULL        NULL
2           B                                                  2           D
3           C                                                  3           E
NULL        NULL                                               4           F
*/