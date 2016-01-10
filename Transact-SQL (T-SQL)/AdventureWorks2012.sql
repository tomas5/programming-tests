/*
SQL Server Management Studio (SSMS)
-- --------------------------------
The sample database can be download from:
http://msftdbprodsamples.codeplex.com/

The direct link to download 'AdventureWorks2012_Data.mdf':
https://msftdbprodsamples.codeplex.com/downloads/get/165399

SSMS -> Connect to your server ->
 Right-click on the database ->
 click the 'Attach...' button ->
 under 'Datatabases to attach' section click 'Add..' button to specify the MDF File Location ->
 under 'AdventureWorks2012' database details select File Type: Log which indicates 'Not Found' and confirm by clicking 'Remove' ->
 confirm everything by clicking 'OK' button.
*/

use AdventureWorks2012
go

-- to view all tables under 'AdventureWorks2012' database
-- select DB_NAME(DB_ID())
select * from sys.tables 

-- improved query:
select SCHEMA_NAME(schema_id) as 'schema', name from sys.tables
-- advise: sort by schema name
-- select SCHEMA_NAME(schema_id) as 'schema', name from sys.tables order by SCHEMA_NAME(schema_id)

/*
schema : database : table = floor plan (blueprint) : house : room
*/

select * from HumanResources.Employee
-- same as: select * from [HumanResources].[Employee]

-- to see information about a database object (note: we need to quote the object name):
exec sp_help 'HumanResources.Employee'

/* Task 1. */
-- write a SELECT query to return all the data in the HumanResources.Employee table
select * from HumanResources.Employee

/* Task 2. */
-- write a SELECT query to return the LoginID and Job Title (only two columns) of all the employees in HumanResources.Employee
select LoginID, JobTitle from HumanResources.Employee

/* Task 3. */
-- write a conditional select query
select * from HumanResources.Employee where JobTitle = 'Design Engineer'

/* Task 4. */
-- write a conditional select query which begins with a wild card
select * from HumanResources.Employee where JobTitle like 'd%'

/* Task 5. */
-- write a conditional select query which contains a wild card where first letter is 'd' and last letter is 'r'
select * from HumanResources.Employee where JobTitle like 'd%r'-- begins with a letter 'd' and ends with a letter 'r'

/* Task 6. */
-- write a conditional select query which contains a single wild card character
select * from HumanResources.Employee where JobTitle like 'Design Enginee_'
-- another example:
select * from HumanResources.Employee where JobTitle like 'D_s_g_ Engineer'

/* Task 7. */
--Left outer joins query which will contain all the data from table: HumanResources.Employee and table: Person.Person
-- including data from table Person.Person that is not related to the table HumanResources.Employee
select he.LoginID, pp.FirstName, pp.LastName, he.JobTitle, he.Gender, he.MaritalStatus from HumanResources.Employee as he
left outer join Person.Person as pp on he.BusinessEntityID = pp.BusinessEntityID
-- inner join can be written like below (note: 'inner join' = 'join'):
-- inner join Person.Person as pp on he.BusinessEntityID = pp.BusinessEntityID

/* Task 8. */
-- write a SELECT query with the IN statement
select * from HumanResources.Employee where JobTitle in ('Production Technician - WC20', 'Production Supervisor - WC45')


/* Task 9. */
-- write a SELECT query where defined list may be the result of a sub query which is used with the IN statement.
select he.LoginID, pp.FirstName, pp.LastName, he.JobTitle, he.Gender, he.MaritalStatus from HumanResources.Employee as he
left outer join Person.Person as pp on he.BusinessEntityID = pp.BusinessEntityID
-- note: with 'NOT IN' and '<>' we execute double negative
where he.BusinessEntityID not in (select BusinessEntityID from HumanResources.Employee where MaritalStatus <> 'S')

/* Task 10. */
-- NOT IN - can be used to do an exclusion query while EXISTS is a command that will allow you to join the subquery
-- This query uses EXISTS:
SELECT a.FirstName, a.LastName
FROM Person.Person AS a
WHERE EXISTS
(SELECT * 
    FROM HumanResources.Employee AS b
    WHERE a.BusinessEntityID = b.BusinessEntityID
    AND a.LastName = 'Johnson');
GO

-- This query uses IN:
SELECT a.FirstName, a.LastName
FROM Person.Person AS a
WHERE a.LastName IN
(SELECT a.LastName
    FROM HumanResources.Employee AS b
    WHERE a.BusinessEntityID = b.BusinessEntityID
    AND a.LastName = 'Johnson');
GO

/* Task 11. */
-- write a SELECT query which returns the top n lists
-- find the top 5 oldest active employees
select top 5 LoginID, JobTitle, BirthDate from HumanResources.Employee order by BirthDate asc

--find the top 5 youngest active employees
select top 5 LoginID, JobTitle, BirthDate from HumanResources.Employee order by BirthDate desc

/* Task 12. */
-- find the 100th oldest employee
-- to do so - we need to get the top 100 first and then flip the list over to get the top 1

select top 1 age.LoginID from (select top 100 * from HumanResources.Employee order by BirthDate asc) as age
order by age.BirthDate desc

/* Task 13. */
-- we may use in-build RowNumber() to return nth oldest employee (person)
-- RowNumber syntax is: ROW_NUMBER ( ) OVER ( [ PARTITION BY value_expression , ... [ n ] ] order_by_clause )
-- 'x' to increment the row count for each row
select *
from (
	select he.LoginID, ROW_NUMBER() OVER (PARTITION BY 'x' order by he.BirthDate asc) as rowNum
from HumanResources.Employee as he 
) age
where age.rowNum = 100


-- example using ROW_NUMBER() with PARTITION
SELECT FirstName, LastName, TerritoryName, ROUND(SalesYTD,2,1),
ROW_NUMBER() OVER(PARTITION BY 'x' ORDER BY SalesYTD DESC) AS Row
FROM Sales.vSalesPerson
WHERE TerritoryName IS NOT NULL AND SalesYTD <> 0
ORDER BY TerritoryName;


/* Task 14. */
-- write a case statement which will be used to apply additional logic to query
select LoginID, JobTitle, BirthDate,
Case
	when BirthDate <= '1970-01-01' then 'old'
	else 'young'
	end as ageStatus
from HumanResources.Employee

/* Task 14. */
-- nested case statement used to apply additional logic to querys

select LoginID, JobTitle, BirthDate,
Case
	when BirthDate <= '1970-01-01' then 
		-- following case only applies to those born before 1970
		case
			when BirthDate <= '1950-01-01' then 'really old'
			else 'old'
		end
	-- part of original case
	else 'young'
	end as ageStatus
from HumanResources.Employee

/* Task 15. */
-- write a SQL query to get most recent rowfrom tables with
select LoginID, MAX(ModifiedDate) as  'Last modified date'
from HumanResources.Employee
group by LoginID

select * from HumanResources.Employee


/* Task 15. */
/*
The following example uses the MIN, MAX, AVG and COUNT functions
 with the OVER clause to provide aggregated values for each department
  in the HumanResources.Department table in the AdventureWorks2012 database.
*/

SELECT DISTINCT Name
       , MIN(Rate) OVER (PARTITION BY edh.DepartmentID) AS MinSalary
       , MAX(Rate) OVER (PARTITION BY edh.DepartmentID) AS MaxSalary
       , AVG(Rate) OVER (PARTITION BY edh.DepartmentID) AS AvgSalary
       ,COUNT(edh.BusinessEntityID) OVER (PARTITION BY edh.DepartmentID) AS EmployeesPerDept
FROM HumanResources.EmployeePayHistory AS eph
JOIN HumanResources.EmployeeDepartmentHistory AS edh
     ON eph.BusinessEntityID = edh.BusinessEntityID
JOIN HumanResources.Department AS d
 ON d.DepartmentID = edh.DepartmentID
WHERE edh.EndDate IS NULL
ORDER BY Name;


/* Task 16. */
-- playground

-- create a copy of the table:
select * INTO EmployeeTableCopy FROM HumanResources.Employee
select * from EmployeeTableCopy
-- note: column does not allow nulls, so we need to specify each column as its value.
insert into EmployeeTableCopy (BusinessEntityID, LoginID, ModifiedDate, NationalIDNumber, JobTitle, BirthDate)
	   values (1000, 'username', '2016-07-31 00:00:00.000', '0123456789', 'CTO', '2003-03-02')


/*
Returns the number of active transactions for the current connection.

0, not in a transaction
1, in a transaction
n, in a nested transaction
*/
select @@TRANCOUNT 

/*
XACT_STATE() reports the transaction state of a session,
 indicating whether or not the session has an active transaction,
  and whether or not the transaction is capable of being committed.
   It returns three values:

1, The session has an active transaction. The session can perform any actions, including writing data and committing the transaction.
0, There is no transaction active for the session.
-1, The session has an active transaction, but an error has occurred that has caused the transaction to be classified as an uncommittable transaction. The session cannot commit the transaction or roll back to a savepoint; it can only request a full rollback of the transaction. The session cannot perform any write operations until it rolls back the transaction. The session can only perform read operations until it rolls back the transaction. After the transaction has been rolled back, the session can perform both read and write operations and can begin a new transaction.
*/
select  XACT_STATE()


-- Returns information about transactions for the instance of SQL Server:
select * from sys.dm_tran_active_transactions
-- reference:
-- https://msdn.microsoft.com/en-us/library/ms174302.aspx


-- begin transaction to insert new value reusing the existing data
select * from HumanResources.Employee

begin transaction
insert into EmployeeTableCopy
select 1000,NationalIDNumber,LoginID,OrganizationNode,OrganizationLevel,JobTitle,BirthDate,MaritalStatus,Gender,HireDate,SalariedFlag,VacationHours,SickLeaveHours,CurrentFlag,rowguid,ModifiedDate
from HumanResources.Employee where BusinessEntityID = 1

--rollback
-- commit

select * from EmployeeTableCopy



