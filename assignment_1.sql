-- 1. You are given data regarding the number of sub-districts in DKI Jakarta 
-- to be stored in a MySQL relational database. (Please refer to the learning platform)
-- Write a query to create a table in the database based on below conditions:

-- table name: kelurahan
-- Year: date
-- Region: varchar with a length of 50 characters
-- Subdistrict: varchar with a character length of 50
-- Count: int

-- > Note: You don't need to insert data and you may use any database for this question

-- using database
USE testing;

CREATE TABLE kelurahan (
	year date,
    district VARCHAR(50),
    sub_district VARCHAR(50),
    count INT
);

-- FOR NUMBER 2-8, USE THE "EMPLOYEES" AND "SALARIES" TABLE 
-- (SCRIPT TO CREATE THE TABLES IS ON THE LEARNING PLATFORM)
-- (YOU MAY USE ANY DATABASE YOU LIKE)

-- using database
USE assignment_1;

-- 2. After validating, it turned out that Kyoichi's hire_date data was incorrect, 
-- where the hire date should have been 1989-09-16. 
-- Write a query to change the hire date of Kyoichi.

SELECT * FROM employees; -- checking table before and after updating table

UPDATE employees SET hire_date = '1989-09-16' WHERE emp_no = 10005; -- updating table

-- 3. Write a query to duplicate the employees table and its data contents. Name the duplicate table 'backup_employees'

CREATE TABLE backup_employees LIKE employees; -- copying table

INSERT INTO backup_employees SELECT * FROM employees; -- inserting values

SELECT * FROM backup_employees; -- sanity check

-- 4. You are given the salaries table. Write a query to display data from an employee named Rizky Abdul

SELECT * FROM salaries; -- checking table

SELECT * 
FROM salaries 
WHERE person_id = '1011224';

-- 5. The HR Department wants to know who employees who had a salary above 6 million in March. Write a query to get that information.
SELECT *
FROM salaries
WHERE amount > 6000000 and month = 'March';

-- 6. Write a query to get the total amount of salary to be paid to employees in March.
SELECT month, SUM(amount) as total_salaries
FROM salaries
WHERE month = 'March'
GROUP BY month;

-- 7. Write a query to get the highest salary information for each employee
WITH max_salaries AS(
	SELECT person_id, MAX(amount) as highest_salary
    FROM salaries
    GROUP BY person_id
)
SELECT s.person_id, CONCAT(s.first_name, ' ', s.last_name) as emp_name, 
       ms.highest_salary, s.month, s.year
FROM salaries s
JOIN max_salaries ms
ON ms.person_id = s.person_id AND ms.highest_salary = s.amount
ORDER BY ms.highest_salary DESC;

-- 8. From January to March, how many times did each employee receive a salary greater than 4,500,000? Write the query!
SELECT person_id, COUNT(*) as freq
FROM salaries
WHERE amount > 4500000 AND month IN ('January', 'February', 'March')
GROUP BY person_id;
