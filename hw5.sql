DROP DATABASE IF EXISTS hw5;
CREATE DATABASE IF NOT EXISTS hw5;

USE hw5;

CREATE TABLE cars
(
	id INT NOT NULL PRIMARY KEY,
    name VARCHAR(45),
    cost INT
);

INSERT cars
VALUES
	(1, "Audi", 52642),
    (2, "Mercedes", 57127 ),
    (3, "Skoda", 9000 ),
    (4, "Volvo", 29000),
	(5, "Bentley", 350000),
    (6, "Citroen ", 21000 ), 
    (7, "Hummer", 41400), 
    (8, "Volkswagen ", 21600);
    
SELECT * FROM cars;

-- 1. Создайте представление, в которое попадут автомобили стоимостью до 25 000 долларов

CREATE VIEW CheapCars AS SELECT `name` FROM cars WHERE cost < 25000;

SELECT * FROM CheapCars;

-- 2. Изменить в существующем представлении порог для стоимости: пусть цена будет до 30 000 долларов (используя оператор ALTER VIEW)
ALTER VIEW CheapCars AS SELECT `name` FROM cars WHERE cost < 30000;

SELECT * FROM CheapCars;

-- 3. Создайте представление, в котором будут только автомобили марки “Шкода” и “Ауди” (аналогично)
CREATE VIEW SelectedCars AS 
SELECT `id`, `name`, `cost` 
FROM cars 
WHERE `name` = "Audi" OR `name` = "Skoda";

SELECT * FROM SelectedCars;

-- 1* Получить ранжированный список автомобилей по цене в порядке возрастания
SELECT 
DENSE_RANK() OVER(ORDER BY `cost` DESC) `dense_rank`,
`name`, `cost`
FROM cars;

-- 2* Получить топ-3 самых дорогих автомобилей, а также их общую стоимость
SELECT `dense_rank`, `id`, `name`, `cost`, SUM(cost) OVER () AS `top 3 sum`
FROM 
(SELECT 
DENSE_RANK() OVER(ORDER BY `cost` DESC) `dense_rank`,
`id`, `name`, `cost`
FROM cars) AS `rank_list` WHERE `dense_rank` <= 3;


-- 3* Получить список автомобилей, у которых цена больше предыдущей цены (т.е. у которых произошло повышение цены)
SELECT `name` FROM
(SELECT *, LAG(cost) OVER (ORDER BY cost) AS `prew_cost` FROM cars) AS `costs_tab`
WHERE cost > prew_cost;

-- 4* Получить список автомобилей, у которых цена меньше следующей цены (т.е. у которых произойдет снижение цены)
SELECT `name` FROM
(SELECT *, LEAD(cost) OVER (ORDER BY cost) AS `next_cost` FROM cars) AS `costs_tab`
WHERE cost < next_cost;

-- 5* Получить список автомобилей, отсортированный по возрастанию цены, и добавить столбец со значением разницы между текущей ценой и ценой следующего автомобиля
SELECT `id`, `name`, `cost`,
`lead_cost` - `cost` AS `difference`
FROM(
SELECT 
`id`, `name`, `cost`, 
LEAD(cost) OVER(ORDER BY `cost`) `lead_cost` FROM cars) AS `tab_for_calc`;