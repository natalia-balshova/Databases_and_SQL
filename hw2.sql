DROP DATABASE IF EXISTS hw2;
CREATE DATABASE IF NOT EXISTS hw2;

USE hw2;

-- 1. Используя операторы языка SQL, создайте табличку “sales”. Заполните ее данными

DROP TABLE IF EXISTS `sales`;
CREATE TABLE IF NOT EXISTS `sales`
(
`id` INT PRIMARY KEY AUTO_INCREMENT,
`order_date` DATE,
`count_product` INT
);

INSERT INTO `sales` (`order_date`, `count_product`)
VALUES
('2022-01-01', 156), 
('2022-01-02', 180),
('2022-01-03', 21),
('2022-01-04', '124'),
('2022-01-05', '341');

SELECT * FROM sales;

/*2.  Сгруппируйте значений количества в 3 сегмента — меньше 100, 100-300 и больше 300, используя функцию IF.
Для данных таблицы “sales” укажите тип заказа в зависимости от кол-ва : 
меньше 100  -    Маленький заказ
от 100 до 300 - Средний заказ
больше 300  -     Большой заказ
*/

SELECT id, order_date, count_product,
 IF (count_product < 100, 'Маленький заказ', 
   IF (count_product between 100 AND 300, 'Средний заказ', 
     IF (count_product > 300, 'Большой заказ', 'Не определено')  
      )
 ) AS order_type
 FROM sales;
 
-- 3. Создайте таблицу “orders”, заполните ее значениями. Покажите “полный” статус заказа, используя оператор CASE
 
DROP TABLE IF EXISTS `orders`;
CREATE TABLE IF NOT EXISTS `orders`
(
`id` INT PRIMARY KEY AUTO_INCREMENT,
`employee_id` VARCHAR(45),
`amount` DECIMAL(10,2),
`order_status` VARCHAR(45)
);

INSERT INTO `orders` (`employee_id`, `amount`, `order_status`)
VALUES
('e03', 15.00, 'OPEN'), 
('e01', 25.50, 'OPEN'),
('e05', 100.70, 'CLOSED'),
('e02', 22.18, 'OPEN'),
('e04', 10.50, 'CANCELLED');

SELECT id, employee_id, amount, order_status,
CASE
	WHEN order_status = 'OPEN' THEN 'Order is in open state'
    WHEN order_status = 'CLOSED' THEN 'Order is closed'
    WHEN order_status = 'CANCELLED' THEN 'Order is cancelled'
    ELSE 'Status is not defined'
END AS full_order_status
FROM orders;

/* 4. Чем NULL отличается от 0?
NULL - данные в ячейке отсутствуют, 0 - это уже данные, как и пустая строка или пробел */
