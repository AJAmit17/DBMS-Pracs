lshow DATABASES;

CREATE DATABASE boat_reservations;

use boat_reservations;

-- Sailors table
CREATE TABLE SAILORS (
    sid INT NOT NULL PRIMARY KEY,
    sname VARCHAR(50),
    rating INT,
    age INT
);

-- Boats table
CREATE TABLE BOATS (
    bid INT NOT NULL PRIMARY KEY,
    bname VARCHAR(50),
    color VARCHAR(20)
);

-- Reserves TABLE
CREATE TABLE RESERVES (
    sid INT,
    bid INT,
    sdate DATE,
    FOREIGN KEY (sid) REFERENCES sailors(sid) ON DELETE CASCADE,
    FOREIGN KEY (bid) REFERENCES boats(bid) ON DELETE CASCADE 
);

-- SAMPLE DATA 
INSERT INTO Sailors (sid, sname, rating, age)
VALUES
    (22, 'Dustin', 7, 45.0),
    (29, 'Brutus', 1, 33.0),
    (31, 'Lubber', 8, 55.5),
    (32, 'Andy', 8, 25.5),
    (58, 'Rusty', 10, 35.0),
    (64, 'Horatio', 7, 35.0),
    (71, 'Zorba', 10, 16.0),
    (74, 'Horatio', 9, 35.0),
    (85, 'Art', 3, 25.5),
    (95, 'Bob', 3, 63.5);

INSERT INTO Boats (bid, bname, color)
VALUES
    (101, 'Interlake', 'blue'),
    (102, 'Interlake', 'red'),
    (103, 'Clipper', 'green'),
    (104, 'Marine', 'red');

INSERT INTO Reserves (sid, bid, sdate)
VALUES
    (22, 101, '1998-10-10'),
    (22, 102, '1998-10-10'),
    (22, 104, '1998-10-08'),
    (22, 103, '1998-10-07'),
    (31, 102, '1998-11-10'),
    (31, 103, '1998-11-06'),
    (31, 104, '1998-11-12'),
    (64, 101, '1998-09-05'),
    (64, 102, '1998-09-08'),
    (74, 103, '1998-09-08');

-- i)Fetch the names and ages of sailors with a rating of 8.
SELECT sname,age
FROM sailors
WHERE rating=8;

-- ii)Obtain Count of the total number of boats.
SELECT COUNT(*) AS total_boats
FROM BOATS;

-- iii) Fetch the average age of all sailors.
SELECT AVG(age) as avg_age
FROM sailors;

-- iv) Retrieve the names of sailors who reserved a boat on a specific date.
SELECT DISTINCT S.sname
FROM sailors S
JOIN RESERVES R ON S.sid=R.sid
WHERE R.sdate='1998-11-06';

-- v) Identify Count the number of sailors for each rating.
SELECT rating, COUNT(*) as sailor_count
from sailors
GROUP BY rating;

-- vi) Fetch the oldest sailor.
SELECT age
FROM sailors
ORDER BY age DESC
Limit 1;

-- vii) Check the names of boats reserved on a specific date.
SELECT DISTINCT B.bname
FROM boats B 
JOIN reserves R on R.bid=B.bid
where sdate='1998-10-08';

-- viii) Evaluate the average age of sailors who reserved a boat on a specific date.
SELECT AVG(S.age) as avg_age
FROM sailors S 
JOIN reserves R on R.sid=S.sid
WHERE sdate = '1998-11-12';

-- ix) Check the boats that have not been reserved.
SELECT bname FROM BOATS WHERE bid NOT IN (SELECT DISTINCT bid FROM RESERVES);

-- x)Summarize the names of sailors who have reserved a boat of a specific color
SELECT DISTINCT S.sname
FROM sailors S 
JOIN reserves R ON R.sid=S.sid
JOIN boats B on R.bid=B.bid
WHERE B.color='red';