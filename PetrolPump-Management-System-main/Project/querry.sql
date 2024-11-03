-- Join Queries

-- 1 -- Inner Join
SELECT PetrolPump.Registration_No 
FROM PetrolPump 
INNER JOIN Employee ON PetrolPump.Registration_No = Employee.Petrolpump_No;

-- 2 -- Left Join with Null check
SELECT Petrolpump.Registration_No 
FROM Petrolpump 
LEFT JOIN Employee ON Petrolpump.Registration_No = Employee.Petrolpump_No 
WHERE Employee.Petrolpump_No IS NULL;

-- 3 -- Left Join without Null check
SELECT PetrolPump.Registration_No 
FROM PetrolPump 
LEFT JOIN Employee ON PetrolPump.Registration_No = Employee.Petrolpump_No;

-- 4 -- Right Join to fetch invoices and customer details
SELECT Invoice.Invoice_No, Invoice.Date, Invoice.Payment_Type, Customer.C_Name, Customer.Phone_No 
FROM Invoice 
RIGHT OUTER JOIN Customer ON Customer.Customer_Code = Invoice.Customer_Code;
-- Aggregate Functions

-- 1 -- Average age of male customers
SELECT AVG(Age) AS Avg_Age 
FROM Customer 
WHERE Gender = 'M';

-- 2 -- Employee name and age calculation using DOB
SELECT Emp_Name, TIMESTAMPDIFF(YEAR, DOB, CURDATE()) AS Age 
FROM Employee;

-- 3 -- Max total price in invoices
SELECT *, MAX(Total_Price) AS Max_Price 
FROM Invoice;

-- 4 -- Max sales amount for a specific date
SELECT Sales_No, Sales_Amount, Petrolpump_No, MAX(Sales_Amount) AS Max_Sales 
FROM Sales 
WHERE DATE = '2022-11-20';
-- Set Operations

-- 1 -- Union of owner names and employee names
SELECT Owner_Name AS Names FROM Owners 
UNION 
SELECT EMP_Name FROM Employee;

-- 2 -- Intersection using JOIN (since MySQL does not support INTERSECT natively)
SELECT p.Registration_No 
FROM Petrolpump p 
JOIN Employee e ON p.Registration_No = e.Petrolpump_No;

-- 3 -- Petrol pumps with no associated employees
SELECT Petrolpump_Name 
FROM Petrolpump 
WHERE Registration_No IN (
    SELECT Petrolpump.Registration_No 
    FROM Petrolpump 
    LEFT JOIN Employee ON Petrolpump.Registration_No = Employee.Petrolpump_No 
    WHERE Employee.Petrolpump_No IS NULL
);

-- 4 -- Union of customer and owner names
SELECT C_Name FROM Customer 
UNION 
SELECT Owner_Name FROM Owners;
-- Trigger for Salary Check
DELIMITER $$
CREATE TRIGGER salary_check 
BEFORE UPDATE ON Employee 
FOR EACH ROW
BEGIN
    DECLARE error_msg VARCHAR(225);
    SET error_msg = 'Error: Insufficient Salary For Living';
    
    IF NEW.Salary < 300000 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = error_msg;
    END IF;
END $$
DELIMITER ;
-- Function to calculate total bill
DELIMITER $$
CREATE FUNCTION TOTAL_AMOUNT(TID VARCHAR(10)) RETURNS FLOAT
    DETERMINISTIC
BEGIN
    DECLARE BILL FLOAT;
    DECLARE RATE FLOAT;
    DECLARE VOL FLOAT;
    
    -- Get fuel price and volume for the tanker
    SET RATE = (SELECT FUEL_PRICE FROM TANKER WHERE TANKER_ID = TID);
    SET VOL = (SELECT FUEL_AMOUNT FROM TANKER WHERE TANKER_ID = TID);
    
    -- Calculate bill
    SET BILL = RATE * VOL;
    
    RETURN BILL;
END $$
DELIMITER ;

-- To execute
SET @p0 = 'BR6872'; 
SELECT TOTAL_AMOUNT(@p0) AS TOTAL_AMOUNT;
-- Procedure to get PetrolPump Registration No
DELIMITER $$
CREATE PROCEDURE p()
BEGIN
    SELECT PetrolPump.Registration_No 
    FROM PetrolPump 
    INNER JOIN Employee ON PetrolPump.Registration_No = Employee.Petrolpump_No;
END $$
DELIMITER ;
-- Procedure to get total sales and sales amounts for November
DELIMITER $$
CREATE PROCEDURE Modify()
BEGIN
    SELECT SUM(sales_amount) AS total_sales, sales_amount 
    FROM Sales 
    WHERE MONTH(DATE) = 11;
END $$
DELIMITER ;
-- Drop the trigger if needed
DROP TRIGGER IF EXISTS salary_check;
-- Update query for Employee Salary
UPDATE Employee 
SET Salary = 15000 
WHERE Email_ID = 'sfeer334';
