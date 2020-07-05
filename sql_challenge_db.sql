--Employees table
DROP TABLE IF EXISTS Employees; --Drop the Employees table if exists
CREATE TABLE Employees ( --Create an Employees table
	emp_no BIGINT PRIMARY KEY NOT NULL,
	emp_title_id VARCHAR(10),
	birth_date DATE,
	first_name VARCHAR(40),
	last_name VARCHAR(40),
	sex VARCHAR(10),
	hire_date DATE
);
SELECT * FROM Employees; --Check all columns and rows in Employees table
SELECT COUNT(*) FROM Employees; --Count all rows in Employees table
--Note: 300024 employees

--Salaries
DROP TABLE IF EXISTS Salaries; --Drop Salaries table if exists
CREATE TABLE Salaries ( --Create Salaries table
	emp_no INTEGER PRIMARY KEY NOT NULL,
	salary BIGINT
);
SELECT * FROM Salaries;
SELECT COUNT(salaries) FROM Salaries; --300024 employees,
SELECT salary FROM Salaries --Check salary column
--GROUP BY salary; --Groups by salary

--Titles
DROP TABLE IF EXISTS Titles; --if exists
CREATE TABLE Titles ( --Create Titles table
	title_id VARCHAR(20) PRIMARY KEY NOT NULL,
	title VARCHAR(255)
);
SELECT * FROM Titles;

--Department manager
DROP TABLE IF EXISTS Dept_manager;
CREATE TABLE Dept_manager (
	dept_no TEXT,
	emp_no BIGINT NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES Employees(emp_no)
);
SELECT * FROM Dept_manager;
SELECT COUNT(*) FROM Dept_manager; --24 departments

--Dept_Emp
DROP TABLE IF EXISTS Dept_emp; -- if exists
CREATE TABLE Dept_emp (
	emp_no BIGINT NOT NULL REFERENCES Employees(emp_no),
	dept_no VARCHAR(255) NOT NULL REFERENCES Departments(dept_no)
	--PRIMARY KEY(emp_no, dept_no)
);
SELECT * FROM Dept_emp;

--Departments
DROP TABLE IF EXISTS Departments; --if needed
CREATE TABLE Departments (
	dept_no VARCHAR(255) PRIMARY KEY NOT NULL,
	dept_name VARCHAR(255)
);
SELECT * FROM Departments;
