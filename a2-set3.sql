SHOW DATABASES;

CREATE DATABASE salesmandb;

USE salesmandb;

-- Create SALESMAN table
CREATE TABLE SALESMAN (
    Salesman_id INT PRIMARY KEY,
    Name VARCHAR(50),
    City VARCHAR(50),
    Commission DECIMAL(5,2)
);

-- Create CUSTOMER table
CREATE TABLE CUSTOMER (
    Customer_id INT PRIMARY KEY,
    Cust_Name VARCHAR(50),
    City VARCHAR(50),
    Grade INT,
    Salesman_id INT,
    FOREIGN KEY (Salesman_id) REFERENCES SALESMAN(Salesman_id)
);

-- Create ORDERS table
CREATE TABLE ORDERS (
    Ord_No INT PRIMARY KEY,
    Purchase_Amt DECIMAL(10,2),
    Ord_Date DATE,
    Customer_id INT,
    Salesman_id INT,
    FOREIGN KEY (Customer_id) REFERENCES CUSTOMER(Customer_id),
    FOREIGN KEY (Salesman_id) REFERENCES SALESMAN(Salesman_id)
);

-- Insert sample data into SALESMAN table
INSERT INTO SALESMAN VALUES
(1, 'John Doe', 'New York', 0.12),
(2, 'Jane Smith', 'London', 0.15),
(3, 'Bob Johnson', 'Paris', 0.10),
(4, 'Alice Williams', 'Tokyo', 0.08);

-- Insert sample data into CUSTOMER table
INSERT INTO CUSTOMER VALUES
(1, 'Customer1', 'New York', 1, 1),
(2, 'Customer2', 'London', 2, 2),
(3, 'Customer3', 'Paris', 3, 3),
(4, 'Customer4', 'London', 2, 2);

-- Insert sample data into ORDERS table
INSERT INTO ORDERS VALUES
(101, 1200.00, '2022-08-17', 1, 1),
(102, 800.00, '2022-08-17', 2, 2),
(103, 1500.00, '2022-08-18', 3, 3),
(104, 900.00, '2022-08-18', 1, 1),
(105, 1100.00, '2022-08-19', 2, 2);

-- i) Retrieve the names of all salespeople along with their cities.
SELECT Name, City
FROM SALESMAN;

-- ii) Fetch the average commission for all salespeople.
SELECT AVG(Commission) AS avg_commission
FROM SALESMAN;

-- iii) Obtain the customers who have not placed any orders.
SELECT Cust_Name
FROM CUSTOMER
WHERE Customer_id NOT IN (SELECT DISTINCT Customer_id FROM ORDERS);

-- iv) Obtain the total purchase amount for each customer in the 'London' city.
SELECT c.Cust_Name, SUM(o.Purchase_Amt) AS total_purchase_amount
FROM CUSTOMER c
LEFT JOIN ORDERS o ON c.Customer_id = o.Customer_id
WHERE c.City = 'London'
GROUP BY c.Customer_id;

-- v) Retrieve the details of orders placed on '2022-08-17' with the purchase amount greater than $1000.
SELECT *
FROM ORDERS
WHERE Ord_Date = '2022-08-17' AND Purchase_Amt > 1000.00;

-- vi) Fetch the salesperson with the highest commission.
SELECT *
FROM SALESMAN
ORDER BY Commission DESC
LIMIT 1;

-- vii) Choose the customers who have made purchases with a commission greater than 10%.
SELECT c.Cust_Name
FROM CUSTOMER c
JOIN ORDERS o ON c.Customer_id = o.Customer_id
JOIN SALESMAN s ON c.Salesman_id = s.Salesman_id
WHERE s.Commission > 0.10;

-- viii) Check the cities where customers have placed orders.
SELECT DISTINCT City
FROM CUSTOMER;

-- ix) Evaluate the total number of orders placed on each date.
SELECT Ord_Date, COUNT(*) AS total_orders
FROM ORDERS
GROUP BY Ord_Date;

-- x) Check the names of customers who have placed orders along with the corresponding salesperson names.
SELECT c.Cust_Name, s.Name AS Salesperson_Name
FROM CUSTOMER c
JOIN SALESMAN s ON c.Salesman_id = s.Salesman_id
JOIN ORDERS o ON c.Customer_id = o.Customer_id;