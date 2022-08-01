use taskDB;
go

--create database taskDB;

use taskDB;
go


/*
CREATE TABLE STUDENT
(
RNO INT,
NAME VARCHAR(50),
CITY VARCHAR(50),
DID INT
);

CREATE TABLE ACADEMIC
(
RNO INT,
SPI DECIMAL(4,2),
BKLOG INT
);

CREATE TABLE DEPARTMENT
(
DID INT,
DNAME VARCHAR(50)
);

INSERT INTO STUDENT VALUES(101,'RAJU','RAJKOT',10);
INSERT INTO STUDENT VALUES(102,'AMIT','AHMEDABAD',20);
INSERT INTO STUDENT VALUES(103,'SANJAY','BARODA',40);
INSERT INTO STUDENT VALUES(104,'NEHA','RAJKOT',20);
INSERT INTO STUDENT VALUES(105,'MEERA','AHMEDABAD',30);
INSERT INTO STUDENT VALUES(106,'MAHESH','BARODA',10);

INSERT INTO ACADEMIC VALUES(101,8.8,0);
INSERT INTO ACADEMIC VALUES(102,9.2,2);
INSERT INTO ACADEMIC VALUES(103,7.6,1);
INSERT INTO ACADEMIC VALUES(104,8.2,4);
INSERT INTO ACADEMIC VALUES(105,7.0,2);
INSERT INTO ACADEMIC VALUES(106,8.9,3);

INSERT INTO DEPARTMENT VALUES(10,'COMPUTER');
INSERT INTO DEPARTMENT VALUES(20,'ELECTRICAL');
INSERT INTO DEPARTMENT VALUES(30,'MECHANICAL');
INSERT INTO DEPARTMENT VALUES(40,'CIVIL');

select * from STUDENT;
select * from ACADEMIC;
select * from DEPARTMENT;
*/

/*1. display detail of students from "COMPUTER" dept */
select s.RNO, s.NAME, d.DNAME, a.SPI, a.BKLOG
from STUDENT s 
join DEPARTMENT d 
on d.DID = s.DID
join ACADEMIC a
on a.RNO = s.RNO
where d.DNAME = 'COMPUTER';

/*2. display name of student whose spi is more than 8 */
select s.NAME, a.SPI
from STUDENT s 
join ACADEMIC a
on a.RNO = s.RNO
where a.SPI > 8;

/*3. Total no of student from "ELECTRICAL" dept */
select count(s.DID) as 'Total no of student from Electrical'
from STUDENT s 
join DEPARTMENT d 
on d.DID = s.DID
where d.DNAME = 'ELECTRICAL'
group by s.DID;

/*4. display detail of students from "COMPUTER" dept who belongs to "RAJKOT" */
select s.RNO, s.NAME, d.DNAME, a.SPI, a.BKLOG
from STUDENT s 
join DEPARTMENT d 
on d.DID = s.DID
join ACADEMIC a
on a.RNO = s.RNO
where s.CITY = 'RAJKOT';

/*5. display name of student who is having 2nd highest spi */
select s.RNO, s.name , a.spi 
from STUDENT s
join ACADEMIC a 
on s.RNO = a.RNO and
 s.RNO = (
	select RNO from ACADEMIC 
	where SPI in (select MAX(SPI) from ACADEMIC
	where SPI not in (select MAX(SPI) from ACADEMIC)));