use ikea;


-- 1. view_service_and_total
create view view_service_and_total AS
SELECT o.orderID as `Order ID`,
DATE_FORMAT(o.orderdate, '%d %M %y') as `Date`,
s.serviceDesc as `Service Type`,
s.price as `Service`,
sum(od.Price * od.Qty + s.Price) AS `Total`
from orders o 
join servicedetails d on o.orderID = d.orderID
join services s on d.serviceID= s.`ServiceID`
join orderdetails od on o.orderID = od.`OrderID`
where s.price is not NULL
group by o.`OrderID`, o.`OrderDate`, s.`ServiceID`, s.`ServiceDesc`, s.price;

select * from view_service_and_total;

-- 2. sales_by_year_month
create view sales_by_year_month as
select year(o.orderDate) as 'Year',
monthname(o.orderDate) as 'Month',
count(*) as 'Jumlah Transaksi',
concat("Rp. ", sum(d.Price * d.Qty),',-') as 'Sales'
from orders o
join orderdetails d on o.`OrderID` = d.orderid
GROUP By YEAR(O.orderdate), MONTH(o.`OrderDate`), MONTHNAME(o.`OrderDate`)
order by year(o.`OrderDate`), MONTH(o.`OrderDate`);

SELECT * from sales_by_year_month;

-- 3. nama_employees_sales
create view nama_employees_sales as
select e.employeeID as `Employee ID`, 
CONCAT(e.firstName, ' ', e.lastname) AS `Employee Name`,
j.jobdesc as `Job Name`,
j.salary as `Employee Salary`
from employees e
join jobs j on e.jobid = j.`JobID`
order by `Employee Name` ASC;

select * from nama_employees_sales;

-- 4. food_sales
create view food_sales as
select r.F_OrderID as ID,
date_FORMAT(r.f_orderdate, '%d %M %y') as Date,
concat(e.firstname, ' ', e.lastname) as `Employee Name`,
p.productname as `Order Food`,
f.price as Price,
f.qty as Quanity,
f.price * f.qty as Total
from restaurant r
join forderdetails f on r.`F_OrderID` = f.`F_OrderID`
join products p on f.`ArticleID` = p.`ArticleID`
join employees e on r.`EmployeeID` = e.`EmployeeID`;

select * from food_sales;

--- 5. create user
create user 'Aldwin'@'localhost' IDENTIFIED by 'aldsetiawan';
create user 'Hansen'@'localhost' IDENTIFIED by 'hnsedrick';
create user 'Reza'@'localhost' IDENTIFIED by 'rzasatyawijaya';
create user 'Sintya'@'localhost' IDENTIFIED by 'styoktaviani';

SELECT user, host FROM mysql.user;

--- 6. grant select
grant select on ikea.sales_by_year_month TO 'Aldwin'@'localhost' WITH grant option; 
grant select on ikea.food_sales TO 'Aldwin'@'localhost' WITH grant option; 
grant select on ikea.nama_employees_sales TO 'Hansen'@'localhost'; 
grant select on ikea.view_service_and_total TO 'Reza'@'localhost';

-- 7. grant select dari aldwin ke sintya, aldwin sudah diberikan grant option
grant SELECT on ikea.food_sales to 'Sintya'@'localhost';

SELECT `Year`,
sum(`Jumlah Transaksi`) as `Total Transaksi`,
concat('Rp. ', SUM(CAST(REPLACE(REPLACE(`Sales`, 'Rp. ', ''), ',-', '') AS UNSIGNED)),
',-') AS `Pendapatan Bruto`
from ikea.sales_by_year_month
group by `Year`; -- Aldwin Report

select `Order Food` as `Food`,
concat('Rp. ', sum(`Total`), ',-') as `Sales`
from ikea.food_sales
group by `Order Food`; -- Sintya Report

-- 8. hansen report 4 gaji tertinggi
select `Employee Name`, `Job Name` as `Job`, `Employee Salary` as `Salary`
from ikea.nama_employees_sales
order by `Employee Salary` desc, `Employee ID`
limit 4;

-- 9 Rexa report pendapatan delivery
select CONCAT('Rp. ', SUM(`Service`), ',-') as `Total Pendapatan dari Delivery Service`
from ikea.view_service_and_total
where `Service Type` LIKE '%Delivery%';

-- 10. drop user
drop user
'Aldwin'@'localhost', 
'Hansen'@'localhost', 
'Reza'@'localhost', 
'Sintya'@'localhost';
SELECT user, host FROM mysql.user;

-- drop view
drop view 
view_service_and_total, 
sales_by_year_month, 
nama_employees_sales, 
food_sales;

SHOW FULL TABLES WHERE Table_type = 'VIEW';



