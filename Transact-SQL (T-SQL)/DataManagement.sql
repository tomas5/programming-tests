/* 
###########################
###		 Data Management 				###
###########################
*/

/* ** INTRO ** */

/*
The following tables store the data related to a company with several departments located in different cities. If necessary, you may assume that numeric columns are stored as integers or floats and that all other columns are stored as character strings. Where appropriate, you may assume that the database tables are owned by an administrator account, and that staff connect to the database using  staff account.
*/

/* ** QUESTIONS ** */

-- Q1
-- Explain why you think the 'Employee' table exhibits referential integrity

-- Q2
-- What is the result of executing the following statement
INSERT INTO Employee
VALUES(JG22222, Jo, Flecher,12 James Road Inverness, F);

-- Q3
-- 'A database can be defined as a shared collection of logically related data and its Metadata'. Explain what is meant by Metadata in this definition.

-- Q4
-- Define what is meant by third normal form (3NF).

-- Q5
-- Explain why the 'Dependent' table is in third normal form. (Assume that Dependent table has NINo, Dependant_FName and Relationship as primary key).

-- Q6
-- A friend of yours after critically examining the above database makes the following comment:
-- 'The PLocation attribute in Project table should be removed because the PLocation information can be determined by the DNo foreign key'
-- Write your response to the above comment.

-- Q7
-- In SQL, give one example of a Data Control Language (DCL) statement ( use the Employee table if you need to refer to a table in your answer).

-- Q8
-- Write an SQL statement to update the salary of the employees working in the production department by £1500.

-- Q9
-- Write an SQL statement to change the Employee table by adding a new column representing date of birth of employees. You can set the column (field) data type to be CHAR type

-- Q10
-- Write an SQL query to show the first and last names of those employees who have dependents and also show the number of dependents for each of these employees. Sort the list in the alphabetical order of employee first name and last name.

-- Q11
-- Explain how views and privileges help you to achieve fine grain access control over data in database tables.

-- Q12
-- In relational databases, what is an index?

-- Q13
-- With the help of simple sketches show how indexing works. If required use the Department table as an example.

-- Q14
-- In relation to implementing secure database transactions over the internet, briefly explain the purpose of using public key / private key encryption, digital signatures, and digital certificates.

-- Q15
-- What is meant by second normal form (2NF)? Examine the Employee table to check if it is in 2NF. If yes, explain your answer. Otherwise convert the table into 2NF. (Assume NINo and Supervisor_NINo are Primary Keys).

-- Q16
-- Explain the advantages of using a database system in place of a file system.

-- Q17
-- In the context of relational databases, explain what is meant by the terms entity integrity and referential integrity?

-- Q18
-- Explain the difference between conceptual, logical and physical levels in the context of databases.

-- Q19
-- In SQL, give one example of each of the DML, DDL, DCL types of statements (use the Employee table if you need to refer to a table in your answer)

-- Q20
-- Write an SQL statement to add a new  project to the Project table. The new project is entitled ' Recall C', has a project location of 'Perth'.

-- Q21
-- Using only Employee table, write an SQL query to show the average salary for different departments, labelling the results column as 'AverageSalary'.

-- Q22
-- Using only the Works_On table, write an SQL query to show the total hours of all employees working on each project, showing the results in order of project number.

-- Q23
-- Write an SQL query to list the full names of all the employees supervised by Alicia	Zelaya.

-- Q24
-- Write an SQL query to show the project names and full names of the employees working more than 100 hours per project.

-- Q25
-- Briefly describe the four fundamental requirements for database transactions which the acronym "ACID" represents.

-- Q26
-- Compare and contrast the steps involved in interacting with a database programmatically in the context of a standalone application developed using Java and web based application developed using PHP.

-- Q27
-- Describe two techniques for indexing spatial databases.

-- Q28
-- Describe three differences between the MYISAM and INNODB table types in MySQL.

-- Q29
-- What is a query?
-- Answer: A query is a request for data or information from a database table or combination of tables.


  
