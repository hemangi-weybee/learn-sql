use taskDB
go

create table tasks (
	Task_ID int identity(1,1),
	Start_Date Date,
	End_Date Date
)

--insert into tasks 
--values
--	('2015-10-01', '2015-10-02'),
--	('2015-10-02', '2015-10-03'),
--	('2015-10-03', '2015-10-04'),
--	('2015-10-13', '2015-10-14'),
--	('2015-10-14', '2015-10-15'),
--	('2015-10-28', '2015-10-29'),
--	('2015-10-30', '2015-10-31');

select * from tasks

select Start_Date, MIN(End_Date) End_Date from 
(select Start_Date from tasks where Start_Date not in (select End_Date from tasks)) t_start_date, 
(select End_Date from tasks where End_Date not in (select Start_Date from tasks)) t_end_date
	where Start_Date < End_Date
	group by Start_Date 
	order by DATEDIFF(day, Start_Date, MIN(End_Date)), Start_Date


-------------------- Using Temporary table -----------------------
drop table if exists #t_start_date
drop table if exists #t_end_date

create table #t_start_date (
	Start_Date Date
)

create table #t_end_date (
	End_Date Date
)

insert into #t_start_date select Start_Date from tasks where Start_Date not in (select End_Date from tasks);
insert into #t_end_date select End_Date from tasks where End_Date not in (select Start_Date from tasks);

select Start_Date, MIN(End_Date) End_Date from  #t_start_date, #t_end_date
	where Start_Date < End_Date
	group by Start_Date 
	order by DATEDIFF(day, Start_Date, MIN(End_Date)), Start_Date


------------ Creating temp table ------
drop table if exists #t_start_date
drop table if exists #t_end_date

select Start_Date into #t_start_date from tasks where Start_Date not in (select End_Date from tasks);
select End_Date into #t_end_date from tasks where End_Date not in (select Start_Date from tasks);

select Start_Date, MIN(End_Date) End_Date from  #t_start_date, #t_end_date
	where Start_Date < End_Date
	group by Start_Date 
	order by DATEDIFF(day, Start_Date, MIN(End_Date)), Start_Date

	--SELECT CAST(ROUND(235.715, 0) AS INT)

	--select cast(ROUND(184.16159999999999 , 4) as decimal(10,4));

	