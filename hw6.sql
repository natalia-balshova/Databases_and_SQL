DROP DATABASE IF EXISTS hw6;
CREATE DATABASE IF NOT EXISTS hw6;

USE hw6;

/* 1. Создайте функцию, которая принимает кол-во сек и формат их в кол-во дней часов. 
Пример: 123456 ->'1 days 10 hours 17 minutes 36 seconds' */

delimiter //
DROP FUNCTION IF EXISTS time_func; //
CREATE FUNCTION time_func(num INT) -- количество секунд 
RETURNS VARCHAR(50)
DETERMINISTIC
BEGIN
DECLARE sec INT DEFAULT 0;
DECLARE min INT DEFAULT 0; 
DECLARE hours INT DEFAULT 0;
DECLARE days INT DEFAULT 0;
DECLARE result VARCHAR(54) DEFAULT ' ';
SET sec = MOD(num, 60);
SET days = num DIV 86400;
SET hours = (num - days * 86400) DIV 3600;
SET min = (num - days * 86400 - hours * 3600) DIV 60;
SET result = concat(days, ' days ', hours, ' hours ', min, ' minutes ', sec, ' seconds');
RETURN result;
END //
delimiter ;


SELECT time_func(123456) AS `time`;


-- 2. Создайте процедуру которая, выводит только четные числа от 1 до 10.  Пример: 2,4,6,8,10 

-- ВАРИАНТ 1

delimiter //
DROP PROCEDURE IF EXISTS numbers; //
CREATE PROCEDURE numbers()
BEGIN
DECLARE num INT DEFAULT 4;
DECLARE result VARCHAR(30) DEFAULT '2';
WHILE num <= 10
DO
SET result = CONCAT(result, ', ', num);
SET num = num + 2;
END WHILE;
SELECT result;
END //
delimiter ;

CALL numbers();

-- ВАРИАНТ 2

delimiter //
DROP PROCEDURE IF EXISTS numbers2; //
CREATE PROCEDURE numbers2()
BEGIN
DECLARE num INT DEFAULT 3;
DECLARE result VARCHAR(30) DEFAULT '2';
WHILE num <= 10
DO
IF num % 2 = 0 THEN
SET result = CONCAT(result, ', ', num);
END IF;
SET num = num + 1;
END WHILE;
SELECT result;
END //
delimiter ;

CALL numbers2();
