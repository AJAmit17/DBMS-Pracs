# Set1
`WORKER (worker_id, first_name, last_name, salary, joining_date, department)`

`BONUS(worker_ref_id, bonus_amount, bonus_date)`

`TITLE(worker_ref_id, worker_title, affected_from)`

**i) Fetch the average salary of workers who have received a bonus:**

```sql
π_{AVG(S.salary)} (σ_{B.worker_ref_id = W.worker_id} (B ⨝ W))
```

**ii) Retrieve the names and titles of workers who have changed titles multiple times in a row:**

```sql
π_{W.first_name, W.last_name, T1.worker_title} (σ_{W.worker_id = T1.worker_ref_id AND T1.affected_from < T2.affected_from} (W ⨝_{W.worker_id = T2.worker_ref_id} (T1 ⨝_{T1.worker_ref_id = T2.worker_ref_id} T2)))
```


**iii) Retrieve the names (FIRST_NAME, LAST_NAME) of workers who have received a bonus before joining the company:**
```sql
π_{W.first_name, W.last_name} (σ_{B.worker_ref_id = W.worker_id & B.bonus_date < W.joining_date} (B ⨝ W))
```

# Set2
`SAILORS(sid,sname,rating,age)`

`BOATS(bid,bname,color)`

`RESERVES(sid,bid,sdate)`

**i) Retrieve the names and ages of sailors who have reserved a red or green-colored boat:**

```sql
π_{sname, age} (σ_{color='red' V color='green'} (SAILORS ⨝_{sid=sid} (RESERVES ⨝_{bid=bid} BOATS)))
```

**ii) Identify the names of sailors who have reserved boats of every available color:**

```sql
π_{sname} (σ_{color = 'red' ∨ color = 'blue' ∨ color = 'green'} (SAILORS ⨝_{sid=sid} (RESERVES ⨝_{bid=bid} BOATS)))
```

**iii) Retrieve the names and ages of sailors who have reserved a boat on the same day they were rated:**

```sql
π_{sname, age} (σ_{sdate=rating} (SAILORS ⨝_{sid=sid} (RESERVES ⨝_{bid=bid} BOATS)))
```

# Set3
`SALESMAN(Salesman_id, Name, City, Commission)` 

`CUSTOMER(Customer_id, Cust_Name, City, Grade, Salesman_id)`

`ORDERS(Ord_No, Purchase_Amt, Ord_Date, Customer_id, Salesman_id)`

**i) Retrieve customers who made purchases on '2023-08-17':**

```sql
π_{Cust_Name, City, Grade} (σ_{Ord_Date = '2023-08-17'} (CUSTOMER ⨝_{Customer_id} ORDERS))
```

**ii) Retrieve customers with a grade greater than 2 who have a specified salesman:**

```sql
π_{Cust_Name, City, Grade} (σ_{Grade > 2 & Salesman_id = specified_salesman_id} CUSTOMER)
```

**iii) Fetch the highest purchase amount for each customer in the 'New York' city:**

```sql
π_{C.Cust_Name, C.City, MAX(O.Purchase_Amt)} (CUSTOMER C ⨝_{C.Customer_id = O.Customer_id AND C.City = 'New York'} ORDERS O)
```