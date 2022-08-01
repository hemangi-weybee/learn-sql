use employee_db;
go

select * from EMPLOYEES;
select * from DEPARTMENTS;
select * from JOBS;

/* 1. Given SQL query will execute successfully: TRUE/FALSE SELECT last_name, job_id, salary AS Sal FROM employees; */

SELECT last_name, job_id, salary AS Sal FROM employees;   --true

/* 2. Identity errors in the following statement: 
SELECT employee_id, last_name, sal*12 ANNUAL SALARY FROM employees; */

--here in given query, salary column name is given as sal which is Salary in actual and alias is given in wrong way. As it contains space between word so they shouble in single quote.
--alias for column can be given : select column_name 'alias name' from table_name;

select Employee_ID, Last_Name, Salary*12 'ANNUAL SALARY' from EMPLOYEES;

/* 3. Write a query to determine the structure of the table 'DEPARTMENTS' */

EXEC sp_help DEPARTMENTS;
select * from DEPARTMENTS;

/* 4. Write a query to determine the unique Job IDs from the EMPLOYEES table. */

select distinct Job_ID from EMPLOYEES;


/* 5. Write a query to display the employee number, lastname, salary (oldsalary), salary increased by 15.5% name it has NewSalary and subtract the (NewSalary from OldSalary) name the column as Increment. */

select Employee_ID, Last_Name, Salary as 'Old_Salary', 
Salary + (Salary*0.155) as 'New_Salary', 
(Salary + (Salary*0.155)) - Salary as 'Increment'
from EMPLOYEES;

/* 6. Write a query to display the minimum, maximum, sum and average salary for each job type. */

select Job_ID, MAX(Salary) 'Maximum Salary', MIN(Salary) 'Minimum Salary', 
AVG(Salary) 'Average Salary', SUM(Salary) 'Total Salary' 
from EMPLOYEES group by Job_ID;

/* 7. The HR department needs to find the names and hire dates of all employees who were hired before their managers, along with their managers’ names and hire dates. */

select e.Employee_ID, e.First_Name + ' '+ e.Last_Name 'Employee_Name', e.Hire_Date, 
m.First_Name + ' '+ m.Last_Name 'Manager_Name' , m.Hire_Date
from EMPLOYEES e, EMPLOYEES m 
where e.Manager_ID = m.Employee_ID and e.Hire_Date < m.Hire_Date; 


/* 8. Create a report for the HR department that displays employee last names, department numbers, and all the employees who work in the same department as a given employee. */

select e.First_Name + e.Last_Name Employee , c.First_Name + c.Last_Name Colleague, c.Department_ID Department  
from EMPLOYEES e, EMPLOYEES c
where e.Department_ID = c.Department_ID and e.Employee_ID != c.Employee_ID 
order by Employee;

/* 9. Find the highest, lowest, sum, and average salary of all employees. Label the columns Maximum, Minimum, Sum, and Average, respectively. Round your results to the nearest whole number. */

select ROUND(MAX(Salary), 0) 'Maximum  Salary', ROUND(MIN(Salary), 0) 'Minimum Salary', 
ROUND(AVG(Salary), 0) 'Average  Salary', ROUND(SUM(Salary), 0) 'Total  Salary' 
from EMPLOYEES;

/* 10. Create a report that displays list of employees whose salary is more than the salary of any employee from department 6 */

--Here department 1 max salary 55000;

select Employee_ID, First_Name, Salary from EMPLOYEES 
where Salary > (
	select Max(Salary) from EMPLOYEES 
	where Department_ID = 3
	group by Department_ID);

/* 11. Create a report that displays last name and salary of every employee who reports to King. */

select e.Last_Name , e.Salary
from EMPLOYEES e, EMPLOYEES m 
where e.Manager_ID = m.Employee_ID and m.First_Name = 'Damon'; 

/* 12. Write a query to display the list of department IDs for departments that do not contain the job Id ST_CLERK. 
Use SET Operator for this query */

select Department_ID from DEPARTMENTS
except
select e.Department_ID from EMPLOYEES e
join JOBS j on j.Job_ID  =  e.Job_ID and j.Job_Title = 'ST_CLERK';


/* 13. Write a query to display the list of employees who work in department 50 and 80. Show employee Id, job Id and department Id 
by using set operators. - Add 50 and 80 department Id to department table */

select Employee_ID, Job_ID, Department_ID from EMPLOYEES where Department_ID = '5'
union 
select Employee_ID, Job_ID, Department_ID from EMPLOYEES where Department_ID = '2';