USE assignment_1;

CREATE TABLE employees(
	emp_no INT,
    birth_date DATE,
    first_name VARCHAR(50),
	last_name VARCHAR(50),
    gender CHAR(1),
    hire_date DATE
);

-- DROP TABLE IF EXISTS employees;

INSERT INTO employees VALUES (10001, '1953-09-02', 'Georgi', 'Facello', "M", "1986-06-26"),
						   (10002, '1964-06-02', 'Bezalel', 'Simmel', "F", "1985-11-21"),
                           (10003, '1959-12-03', 'Parto', 'Bamford', "M", "1986-08-28"),
                           (10004, '1954-05-01', 'Christian', 'Koblick', "M", "1986-12-01"),
                           (10005, '1955-01-21', 'Kyoichi', 'Maliniak', "M", "1989-09-12");

-- Generate table

CREATE TABLE salaries  ( 
	person_id 	INT NULL,
	first_name	VARCHAR(50) NOT NULL,
	last_name 	VARCHAR(50) NOT NULL,
	amount      INT NULL,
	month     	VARCHAR(15) NULL,
	year     	INT NULL 
	);

-- Input data to table 

INSERT INTO salaries (person_id,first_name,last_name,amount,month,year) VALUES(1011223,'Tomi','Agasi',4500000,'January',2021);
INSERT INTO salaries (person_id,first_name,last_name,amount,month,year) VALUES(1011223,'Tomi','Agasi',4700000,'February',2021);
INSERT INTO salaries (person_id,first_name,last_name,amount,month,year) VALUES(1011223,'Tomi','Agasi',4000000,'March',2021);
INSERT INTO salaries (person_id,first_name,last_name,amount,month,year) VALUES(1011224,'Rizky','Abdul',5000000,'January',2021);
INSERT INTO salaries (person_id,first_name,last_name,amount,month,year) VALUES(1011224,'Rizky','Abdul',4800000,'February',2021);
INSERT INTO salaries (person_id,first_name,last_name,amount,month,year) VALUES(1011224,'Rizky','Abdul',6200000,'March',2021);
INSERT INTO salaries (person_id,first_name,last_name,amount,month,year) VALUES(1011225,'Didik','Yudha',8300000,'January',2021);
INSERT INTO salaries (person_id,first_name,last_name,amount,month,year) VALUES(1011225,'Didik','Yudha',8100000,'February',2021);
INSERT INTO salaries (person_id,first_name,last_name,amount,month,year) VALUES(1011225,'Didik','Yudha',8000000,'March',2021);

SELECT * FROM salaries
