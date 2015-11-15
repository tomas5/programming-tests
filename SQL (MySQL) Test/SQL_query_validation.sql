/* SQL query syntax validation */

IF OBJECT_ID('products') IS NOT NULL
	DROP TABLE products;
GO

CREATE TABLE products
(
	id	int PRIMARY KEY NOT NULL,
	product varchar(50) NULL
)

-- INSERT INTO
INSERT products VALUES (1, 'apple'), (2, 'banana'), (3, 'orange');

-- ### 1 ###

/*
SELECT id, COUNT(id) AS total
FROM products
WHERE total > 5
GROUP BY id
ORDER BY id;
*/

/*
Answer:		Invalid syntax. 
Message:	Invalid column name 'total'.
Notes:		Identifier 'total' is not specified in the 'products' table
*/

-- ### 2 ###

/*
SELECT id, COUNT(id) AS total
FROM products
GROUP BY id
HAVING total > 5
ORDER BY id;
*/

/*
Answer:		Invalid syntax. 
Message:	Invalid column name 'total'.
Notes:		The same as Example 1 - Identifier 'total' is not specified in the 'products' table
*/

-- ### 3 ###

SELECT id, COUNT(id)
FROM products
WHERE id > 2
GROUP BY id
ORDER BY id;

/*
Answer:		Valid syntax. 
*/

-- ### 4 ###

SELECT id, COUNT(id)
FROM products
GROUP BY id
HAVING id > 2
ORDER BY id;

/*
Answer:		Valid syntax. 
*/