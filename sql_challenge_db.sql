DROP TABLE Employees; --Drop the Employees table if needed

CREATE TABLE Employees ( --Create an Employees table
	emp_no INT,
	emp_title_id VARCHAR(10),
	birth_date DATE,
	first_name VARCHAR(40),
	last_name VARCHAR(40),
	sex VARCHAR(10),
	hire_date DATE
);

SELECT * FROM Employees; --Check all columns and rows in Employees table

SELECT COUNT(*) FROM Employees; --Count all rows in Employees table

