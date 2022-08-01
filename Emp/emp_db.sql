--create database employee_db;

use employee_db;
go

/*
create table JOBS (
	Job_ID int identity(1,1) PRIMARY KEY,
	Job_Title nvarchar(255),
	Min_Salary float,
	Max_Salary float,
);

create table DEPARTMENTS (
	Department_ID int identity(1,1) PRIMARY KEY,
	Department_Name nvarchar(255),
	Manager_ID int FOREIGN KEY REFERENCES EMPLOYEES(Employee_ID),
	Location_ID int,
);

create table EMPLOYEES (
	Employee_ID int identity(1,1) PRIMARY KEY,
	First_Name nvarchar(255),
	Last_Name nvarchar(255),
	Email nvarchar(255),
	Phone_Number nvarchar(255),
	Hire_Date Date,
	Job_ID int FOREIGN KEY REFERENCES JOBS (Job_ID),
	Salary float,
	Commission_PCT float,
	Manager_ID int,
	Department_ID int FOREIGN KEY REFERENCES DEPARTMENTS (Department_ID)
);

alter table departments 
add FOREIGN KEY (Manager_ID) REFERENCES EMPLOYEES(Employee_ID);

*/


