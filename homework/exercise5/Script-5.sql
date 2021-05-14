-- Практическое задание по теме «Операторы, фильтрация, сортировка и ограничение»
-- 1
UPDATE users set created_at  = NULL, updated_at = NULL;
UPDATE users set created_at  = NOW(), updated_at = NOW();


-- 2
ALTER TABLE users MODIFY created_at VARCHAR(40), MODIFY updated_at VARCHAR(40);
desc users;
ALTER TABLE users MODIFY created_at datetime, MODIFY updated_at datetime;


-- 3
CREATE TABLE storehouses_products (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  storehouse_id INT UNSIGNED,
  product_id INT UNSIGNED,
  value INT UNSIGNED COMMENT 'Запас товарной позиции на складе',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Запасы на складе';

INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES (1, 6, 3, 1, '1943-01-18 21:58:56', '1991-05-03 12:01:10');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES (2, 3, 9, 4, '1925-01-23 00:00:11', '2021-03-26 08:35:25');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES (3, 0, 4, 6, '1954-03-16 17:03:40', '1972-01-12 10:29:58');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES (4, 7, 4, 4, '1991-03-09 20:31:47', '1990-10-09 13:57:14');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES (5, 3, 0, 3, '2012-11-10 09:31:26', '1993-10-03 10:03:56');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES (6, 5, 7, 7, '1933-10-13 18:02:23', '1992-06-15 03:28:16');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES (7, 2, 9, 6, '2005-10-08 03:20:43', '1983-12-07 01:09:09');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES (8, 3, 1, 5, '1941-12-14 16:01:26', '1959-02-10 17:49:31');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES (9, 1, 1, 2, '1979-12-07 00:02:24', '2001-10-08 18:11:45');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES (10, 1, 0, 5, '1964-12-20 13:59:06', '1993-08-20 19:39:42');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES (11, 0, 9, 1, '2002-10-11 19:54:09', '1968-10-15 05:27:24');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES (12, 2, 7, 7, '1950-01-11 17:47:25', '1984-08-24 20:38:11');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES (13, 8, 3, 9, '1987-05-02 10:14:49', '2016-10-31 03:07:06');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES (14, 8, 7, 6, '1968-08-19 05:29:36', '2010-10-27 21:58:51');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES (15, 9, 7, 9, '2018-02-10 13:18:13', '2002-02-18 23:23:34');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES (16, 9, 4, 4, '1997-11-04 10:06:29', '1942-06-20 17:55:36');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES (17, 3, 4, 5, '1992-01-05 23:55:54', '1941-05-29 20:26:13');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES (18, 6, 6, 1, '2013-07-23 23:42:55', '1929-11-27 14:27:35');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES (19, 7, 4, 3, '1938-05-21 04:33:25', '1969-10-05 07:47:11');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES (20, 8, 6, 5, '1999-09-23 07:05:50', '2001-01-07 19:33:25');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES (21, 8, 5, 9, '1925-08-27 23:51:18', '1957-06-20 22:28:32');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES (22, 7, 8, 3, '2016-01-22 14:53:48', '1936-03-24 22:54:00');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES (23, 1, 6, 5, '2020-06-20 21:59:02', '1991-04-27 19:14:14');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES (24, 1, 3, 0, '1933-11-15 13:29:44', '2009-10-25 22:19:16');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES (25, 8, 2, 0, '1926-12-02 10:45:44', '1982-10-04 19:25:19');


SELECT * FROM storehouses_products ORDER BY CASE WHEN value > 0 THEN value else LAST_INSERT_ID()+100500 END;


-- Практическое задание теме «Агрегация данных»
CREATE TABLE users_shop (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя покупателя',
  birthday_at DATE COMMENT 'Дата рождения',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Покупатели';

INSERT INTO users_shop (name, birthday_at) VALUES
  ('Геннадий', '1990-10-05'),
  ('Наталья', '1984-11-12'),
  ('Александр', '1985-05-20'),
  ('Сергей', '1988-02-14'),
  ('Иван', '1998-01-12'),
  ('Мария', '1992-08-29');

-- 1
SELECT AVG(YEAR(CURDATE())-YEAR(birthday_at)) FROM users_shop;

-- 2
SELECT COUNT(1), DATE_FORMAT(DATE(CONCAT_WS('-', YEAR(NOW()), MONTH(birthday_at), DAY(birthday_at))), '%W') week_day FROM users_shop
GROUP BY week_day;
