--Coding challenge for SQL--
--Initial thoughts: there are 3 tables, all of which have foreign/primary keys, and i need to write this in sql

--First I need to create the Department Table, because it has no foreign keys referecing it.
--in other words, it is an independant table

Create Table Department
(
    ID_PK int Primary Key,
    Department_name varchar(50), --this tag is used cause name is a keyword
    Department_location varchar(100) --this tag is used cause location is a keyword
)

--now that department table is done, I can create other tables that reference it, so employee is next
Create Table Employee
(
    ID_PK int Primary Key,
    FirstName varchar(30),
    LastName varchar(30),
    SSN varchar(9),
    Dept_IDFK int,
    FOREIGN KEY(Dept_IDFK) references Department(ID_PK)

)

Create Table empDetails
(
    ID_PK int Primary Key,
    Salary FLOAT,
    Address1 varchar(100),
    Address2 varchar(100),
    City varchar(50),
    Employee_State varchar(30), --this tag was used cause state is a keyword
    Country varchar(50),
    EmployeeIDFK int,
    FOREIGN KEY(EmployeeIDFK) REFERENCES Employee(ID_PK)
)

--now that the tables are created i can start to insert some data

--adding 3 records into deparment table
INSERT INTO Department (ID_PK, Department_name, Department_location)
VALUES ('1', 'shoes', 'west mall'),('2','clothing','east mall'), ('3', 'jewelry', 'south mall')

--adding 3 records into employee table
INSERT INTO Employee (ID_PK, FirstName, LastName, SSN, Dept_IDFK)
VALUES ('1','Jane', 'Smith', '333445555', '1'), ('2', 'Tyler', 'Home', '111223333', '2'), ('3', 'Vince', 'White', '333221111', '3')

--adding 3 records into empdetails table
INSERT INTO empDetails (ID_PK, Salary, Address1, Address2, City, Employee_State, Country, EmployeeIDFK)
VALUES ('1', '50000.00','8325 west street','null','Arlington','Texas','USA','1'),
('2', '52000.00','3333 west street','null','Arlington','Texas','USA','2'),
('3', '49000.00','1111 west street','null','Arlington','Texas','USA','3')

--add Marketing Department
INSERT INTO Department (ID_PK, Department_name, Department_location)
VALUES ('4', 'marketing', 'east mall')

--add Tina Smith
INSERT INTO Employee (ID_PK, FirstName, LastName, SSN, Dept_IDFK)
VALUES ('4','Tina', 'Smith', '333445556', '4')

INSERT INTO empDetails (ID_PK, Salary, Address1, Address2, City, Employee_State, Country, EmployeeIDFK)
VALUES ('4', '50000.00','8325 west street','null','Arlington','Texas','USA','4')

--List all employees in marketing
-- step 1 perform query to get marketing departments ID
declare @departmentID INT;
(Select @departmentID = ID_PK From Department Where (Department_name = 'marketing'));

--step 2 search for all employees who have the ID found in the previous query
Select*From Employee Where(Dept_IDFK = @departmentID);

--Report Total Salary in Marketing
--this part is a little tricky since i need to get data from two different tables
--Step 1 obtain all employee ID's that are in the marketing department

--first i get the department id of marketing
declare @marketingID int; --this is the int that holds the department id that corresponds to marketing
Select @marketingID = ID_PK From Department Where (Department_name = 'marketing');

--now i use this ID to get a list of all the employee IDs in marketing and make a common table expression containing the salaries
WITH Salary_CTE (Salary)
AS
(Select empdetails.Salary from empDetails where empdetails.EmployeeIDFK =
 (Select ID_PK from Employee where (Dept_IDFK = @marketingID)))

-- now I sum the salaries in the CTE
Select Sum (Salary_CTE.Salary) as 'Marketing Total Salary'
From Salary_CTE








--increase salary of tina smith  to 90k
--first determine Tina's Employee ID
Select * from empDetails
Update empDetails
Set Salary = 90000.00
where (EmployeeIDFK = (Select Employee.ID_PK From Employee Where(FirstName = 'Tina' AND LastName = 'smith')));



