use credit_card
go

/* Create a report that contains each customer's history of purchasing books. Be sure to include the cusotmer name, customer ID, book ID, DOP and shopping card ID. */

/*

create view Customer_Report as
select c.Customer_ID, c.Customer_Name, 
sc.Book_ID, o.Date_of_Purchase, o.Shopping_Cart_ID
from CUSTOMER c
join ORDER_DETAILS o on o.Customer_ID = c.Customer_ID
join SHOPPING_CART sc on sc.Shopping_Cart_ID = o.Shopping_Cart_ID

go 

*/

select * from Customer_Report;