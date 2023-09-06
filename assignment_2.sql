-- Instruction
-- Use the "data_kelas" database to answer numbers 1-3
-- Use the "3_odds" database to answer numbers 4-8

-- using database "data_kelas" for number 1-3
USE data_kelas;

-- 1. Display employee information (employee_id, employee_name, branch_name, total_sales) 
-- whose total_sales is more than Rp. 10,000,000. Sort by column total_sales from smallest to largest
SELECT p.id_pegawai as employee_id, CONCAT(p.nama_depan, ' ', p.nama_belakang) as employee_name, 
       c.nama_cabang as branch_name, SUM(pk.total_penjualan) as total_sales
FROM pj_klien pk
JOIN pegawai p
USING (id_pegawai)
JOIN cabang c
USING (id_cabang)
GROUP BY employee_id
HAVING total_sales > 10000000
ORDER BY total_sales ASC;

-- 2. Present information about the number of employees handled by each manager.
SELECT c.id_mgr as manager_id, c.id_cabang as branch_id, 
       c.nama_cabang as branch_name, COUNT(p.id_pegawai) as emp_under_mgr
FROM cabang c
JOIN pegawai p
USING (id_cabang)
WHERE p.id_pegawai NOT IN (c.id_mgr)
GROUP BY id_mgr, id_cabang, nama_cabang;

-- 3. Present the highest sales information that was successfully carried out by each branch.
SELECT c.id_cabang as branch_id, c.nama_cabang as branch_name,
       MAX(pk.total_penjualan) as highest_sales,
       CONCAT(p.nama_depan, ' ', p.nama_belakang) as emp_name
FROM cabang c
JOIN pegawai p
USING (id_cabang)
JOIN pj_klien pk
USING (id_pegawai)
GROUP BY c.id_cabang
ORDER BY highest_sales DESC;

-- using database "3_odds" for number 4-8
USE 3_odds;

-- 4. Create a query to get information about the names of employees who handle more than 7 customers.
SELECT e.employeeNumber, CONCAT(e.firstName, e.lastName) as employeeName, 
       COUNT(*) as totalCustomers
FROM customers c
JOIN employees e
ON c.salesRepEmployeeNumber = e.employeeNumber
GROUP BY e.employeeNumber
HAVING totalCustomers > 7
ORDER BY totalCustomers ASC;


-- 5. Using CTEs. Make a query to get the number of employees from every country other than America.
WITH empnationalities AS(
	SELECT e.employeeNumber, o.country
    FROM employees e
    JOIN offices o
    USING (officeCode)
)
SELECT country, COUNT(*) as numberOfEmployees
FROM empnationalities
WHERE country != 'USA'
GROUP BY country
ORDER BY numberOfEmployees DESC;

-- 6. Create a stored functions to get the customer's continent of origin based on the country information. 
-- For example, if the name of the country is USA then the continent is America.
SELECT DISTINCT country
FROM customers;

DELIMITER $$
CREATE FUNCTION continentMaker (
	countries VARCHAR(50)
)
RETURNS VARCHAR(50)
DETERMINISTIC
BEGIN
	DECLARE continent VARCHAR(50);
    
    IF countries IN ('France', 'Norway', 'Poland', 
					 'Germany', 'Spain', 'Sweden', 
                     'Denmark', 'Portugal', 'Finland',
                     'UK', 'Ireland', 'Italy', 'Switzerland',
                     'Netherlands', 'Belgium', 'Austria', 'Russia')  THEN
		SET continent = 'Europe';
	
    ELSEIF countries IN ('USA', 'Canada') THEN
    	SET continent = 'America';
        
	ELSEIF countries IN ('Australia', 'New Zealand') THEN
    	SET continent = 'Oceania';
	
    ELSEIF countries IN ('South Africa') THEN
    	SET continent = 'Africa';
        
	ELSEIF countries IN ('Singapore', 'Japan', 'Hong Kong', 
						 'Philippines', 'Israel') THEN
    	SET continent = 'Asia';
	
	ELSE
		SET continent = 'Unidentified';
     
     END IF;
	RETURN continent;
END $$
DELIMITER ;

SELECT country, continentMaker(country) as continent
FROM customers;


-- 7. Create a stored functions to categorize the average price of goods (priceEach). 
-- If the price of the item is above 100 then it is included in the high-price category, otherwise, it is included in the low-price category
DELIMITER $$
CREATE FUNCTION priceCategory (
	price DECIMAL (10,2)
)
RETURNS VARCHAR (50)
DETERMINISTIC
BEGIN

	DECLARE category VARCHAR(50);
    
    IF price > 100 THEN
		SET category = 'high-price';
	ELSE
		SET category = 'low-price';
        
	END IF;
	RETURN category;
END $$
DELIMITER ;

SELECT productCode, AVG(priceEach) as avgPrice, priceCategory(AVG(priceEach)) as priceCategory
FROM orderDetails
GROUP BY productCode
ORDER BY productCode
;

-- 8. Create a stored function that can categorize customers based on their credit limit. 
-- If the credit limit is more than 50,000 then it is included in the PLATINUM category, 
-- if it is in the range of 10000 to 50000 then it is in the GOLD category, 
-- if it is below 10000, it is entered in the SILVER category. 
-- Using the function that has been created, display customer segmentation information in the customer's table

DELIMITER $$

CREATE FUNCTION customerCategory(
	creditLimit DECIMAL(10,2)
) 
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
    DECLARE customerLevel VARCHAR(20);

    IF creditLimit > 50000 THEN
		SET customerLevel = 'PLATINUM';
    ELSEIF (creditLimit <= 50000 AND 
			creditLimit >= 10000) THEN
        SET customerLevel = 'GOLD';
    ELSEIF creditLimit < 10000 THEN
        SET customerLevel = 'SILVER';
    END IF;
	RETURN (customerLevel);
END$$
DELIMITER ;

SELECT customerNumber, customerName, creditLimit, 
       customerCategory(creditLimit) as category
FROM customers
ORDER BY creditLimit;
