use ikea;


/*1. name, deptname, asc*/
select concat(e.FirstName, ' ', e.LastName) as Name,
d.DeptName
from employees e
join depts d on e.`DeptID` = d.`DeptID`
order by d.deptName ASC;

/*2. name employee, name manager, asc*/
select CONCAT(e.FirstName, ' ', e.lastname) as `Employee Name`,
CONCAT(m.FirstName, ' ', m.LastName) as `Manager Name`
from employees e
join employees m on e.`ManagerID` = m.`EmployeeID`
order by m.`FirstName`, e.`FirstName` asc;

/*3. name employee, data orders dengan separator -, order by name employee desc*/
SELECT CONCAT(e.FirstName, ' ', e.LastName) as Name,
group_concat(o.orderID SEPARATOR ' - ') as Orders
from employees e
join orders o on e.`EmployeeID` = o.`EmployeeID`
group by e.`EmployeeID`, e.`FirstName`, e.`LastName`
order BY Name ASC;

/*4. select all product + total sold where sold minimal 1x*/
SELECT p.productname as `Product name`,
sum(o.qty) as `Total Sold`
from products p
join orderdetails o on p.`ArticleID` = o.`ArticleID`
GROUP BY p.`ArticleID`
ORDER BY `Total Sold` desc;

/*5. no 4 tapi pake left join*/
SELECT p.productname as `Product name`,
coalesce(sum(o.qty), 0) as `Total Sold`
from products p
left join orderdetails o on p.`ArticleID` = o.`ArticleID`
GROUP BY p.`ArticleID`
ORDER BY `Total Sold` desc;

/*6. show orderID, qty x price, employee name*/
SELECT o.orderid as `Order ID`,
sum(o.price) as Total,
CONCAT(e.firstname, ' ', e.lastname) as `In Charge`
from orderdetails o
join orders r on o.orderID = r.`OrderID`
join employees e on r.`EmployeeID` = e.`EmployeeID`
group by o.`OrderID`, e.`EmployeeID`
order by e.`FirstName` asc, o.price DESC;

/*7. bonus to employee where profit > 500k, show nama employee, jumlah profit, bonus employee*/
select CONCAT(e.firstname, ' ', e.lastname) as Employee,
round(sum(o.price) * 0.12) as Contribution,
round(j.salary * 0.05) as Bonus
from employees e
join jobs j on e.`JobID` = j.`JobID`
join orders r on e.`EmployeeID` = r.`EmployeeID`
join orderdetails o on r.`OrderID` = o.`OrderID`
GROUP BY e.`EmployeeID`, j.`Salary`
having sum(o.`Price`) * 0.12 > 500000
order by contribution desc;

/*8. */
SELECT CONCAT(
        RPAD(CONCAT(e.firstname, ' ', e.lastname), 24, ' '),
        RPAD(CASE
                WHEN j.JobDesc LIKE 'Restaurant%' THEN 'works in a'
                WHEN LEFT(j.JobDesc, 1) IN ('A','E','I','O','U') THEN 'works as an'
                ELSE 'works as a'
            END, 12, ' '),
        RPAD(j.JobDesc, 40, ' '),
        'in ', d.DeptName
    ) AS `Employees information`
FROM employees e
JOIN jobs j ON e.`JobID` = j.`JobID`
JOIN depts d ON e.`DeptID` = d.`DeptID`
ORDER BY j.JobDesc, d.DeptName, CONCAT(e.firstname, ' ', e.lastname);

/*9. Disable Autcommit*/
SET autocommit = 0;

/*10. Salary Employee = 0 */
UPDATE jobs SET Salary = 0;

/*11. Savepoint*/
SAVEPOINT ikea_gaji_nol;

/*12. Update Employee FirstName to Tommy*/
UPDATE employees SET FirstName = 'Tommy';

/*13. Rollback To Savepoint*/
ROLLBACK TO SAVEPOINT ikea_gaji_nol;

/*14. Rollback before hacker masuk*/
ROLLBACK;


