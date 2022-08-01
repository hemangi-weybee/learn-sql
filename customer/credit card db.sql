
/*Create database */


--CREATE DATABASE credit_card;

 use credit_card;
 go
--
-- Database: credit_card
--

-- --------------------------------------------------------


-- Table structure for Author

create table AUTHOR (
	Author_ID bigint identity(1,1) PRIMARY KEY,
	Author_Name varchar(255),
);

-- Table structure for Publisher

create table PUBLISHER (
	Publisher_ID bigint identity(1,1) PRIMARY KEY,
	Publisher_Name varchar(255)
);

-- Table structure for Books

create table BOOKS (
	Book_ID bigint identity(1,1) PRIMARY KEY,
	Book_Name varchar(255),
	Author_ID bigint FOREIGN KEY REFERENCES AUTHOR (Author_ID),
	Price float,
	Publisher_ID bigint FOREIGN KEY REFERENCES PUBLISHER (Publisher_ID)
);

-- Table structure for Credit card Details

create table CREDIT_CARD_DETAILS  (
	Credit_Card_Number varchar(255) PRIMARY KEY,
	Credit_Card_Type varchar(255),
	Expiry_Date date
);

-- Table structure for Customer

create table CUSTOMER (
	Customer_ID bigint identity(1, 1) PRIMARY KEY,
	Customer_Name varchar(255),
	Street_Address varchar(255),
	City varchar(128),
	Phone_Number varchar(64),
	Credit_Card_Number varchar(255) FOREIGN KEY REFERENCES CREDIT_CARD_DETAILS (Credit_Card_Number)
);

-- Table structure for Shipping Type

create table SHIPPING_TYPE (
	Shipping_Type varchar(64) PRIMARY KEY,
	Shipping_Price int
);

-- Table structure for Shopping Cart

create table SHOPPING_CART (
	Shopping_Cart_ID int identity(1,1) PRIMARY KEY ,
	Book_ID bigint FOREIGN KEY REFERENCES BOOKS (Book_ID),
	Price float,
	Date date,
	Quantity int
);

-- Table structure for Order Details

create table ORDER_DETAILS (
	Order_ID bigint identity(1,1) PRIMARY KEY,
	Customer_ID bigint FOREIGN KEY REFERENCES CUSTOMER (Customer_ID),
	Shipping_Type varchar(64) FOREIGN KEY REFERENCES SHIPPING_TYPE (Shipping_Type),
	Date_of_Purchase date,
	Shopping_Cart_ID int FOREIGN KEY REFERENCES SHOPPING_CART (Shopping_Cart_ID),
);

-- Table structure for Purchase History

create table PURCHASE_HISTORY (
	Customer_ID bigint FOREIGN KEY REFERENCES CUSTOMER (Customer_ID),
	Order_ID bigint FOREIGN KEY REFERENCES ORDER_DETAILS(Order_ID)
);


----
---- Dumping data for tables 
----

-- Dumping data for table Author

insert into AUTHOR (Author_Name) values
('Author 1'),
('Author 2');

-- Dumping data for table Publisher

insert into PUBLISHER (Publisher_Name) values
('Publisher 1'),
('Publisher 2');

-- Dumping data for table Books

insert into BOOKS (Book_Name, Price, Author_ID, Publisher_ID) values 
('Book 1', 500 ,1, 1),
('Book 2', 500 ,2, 2);

-- Dumping data for table Credit card Details

insert into CREDIT_CARD_DETAILS (Credit_Card_Number, Credit_Card_Type, Expiry_Date) values
('1111 1111 2222','Visa', '2026-06-30'),
('2222 2222 3333','Visa', '2032-08-31');

-- Dumping data for table Customer

insert into CUSTOMER (Customer_Name, Street_Address, City, Phone_Number, Credit_Card_Number) values 
('Customer 1', 'Nakshtra 3', 'Rajkot', 9988776655, '1111 1111 2222'),
('Customer 2', 'Nakshtra 7', 'Rajkot', 9911223344, '2222 2222 3333');

-- Dumping data for table Shipping Type

insert into SHIPPING_TYPE (Shipping_Type, Shipping_Price) values 
('International', 5000),
('National', 500);

-- Dumping data for table Shopping Cart

insert into SHOPPING_CART (Book_ID, Price, Date, Quantity) values 
(1, 500, '2022-07-30', 1),
(2, 500, '2022-07-30', 1);


-- Dumping data for table Order Details

insert into ORDER_DETAILS (Customer_ID, Shipping_Type, Date_of_Purchase, Shopping_Cart_ID) values 
(1, 'National', '2022-07-20', 1),
(2, 'National', '2022-07-20', 2);

-- Dumping data for table Purchase History

insert into PURCHASE_HISTORY (Customer_ID, Order_ID) values 
(1, 1),
(2, 2);


select * from AUTHOR;
select * from PUBLISHER;
select * from BOOKS;
select * from CREDIT_CARD_DETAILS;
select * from CUSTOMER;
select * from SHIPPING_TYPE;
select * from SHOPPING_CART;
select * from ORDER_DETAILS;
select * from PURCHASE_HISTORY;
