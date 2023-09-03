CREATE DATABASE ORG;
SHOW DATABASES;
USE ORG;

CREATE TABLE Worker (
	WORKER_ID INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	FIRST_NAME CHAR(25),
	LAST_NAME CHAR(25),
	SALARY INT(15),
	JOINING_DATE DATETIME,
	DEPARTMENT CHAR(25)
);

INSERT INTO Worker 
	(WORKER_ID, FIRST_NAME, LAST_NAME, SALARY, JOINING_DATE, DEPARTMENT) VALUES
		(001, 'Monika', 'Arora', 100000, '14-02-20 09.00.00', 'HR'),
		(002, 'Niharika', 'Verma', 80000, '14-06-11 09.00.00', 'Admin'),
		(003, 'Vishal', 'Singhal', 300000, '14-02-20 09.00.00', 'HR'),
		(004, 'Amitabh', 'Singh', 500000, '14-02-20 09.00.00', 'Admin'),
		(005, 'Vivek', 'Bhati', 500000, '14-06-11 09.00.00', 'Admin'),
		(006, 'Vipul', 'Diwan', 200000, '14-06-11 09.00.00', 'Account'),
		(007, 'Satish', 'Kumar', 75000, '14-01-20 09.00.00', 'Account'),
		(008, 'Geetika', 'Chauhan', 90000, '14-04-11 09.00.00', 'Admin');

CREATE TABLE Bonus (
	WORKER_REF_ID INT,
	BONUS_AMOUNT INT(10),
	BONUS_DATE DATETIME,
	FOREIGN KEY (WORKER_REF_ID)
		REFERENCES Worker(WORKER_ID)
        ON DELETE CASCADE
);

INSERT INTO Bonus 
	(WORKER_REF_ID, BONUS_AMOUNT, BONUS_DATE) VALUES
		(001, 5000, '16-02-20'),
		(002, 3000, '16-06-11'),
		(003, 4000, '16-02-20'),
		(001, 4500, '16-02-20'),
		(002, 3500, '16-06-11');
        
CREATE TABLE Title (
	WORKER_REF_ID INT,
	WORKER_TITLE CHAR(25),
	AFFECTED_FROM DATETIME,
	FOREIGN KEY (WORKER_REF_ID)
		REFERENCES Worker(WORKER_ID)
        ON DELETE CASCADE
);

INSERT INTO Title 
	(WORKER_REF_ID, WORKER_TITLE, AFFECTED_FROM) VALUES
 (001, 'Manager', '2016-02-20 00:00:00'),
 (002, 'Executive', '2016-06-11 00:00:00'),
 (008, 'Executive', '2016-06-11 00:00:00'),
 (005, 'Manager', '2016-06-11 00:00:00'),
 (004, 'Asst. Manager', '2016-06-11 00:00:00'),
 (007, 'Executive', '2016-06-11 00:00:00'),
 (006, 'Lead', '2016-06-11 00:00:00'),
 (003, 'Lead', '2016-06-11 00:00:00');
 
 -- Q-1. Write an SQL query to fetch “FIRST_NAME” from the Worker table using the alias name <WORKER_NAME>
 SELECT FIRST_NAME AS WORKER_NAME FROM WORKER;
 
 -- Q-2. Write an SQL query to fetch “FIRST_NAME” from the Worker table in upper case.
  SELECT UPPER(FIRST_NAME) AS WORKER_NAME FROM WORKER;
  
  -- Q-3. Write an SQL query to fetch unique values of DEPARTMENT from the Worker table.
  SELECT DISTINCT DEPARTMENT FROM WORKER;
  
  -- Q-4. Write an SQL query to print the first three characters of  FIRST_NAME from the Worker table.
  SELECT LEFT(FIRST_NAME, 3) AS WORKER_NAME FROM WORKER;
  
  -- Q-6. Write an SQL query to print the FIRST_NAME from the Worker table after removing white spaces from the right side.
  Select RTRIM(FIRST_NAME) from Worker;
  
  -- Q-7. Write an SQL query to print the DEPARTMENT from the Worker table after removing white spaces from the left side.
  SELECT ltrim(FIRST_NAME) FROM WORKER;
  
  -- Q-8. Write an SQL query that fetches the unique values of DEPARTMENT from the Worker table and prints its length.
  SELECT distinct DEPARTMENT, length(DEPARTMENT) AS LENGTH_OF_NAME FROM WORKER;
  
  -- Q-9. Write an SQL query to print the FIRST_NAME from the Worker table after replacing ‘a’ with ‘A’
  SELECT replace(FIRST_NAME, 'a', 'A') as replaced, first_name from worker;
  
  -- Q-10. Write an SQL query to print the FIRST_NAME and LAST_NAME from the Worker table into a single column
  -- COMPLETE_NAME. A space char should separate them.
  select concat(first_name, ' ', last_name) as fullname from worker;
  
  -- Q-11. Write an SQL query to print all Worker details from the Worker table order by FIRST_NAME Ascending.
  select * from worker order by first_name asc;
  
  -- Q-12. Write an SQL query to print all Worker details from the Worker table order by FIRST_NAME Ascending and DEPARTMENT Descending.
  select * from worker order by first_name asc, last_name desc;
  
  -- Q-13. Write an SQL query to print details for Workers with the first names “Vipul” and “Satish” from the Worker table.
  select * from worker where first_name in ('vipul', 'satish');
  
  -- Q-14. Write an SQL query to print details of workers excluding first names, “Vipul” and “Satish” from the Worker table.
  select * from worker where first_name not in ('vipul', 'satish');
  
  -- Q-15. Write an SQL query to print details of Workers with DEPARTMENT name as “Admin”.
  select * from worker where department = 'Admin';
  
  -- Q-16. Write an SQL query to print details of the Workers whose FIRST_NAME contains ‘a’.
  select * from worker where first_name like '%a%';
  
  -- Q-17. Write an SQL query to print details of the Workers whose FIRST_NAME ends with ‘a’.
  select * from worker where right(first_name, 1) = 'a';
  
  -- Q-18. Write an SQL query to print details of the Workers whose FIRST_NAME ends with ‘h’ and contains six alphabets.
  select * from worker where right(first_name, 1) = 'h' and length(first_name) = 6;
  
  -- Q-19. Write an SQL query to print details of the Workers whose SALARY lies between 100000 and 500000.
  select * from worker where salary between 100000 and 500000;
  
  -- Q-20. Write an SQL query to print details of the Workers who joined in Feb’2014.
  select * from worker where month(joining_date) = 2 and year(joining_date) = 2014;
  
  -- Q-21. Write an SQL query to fetch the count of employees working in the department ‘Admin’.
  select department, count(*) as total_employee from worker where department = 'Admin'; 
  select department, count(*) as total_employee from worker group by department having department='admin';
  
  -- Q-22. Write an SQL query to fetch worker names with salaries with worker id >= 50000 and <= 100000.
  select concat(first_name, ' ', last_name) as worker_name, salary from worker where salary between 50000 and 100000;
  
  -- Q-23. Write an SQL query to fetch the no. of workers for each department in descending order.
  select department, count(*) as total_employee from worker group by department order by total_employee desc;
  
  -- Q-24. Write an SQL query to print details of the Workers who are also Managers.
  select * from worker join title 
  on worker.worker_id = title.worker_ref_id 
  where worker_title = 'Manager';
  
  -- Q-26. Write an SQL query to show only odd rows from a  worker.
  select * from worker where worker_id % 2 = 1;
  
  -- Q-27. Write an SQL query to show only even rows from a table.
  select * from worker where worker_id % 2 = 0;
  
  -- Q-28. Write an SQL query to clone a new table from another table.
  
  # create new table with data present in table worker, constraint on column are not applied on new table
  create table worker_copy as select * from worker; 
  
  create table worker_copy2 like worker; # create new table with structure of table not data
  
  desc worker_copy;
  desc worker_copy2;
  
  -- Q-31. Write an SQL query to show the current date and time.
  select now();
  select curdate();
  select current_time();
  select month(curdate()) as current_month;
  
  -- Q-32. Write an SQL query to show the top n (say 5) records of a table.
  select * from worker order by salary limit 5;
  
  -- Q-33. Write an SQL query to determine the nth (say n=5) highest salary from a table.
  set @n = 5;
  
  select * from worker order by salary limit  4, 1;
  
  -- Q-35. Write an SQL query to fetch the list of employees with the same salary.
  select w1.worker_id, w1.first_name, w1.last_name, w1.salary 
  from worker w1, worker w2 
  where w1.salary = w2.salary and w1.worker_id != w2.worker_id;
  
  -- Q-36. Write an SQL query to show the second-highest salary from a table.
  select * from worker order by salary desc;
  select * from worker order by salary desc limit 2, 1;
  
  # get second salary
  select max(salary) as 'SALARY' from worker where salary < (select max(salary) from worker);
  
  select * from worker 
  where salary = (
	select max(salary) as 'SALARY' from worker 
    where 
    salary < (select max(salary) from worker)
    ); 
  
 -- Q-40. Write an SQL query to fetch the departments that have less than four people in them.
 select department, count(*) as total_employee from worker group by department having total_employee < 4;
 
 -- Q-41. Write an SQL query to show all departments along with the number of people in there.
 select department, count(*) as total_emp from worker group by department;
 
 -- Q-42. Write an SQL query to show the last record from a table
 select * from worker order by joining_date desc limit 1;
 
 -- Q-45. Write an SQL query to print the name of employees having the highest salary in each department.
 select * from worker 
 where salary = (
	select max(w1.salary) from worker w1 
    where department = worker.department
    );

-- Q-46. Write an SQL query to fetch three max salaries from a table.
select distinct salary from worker order by salary desc limit 3;

-- Q-47. Write an SQL query to fetch three min salaries from a table.
select distinct salary from worker order by salary asc limit 3;

-- Q-48. Write an SQL query to fetch nth max salaries from a table.

select distinct salary from worker order by salary asc;
select distinct salary from worker order by salary asc limit 4,1; # n = 5

-- Q-49. Write an SQL query to fetch departments along with the total salaries paid for each of them.
select department, sum(salary) as total_paid_amount from worker group by department;

-- Q-50. Write an SQL query to fetch the names of workers who earn the highest salary.
select * from worker where salary = (select max(w1.salary) from worker w1);


-- ----------------------------------------------END-------------------------------------------------- 


 
 
  select * from worker;
   select * from title;
    select * from bonus;
  
  
  
  
  
  
  
  
  
  
  
  
  
  