use ikea;

-- 1. Easy Discount
DELIMItER //
create PROCEDURE discount(in persen int)
begin
select productname as `Product Name`,
concat ('Rp. ', ROUND(Price * (100 - persen) / 100, 0)) as `Harga Setelah Discount`
from products
order by price ASC
limit 10;
end //
delimiter ;

-- 2. Counting Game
DELIMITER //
CREATE Procedure counting(in s VARCHAR(255))
begin 
declare i int default 1;
declare c char (1);
declare total int default 0;
declare ada int default 0;

if CHAR_LENGTH(s) >= 100 THEN
select 'input harus kurang dari 100 char' as `Total Kata`;
else
set s = concat(s, ' ');
WHILE i <= CHAR_LENGTH(s) DO
SET c = SUBSTRING(s, i, 1);
IF c = ' ' THEN
SET total = total + ada;
SET ada = 0;
ELSEIF c REGEXP '[A-Za-z]' THEN
SET ada = 1;
END IF;
SET i = i + 1;
END WHILE;
SELECT total AS 'Total Kata';
END IF;
END //
delimiter ;

-- 3. Prime Check
delimiter //
create PROCEDURE primecheck(in n int)
begin
declare i int default 2;
declare prime int default 1;

if n < 2 or n >= 50 then 
    SELECT 'input harus >-2 AND < 50' as ans;
ELSE
    while i * i <= n DO
        if n mod i = 0 THEN
            set prime = 0;
        end if;
        set i = i + 1;
    end while;
    if prime = 1 THEN
        select 'prima' as ans;
    else
        select 'bukan prima' as ans;
    end if;
end IF;
end//
delimiter ;

-- 4. box
delimiter //
create Procedure box(in x int, in y int)
begin
declare r int default 1;
declare baris int;
declare garis varchar(255);
declare isi varchar(255);

set baris = x * y - 1;
set garis = concat('+', REPEAT(CONCAT(REPEAT('-', y - 1), '+'), x));
set isi = concat('|', REPEAT(CONCAT(REPEAT(' ', y - 1), '|'), x));
drop TEMPORARY table if EXISTS temp_box;
create TEMPORARY TABLE temp_box (id int AUTO_INCREMENT PRIMARY KEY, Box VARCHAR(255));
WHILE r <= baris DO
    IF (r - 1) MOD (y - 1) = 0 OR r = baris THEN
        insert into temp_box (Box) values (garis);
    ELSE
        insert into temp_box (Box) values (isi);
    END IF;
    SET r = r + 1;
    end while;
    select Box from temp_box order by id;
END //
DELIMITER ;




-- Test --
call discount(50);
call counting('i tot i taw a putty tat');
call counting('Be Mature is A Must ! Be Childish is A Need ...');
call primecheck(7); -- prima
call primecheck(20); -- bukan prima
call box(2,5);
call box(3,5);