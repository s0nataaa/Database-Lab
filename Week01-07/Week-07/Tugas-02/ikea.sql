use ikea;;


--------------------------------------------------------------
SELECT
    TABLE_NAME,
    COUNT(*) AS jumlah_kolom
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = DATABASE()
GROUP BY TABLE_NAME
ORDER BY TABLE_NAME;

SELECT
    TABLE_NAME,
    COLUMN_NAME,
    COLUMN_TYPE,
    COLUMN_KEY
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = DATABASE()
ORDER BY TABLE_NAME, ORDINAL_POSITION;

SELECT
    TABLE_NAME,
    COLUMN_NAME,
    REFERENCED_TABLE_NAME,
    REFERENCED_COLUMN_NAME
FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE TABLE_SCHEMA = DATABASE()
AND REFERENCED_TABLE_NAME IS NOT NULL
ORDER BY TABLE_NAME;

--------------------------------------------------------------
-----employee dan gaji, order by nama desc---
select CONCAT(e.FirstName, ' ', e.LastName) as `Employee_Name`, j.salary
from employees e
join jobs j on e.jobid = j.jobid
order by `Employee_Name` desc;

---rak dengan product paling banyak---
select s.ShelfID as `ShelfID`
from shelves s
join products p on s.ShelfID = p.ShelfID
group by s.ShelfID
order by sum(p.stock) asc
limit 3;

---show count employee on each job---
select j.jobdesc as Jobs, 
count(e.employeeid) as Jumlah
from jobs j
JOIN employees e ON j.jobID = e.jobID
group by j.jobid, j.jobdesc;

---metod from product dan jumlahnya---
select p.productname as Products, p.stock
from products p
join producttype y on p.typeid = y.TypeID
where y.Typename like '%METOD%'
ORDER BY y.TypeName ASC;

---manager pindah dept---
select
concat(firstname, ' ', lastname) as `Name`
from employees
where `ManagerID` is null and jobid like 'J0010' and deptid is not null
ORDER BY `Name` asc;

---recap only bulan Jan, show price dari tiap orderid resto, with roll up---
select 
IFNULL(r.F_OrderID, 'Total') AS OrderID,
sum(f.price) as `Total Price`
from restaurant r
join forderdetails f on r.f_orderid = f.F_orderid
where r.F_OrderDate >= '2015-01-01' AND r.F_OrderDate < '2015-02-01'
group by r.f_orderid with ROLLUP;



SELECT
    e.EmployeeID,
    CONCAT(e.FirstName, ' ', e.LastName) AS Name,
    j.JobDesc AS Job,
    COUNT(*) AS Total_Record
FROM (
    SELECT EmployeeID
    FROM orders

    UNION ALL

    SELECT EmployeeID
    FROM restaurant
) AS all_orders
JOIN employees e ON all_orders.EmployeeID = e.EmployeeID
JOIN jobs j ON e.JobID = j.JobID
GROUP BY e.EmployeeID, e.FirstName, e.LastName, j.JobDesc
ORDER BY Total_Record DESC;

---show orrder price > 500k---
SELECT orderid,
MAX(price) as `Total Revenue`
from orderdetails
group by OrderID
having sum(price) > 500000

union ALL

SELECT f_orderid as orderid,
MAX(price) as `Total Revenue`
from forderdetails
group by F_OrderID
having sum(price) > 500000

order by orderid asc;

---show nama karyawan beserta nama managernya---
SELECT 
concat(m.Firstname, ' ', m.Lastname) as Manager,
group_concat(concat(e.Firstname, ' ', e.Lastname)) as Employee
from employees e
join employees m on e.ManagerID = m.EmployeeID
where m.ManagerID is NULL
GROUP BY m.EmployeeID;





