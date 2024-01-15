SHOW DATABASES;

CREATE DATABASE workerDB;

use workerdb;

-- Create WORKER table
CREATE TABLE WORKER (
    worker_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    salary DECIMAL(10,2),
    joining_date DATE,
    department VARCHAR(50)
);

-- Create BONUS table
CREATE TABLE BONUS (
    bonus_id INT PRIMARY KEY,
    worker_ref_id INT,
    bonus_amount DECIMAL(10,2),
    bonus_date DATE,
    FOREIGN KEY (worker_ref_id) REFERENCES WORKER(worker_id) ON DELETE CASCADE
);

-- Create TITLE table
CREATE TABLE TITLE (
    title_id INT PRIMARY KEY,
    worker_ref_id INT,
    worker_title VARCHAR(50),
    affected_from DATE,
    FOREIGN KEY (worker_ref_id) REFERENCES WORKER(worker_id) ON DELETE CASCADE
);

-- sample data
INSERT INTO WORKER VALUES
(1, 'John', 'Doe', 50000.00, '2022-01-01', 'IT'),
(2, 'Jane', 'Smith', 60000.00, '2021-12-15', 'HR'),
(3, 'Bob', 'Johnson', 55000.00, '2022-02-20', 'IT'),
(4, 'Alice', 'Williams', 52000.00, '2022-03-10', 'Finance');

-- sample data
INSERT INTO BONUS VALUES
(1, 1, 2000.00, '2022-02-15'),
(2, 2, 1500.00, '2022-01-20'),
(3, 3, 1800.00, '2022-03-01');

-- sample data
INSERT INTO TITLE VALUES
(1, 1, 'Software Engineer', '2022-01-01'),
(2, 2, 'HR Specialist', '2021-12-15'),
(3, 3, 'System Analyst', '2022-02-20'),
(4, 1, 'Senior Software Engineer', '2022-05-01');

-- i) Collect the worker IDs and bonus amounts for those who have received a bonus.
SELECT w.worker_id, b.bonus_amount
FROM WORKER w
JOIN BONUS b ON w.worker_id = b.worker_ref_id;

-- ii) Fetch the total number of workers in each department.
SELECT department, COUNT(worker_id) AS total_workers
FROM WORKER
GROUP BY department;

-- iii) Retrieve the names of workers who joined the company before a specific date.
SELECT first_name, last_name
FROM WORKER
WHERE joining_date < '2022-03-01';

-- iv) Fetch the average salary of all workers.
SELECT AVG(salary) AS average_salary
FROM WORKER;

-- v) Identify the names of workers who have never received a bonus.
SELECT first_name, last_name
FROM WORKER
WHERE worker_id NOT IN (SELECT worker_ref_id FROM BONUS);

-- vi) Fetch the maximum bonus amount given to any worker.
SELECT MAX(bonus_amount) AS max_bonus_amount
FROM BONUS;

-- vii) Check the names and salaries of workers in the 'IT' department who joined after a specific date.
SELECT first_name, last_name, salary
FROM WORKER
WHERE department = 'IT' AND joining_date > '2022-02-01';

-- viii) Summarize the names and titles of workers who have changed titles, including the old and new titles.
SELECT t.worker_ref_id, w.first_name, w.last_name, t.worker_title AS new_title, t_old.worker_title AS old_title
FROM TITLE t
JOIN TITLE t_old ON t.worker_ref_id = t_old.worker_ref_id AND t.affected_from > t_old.affected_from
JOIN WORKER w ON t.worker_ref_id = w.worker_id;

SELECT worker_ref_id, bonus_amount
FROM BONUS
ORDER BY bonus_amount DESC
LIMIT 1;

-- x) Check the names of workers who have received a bonus and changed titles on the same day.
SELECT w.first_name, w.last_name
FROM WORKER w
JOIN BONUS b ON w.worker_id = b.worker_ref_id
JOIN TITLE t ON w.worker_id = t.worker_ref_id
WHERE DATE(b.bonus_date) = DATE(t.affected_from);