--Titles
DROP TABLE IF EXISTS Titles; --if exists
CREATE TABLE Titles ( --Create Titles table
	title_id VARCHAR(10) PRIMARY KEY,
	title VARCHAR(255)
);
SELECT * FROM Titles;

--Employees table
DROP TABLE IF EXISTS Employees CASCADE; --Drop the Employees table if exists
CREATE TABLE Employees ( --Create an Employees table
	emp_no BIGINT PRIMARY KEY NOT NULL,
	emp_title_id VARCHAR(10),
	FOREIGN KEY (emp_title_id) REFERENCES Titles(title_id),
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
	id SERIAL PRIMARY KEY,
	emp_no BIGINT NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES Employees(emp_no),
	salary BIGINT
);
SELECT * FROM Salaries;
SELECT COUNT(salaries) FROM Salaries; --300024 employees,
SELECT salary FROM Salaries --Check salary column
--GROUP BY salary; --Groups by salary

--Departments
DROP TABLE IF EXISTS Departments; --if needed
CREATE TABLE Departments (
	dept_no VARCHAR(255) PRIMARY KEY NOT NULL,
	dept_name VARCHAR(255),
);
SELECT * FROM Departments;

--Dept_Emp
DROP TABLE IF EXISTS Dept_emp; -- if exists
CREATE TABLE Dept_emp (
	id SERIAL PRIMARY KEY,
	emp_no BIGINT NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES Employees(emp_no),
	dept_no VARCHAR(255) NOT NULL,
	FOREIGN KEY (dept_no) REFERENCES Departments(dept_no)
);
SELECT * FROM Dept_emp;

--Department manager
DROP TABLE IF EXISTS Dept_manager;
CREATE TABLE Dept_manager (
	dept_no VARCHAR(255),
	emp_no BIGINT NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES Employees (emp_no),
	FOREIGN KEY (dept_no) REFERENCES Departments (dept_no)
	--FOREIGN KEY (dept_no) REFERENCES Dept_emp (dept_no)
);
SELECT * FROM Dept_manager;
SELECT COUNT(*) FROM Dept_manager; --24 departments


--ANALYSIS START--
--1. List the following details of each employee: employee number, last name, first name, sex, and salary:
SELECT Employees.emp_no, Employees.last_name, Employees.first_name, Employees.sex, Salaries.salary
FROM Employees
LEFT JOIN Salaries 
ON Employees.emp_no = Salaries.emp_no
ORDER BY Employees.emp_no ASC;



-- --1.a) Create new table by joining Employee and Salaries table on emp_no column:
-- --(optional: Drop the table if needed)
-- DROP TABLE IF EXISTS Emp_Salaries;
-- CREATE TABLE Emp_salaries (
-- 	emp_no BIGINT,
-- 	FOREIGN KEY (emp_no) REFERENCES Employees (emp_no),
-- 	first_name VARCHAR(40),
-- 	FOREIGN KEY (first_name) REFERENCES Employees (first_name),
-- 	last_name VARCHAR(40),
-- 	FOREIGN KEY (last_name) REFERENCES Employees (last_name),
-- 	sex VARCHAR(10),
-- 	FOREIGN KEY (sex) REFERENCES Employees (sex),
-- 	salary BIGINT,
-- 	FOREIGN KEY (salary) REFERENCES Salaries (salary),
-- 	PRIMARY KEY (emp_no, salary)
-- );

