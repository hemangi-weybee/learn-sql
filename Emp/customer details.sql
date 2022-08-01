use credit_card
go

/*Create the view for the Customer_Details. View should include the columns: Customer Name, Customer Address and details of the order placed by customer. */


/*
create view Customer_Details as
select c.Customer_Name as 'Customer Name', c.Street_Address as 'Street Address', 
c.City, c.Phone_Number as 'Phone Number', c.Credit_Card_Number as 'Credit Card Number',
o.Shipping_Type as 'Shipping Type', o.Date_of_Purchase as 'Date of Purchase',
sc.Price, sc.Date as 'Delivery Date', sc.Quantity, 
b.Book_Name as 'Book Name', a.Author_Name as 'Author Name', p.Publisher_Name as 'Publisher Name'
from CUSTOMER c
join ORDER_DETAILS o on c.Customer_ID = o.Customer_ID
join SHOPPING_CART sc on o.Shopping_Cart_ID = sc.Shopping_Cart_ID 
join BOOKS b on b.Book_ID =  sc.Book_ID
join AUTHOR a on b.Author_ID = a.Author_ID
join PUBLISHER p on b.Publisher_ID = p.Publisher_ID;

go

*/

select * from Customer_Details;
