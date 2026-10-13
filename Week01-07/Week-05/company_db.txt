-- INIT
CREATE DATABASE company;
USE company;

create Table location (
    location_id VARCHAR(10) PRIMARY KEY,
    address VARCHAR(255),
    postal_code VARCHAR(10),
    city VARCHAR(50)
);

create Table job (
    job_id VARCHAR(10) PRIMARY KEY,
    job_title VARCHAR(50),
    min_salary INT,
    max_salary INT
);

create Table department (
    department_id VARCHAR(10) PRIMARY KEY,
    department_name VARCHAR(50),
    manager_id VARCHAR(10),
    location_id VARCHAR(10),
    FOREIGN KEY (location_id) REFERENCES location(location_id)
);

create Table employee (
    employee_id VARCHAR(10) PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    birth_date DATE,
    email VARCHAR(100),
    phone_number VARCHAR(20),
    hire_date DATE,
    salary INT,
    job_id VARCHAR(10),
    department_id VARCHAR(10),
    FOREIGN KEY (job_id) REFERENCES job(job_id),
    FOREIGN KEY (department_id) REFERENCES department(department_id)
);

-- insert values
insert INTO location VALUES
("L0001", "Grand Indonesia Lt. 9, Jalan M.H. Thamrin No 1, Jakarta Pusat", "10310", "Jakarta"),
("L0002", "Pacific Place Lt. 7, Jalan Jenderal Sudirman Kav. 52-53, Jakarta Selatan", "12190", "Jakarta");

insert INTO job VALUES
("J0001", "President", 10000000, 15000000),
("J0002", "Accountant", 3000000, 4500000),
("J0003", "Accounting Manager", 5000000, 7000000),
("J0004", "IT Support", 3500000, 5000000),
("J0005", "Programmer", 4000000, 5500000),
("J0006", "Marketing Manager", 6000000, 8000000),
("J0007", "Marketing Representative", 4500000, 5500000),
("J0008", "HR Manager", 5000000, 6500000),
("J0009", "HR Representative", 3500000, 4500000);

insert INTO department VALUES
("D0001", "Accounting", "E0002", "L0002"),
("D0002", "IT", "E0004", "L0001"),
("D0003", "Human Resource", "E0005", "L0001"),
("D0004", "Marketing", "E0010", "L0002");

insert INTO employee VALUES
("E0001", "Hideyoshi", "Kinoshita", "1975-08-24", "Hideyoshi.kino@gmail.com", "081689231099", "2002-01-11", 5000000, "J0004", "D0002"),
("E0002", "Sara", NULL, "1970-01-11", "Sara@rocketmail.com", "089281849321", "2000-12-10", 5500000, "J0003", "D0001"),
("E0003", "Kazuyoshi", NULL, "1968-02-28", "Kazuyoshi@gmail.com", "085252778438", "1999-07-25", 4500000, "J0009", "D0003"),
("E0004", "Shoichiro", "Yukimura", "1967-02-01", "Shoichiro.yuki@yahoo.com", "089928317822", "2000-04-17", 4500000, "J0005", "D0002"),
("E0005", "Chibi", "Usa", "1950-06-30", "Chibi.usa@gmail.com", "081329883547", "2001-08-10", 5000000, "J0008", "D0003"),
("E0006", "Yoshika", "Saehara", "1977-10-21", "Yoshika.sae@yahoo.com", "081299284628", "2005-11-18", 4500000, "J0008", "D0003"),
("E0007", "Kagami", "Mikage", "1970-10-08", "Kagami.mikage@rocketmail.com", "089628371298", "2002-05-15", 12500000, "J0001", NULL),
("E0008", "Reiko", "Shindo", "1948-11-14", "Reiko.shindo@live.com", "085290802938", "2002-09-01", 3500000, "J0004", "D0002"),
("E0009", "Youko", "Kuriki", "1970-03-19", "Youko.kuriki@hotmail.com", "089922781924", "2007-04-08", 5500000, "J0002", "D0001"),
("E0010", "Mana", "Ichihashi", "1976-11-21", "Mana.ichihashi@gmail.com", "087888291322", "2003-11-20", 6000000, "J0006", "D0004"),
("E0011", "Kyoko", "Aoi", "1965-09-30", "Kyoko.aoi@gmail.com", "081290208851", "2005-05-13", 8000000, "J0009", "D0003");

-- Update
update employee
set first_name = "Pedo", last_name = "Bear", email="pedo.bear@gmail.com"
where employee_id = "E0005";

update employee
set salary = salary - 100000;

update employee
set department_id = "D0002"
where employee_id = "E0002";

update employee
set department_id = NULL
WHERE employee_id = "E0004";

insert into employee values (
    "E0012", "Takumi", "Usui", "1982-04-27", "Usui.takumi@gmail.com", "085309009211", CURDATE(), 4500000, "J0007", "D0004"
);

update employee 
set salary = salary + 200000
where employee_id = "E0012";

update employee
set salary = salary * 1.10
where MONTH(birth_date) = 11 or TIMESTAMPDIFF(year, birth_date, "2017-12-10") >= 50;

alter Table department
add Foreign Key (manager_id) REFERENCES employee(employee_id);

-- Delete
set foreign_key_checks = 0;
drop table department;
drop Table employee;
drop Table job;
drop Table location;

set foreign_key_checks = 1

drop DATABASE company;
