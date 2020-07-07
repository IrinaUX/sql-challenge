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

--======================================
--=========== ANALYSIS START ===========

--1. List the following details of each employee: employee number, last name, first name, sex, and salary:
SELECT     Employees.emp_no, Employees.last_name, Employees.first_name, Employees.sex, Salaries.salary
FROM       Employees
LEFT JOIN  Salaries 
ON         Employees.emp_no = Salaries.emp_no
ORDER BY   Employees.emp_no ASC;

--2. List first name, last name, and hire date for employees who were hired in 1986:
SELECT     Employees.last_name, Employees.first_name, Employees.hire_date
FROM       Employees
WHERE      Employees.hire_date >= DATE '1986-01-01'
AND        Employees.hire_date <= DATE '1986-12-31';

--3. List the manager of each department with the following information: 
	--a) department number, department name, the manager's employee number, last name, first name.
SELECT     Dept_manager.dept_no, Departments.dept_name, Dept_manager.emp_no, Employees.last_name, Employees.first_name
FROM       Dept_manager
LEFT JOIN  Departments
ON         Dept_manager.dept_no = Departments.dept_no
LEFT JOIN  Employees
ON         Dept_manager.emp_no = Employees.emp_no;

--4. List the department of each employee with the following information: 
	--a) employee number, last name, first name, and department name
SELECT     Employees.emp_no, Employees.last_name, Employees.first_name, Dept_emp.dept_no, Departments.dept_name
FROM       Employees
JOIN       Dept_emp
ON         Employees.emp_no = Dept_emp.emp_no
JOIN       Departments
ON         Dept_emp.dept_no = Departments.dept_no;

--5. List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B":
SELECT     Employees.first_name, Employees.last_name, Employees.sex
FROM 	   Employees
WHERE      Employees.first_name = 'Hercules'
AND        last_name LIKE 'B%';
	
--6. List all employees in the Sales department, including their employee number, last name, first name, and department name:
SELECT     Employees.emp_no, Employees.last_name, Employees.first_name, Departments.dept_name --Dept_emp.dept_no 
FROM       Employees
LEFT JOIN  Dept_emp
ON         Employees.emp_no = Dept_emp.emp_no
LEFT JOIN  Departments
ON         Dept_emp.dept_no = Departments.dept_no
WHERE      Departments.dept_name = 'Sales';

--7. List all employees in the Sales and Development departments, 
	--a) including their employee number, last name, first name, and department name:
SELECT     Employees.emp_no, Employees.last_name, Employees.first_name, Departments.dept_name --Dept_emp.dept_no 
FROM       Employees
LEFT JOIN  Dept_emp
ON         Employees.emp_no = Dept_emp.emp_no
LEFT JOIN  Departments
ON         Dept_emp.dept_no = Departments.dept_no
WHERE      Departments.dept_name = 'Sales' 
OR         Departments.dept_name = 'Development';

--8. In descending order, list the frequency count of employee last names, i.e., how many employees share each last name:
SELECT     COUNT (Employees.last_name), Employees.last_name --Employees.last_name
FROM       Employees
GROUP BY   Employees.last_name --as grouped_last_names
ORDER BY   COUNT (Employees.last_name) ASC

--================= ANALYSIS END ==================--
--===================================================

--===================================================
--======== FOR IMPORT TO JUPYTER NOTEBOOK =========--

--1. Create Employee_salary table that consists of employee number, last name, first name, sex, and salary:
CREATE TABLE  Employee_salary AS
SELECT        Employees.emp_no, Employees.last_name, Employees.first_name, Employees.sex, Salaries.salary
FROM          Employees
LEFT JOIN     Salaries 
ON            Employees.emp_no = Salaries.emp_no
ORDER BY      Employees.salary ASC;

SELECT * FROM Employee_salary --Check if table is created
ORDER BY      Salary DESC;

--2. Create Employees_1986 table with the first name, last name, and hire date for employees who were hired in 1986:
CREATE TABLE  Employees_1986 AS
SELECT        Employees.last_name, Employees.first_name, Employees.hire_date
FROM          Employees
WHERE         Employees.hire_date >= DATE '1986-01-01'
AND           Employees.hire_date <= DATE '1986-12-31';

SELECT * FROM Employees_1986
ORDER BY      hire_date DESC; -- Query and order by hire_date in descending order

--3. Create a table that lists the manager of each department with the following information: 
	--a) department number, department name, the manager's employee number, last name, first name.
CREATE TABLE  Departments_manager_info AS
SELECT        Dept_manager.dept_no, Departments.dept_name, Dept_manager.emp_no, Employees.last_name, Employees.first_name
FROM          Dept_manager
LEFT JOIN     Departments
ON            Dept_manager.dept_no = Departments.dept_no
LEFT JOIN     Employees
ON            Dept_manager.emp_no = Employees.emp_no;
SELECT * FROM Departments_manager_info ORDER BY Departments_manager_info.dept_no ASC;