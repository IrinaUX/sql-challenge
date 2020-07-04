--Employees table
DROP TABLE Employees; --Drop the Employees table if needed
CREATE TABLE Employees ( --Create an Employees table
	emp_no INT PRIMARY KEY,
	emp_title_id VARCHAR(10),
	birth_date DATE,
	first_name VARCHAR(40),
	last_name VARCHAR(40),
	sex VARCHAR(10),
	hire_date DATE);
SELECT * FROM Employees; --Check all columns and rows in Employees table
SELECT COUNT(*) FROM Employees; --Count all rows in Employees table
--Note: 300024 employees

--Salaries
DROP TABLE Salaries; --Drop Salaries table if needed
CREATE TABLE Salaries ( --Create Salaries table
	emp_no INTEGER PRIMARY KEY,
	salary INTEGER);
SELECT * FROM Salaries;
SELECT COUNT(salaries) FROM Salaries; --300024 employees,
SELECT salary FROM Salaries --Check salary column
--GROUP BY salary; --Groups by salary

--Department manager
DROP TABLE Dept_manager;
CREATE TABLE Dept_manager (
	dept_no VARCHAR(20),
	emp_no INT,
	FOREIGN KEY (emp_no) REFERENCES Employees(emp_no));

SELECT * FROM Dept_manager;
SELECT COUNT(*) FROM Dept_manager; --24 departments

--Department_Employees
DROP TABLE Dept_emp; -- if needed
CREATE TABLE Dept_emp (
	emp_no INT,
	dept_no VARCHAR(255),
	PRIMARY KEY(emp_no, dept_no));
SELECT * FROM Dept_emp;