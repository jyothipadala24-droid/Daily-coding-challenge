create database e_commerce_company;
use e_commerce_company;
CREATE TABLE customers ( 
customer_id INT PRIMARY KEY, 
customer_name VARCHAR(100), 
city VARCHAR(50) 
);
INSERT INTO customers VALUES 
(1, 'Amit', 'Bangalore'), 
(2, 'Sneha', 'Mumbai'), 
(3, 'Rahul', 'Delhi'), 
(4, 'Priya', 'Chennai');
CREATE TABLE orders ( 
order_id INT PRIMARY KEY, 
customer_id INT, 
order_date DATE,
amount DECIMAL(10,2) 
);
INSERT INTO orders VALUES 
(101, 1, '2024-01-10', 500), 
(102, 1, '2024-02-15', 700), 
(103, 2, '2024-03-01', 300), 
(104, 5, '2024-03-05', 900);
CREATE TABLE payments ( 
payment_id INT PRIMARY KEY, 
order_id INT, 
payment_status VARCHAR(20) 
);
INSERT INTO payments VALUES 
(1, 101, 'Completed'), 
(2, 102, 'Pending'), 
(3, 103, 'Completed');
#Task 1: Customer Orders
#Write a query to display:
#customer_name
#order_id
#amount
#Include only customers who placed orders.
select c.customer_name , o.order_id , o.amount from customers as c
left join orders as o on
c.customer_id = o.customer_id where o.order_id is not null;
#Task 2: All Customers
#Write a query to display:
#all customers
#their order_id (if any)
#Customers without orders should still appear.
select o.order_id , c.customer_name from customers  as c  left join orders  as o on
c.customer_id  = o.customer_id;
#Task 3: Invalid Orders
#Write a query to find:
#orders that do NOT have a matching customer
select c.customer_name , o.order_id  from customers as c
left join orders as o on
c.customer_id = o.customer_id where o.order_id is  null;
#Task 4: Order Payment Status
#Write a query to display:
#customer_name
#order_id
#payment_status
#Include all orders, even if payment is missing.
select c.customer_name , o.order_id , p.payment_status from customers as c 
left join orders as o on 
c.customer_id = o.customer_id left join 
payments as p on 
p.order_id = o.order_id;
#Task 5: Customers Without Orders
#Find customers who have never placed an order.
select c.customer_name , o.order_id from customers as c left join orders as o
on c.customer_id = o.customer_id where o.order_id is null;
#Task 6: Orders Without Payment
#Find all orders that do not have a payment record
select o.customer_id ,  p.payment_status  from orders as o left join payments as p on
o.order_id = p.order_id ;
#Task 7: Total Spending
#Write a query to calculate
#total amount spent by each customer
select customer_id , sum(amount) as total_amount_spent from orders group by customer_id;
#Task 8: Fully Paid Customers
#Find customers whose all orders are marked as 'Completed'.
select *from payments where payment_status = "completed";
#Task 9: Highest Order Per Customer
#Display:
#customer_name
#highest order amount
select c.customer_name , o.amount from customers as c left join
orders as o on c.customer_id = o.customer_id order by amount desc limit 1 ;
#Task 10: Top Customers
#Find top 2 customers based on total spending
select c.customer_name , sum(o.amount) as total_spending from customers as c left join
orders as o on c.customer_id = o.customer_id group by customer_name 
order by total_spending desc limit 2 ;
