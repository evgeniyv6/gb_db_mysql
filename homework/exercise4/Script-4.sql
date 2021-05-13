
-- Урок 4
-- CRUD операции

-- Работа с БД vk
-- Загружаем дамп консольным клиентом
DROP DATABASE vk;
CREATE DATABASE vk;

-- Переходим в папку с дампом (/home/ubuntu)
-- mysql vk < fulldb_before.sql
-- или mysql --default-character-set=utf8 vk < fulldb_before.sql
-- или копируем текст из файла и вставляем в DBeaver, Workbench и т.п.

-- Доработки и улучшения структуры БД vk
USE vk;

-- Дорабатываем тестовые данные
-- Смотрим все таблицы
SHOW TABLES;

-- Анализируем данные пользователей
SELECT * FROM users LIMIT 10;

-- Смотрим структуру таблицы пользователей
DESC users;

-- Приводим в порядок временные метки
UPDATE users SET updated_at = NOW() WHERE updated_at < created_at;                  

-- Смотрим структуру профилей
DESC profiles;

-- Анализируем данные
SELECT * FROM profiles LIMIT 10;

-- Поправим столбец пола
CREATE TEMPORARY TABLE genders (name CHAR(1));

INSERT INTO genders VALUES ('M'), ('F'); 

SELECT * FROM genders;

-- Обновляем пол
UPDATE profiles 
  SET gender = (SELECT name FROM genders ORDER BY RAND() LIMIT 1);

-- Таблица статусов пользователей
CREATE TABLE user_statuses (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки", 
  name VARCHAR(100) NOT NULL COMMENT "Название статуса (уникально)",
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Справочник статусов";  
INSERT INTO user_statuses (name) VALUES
 ('single'),
 ('married');
SELECT * FROM user_statuses;

-- обновляем профили в соответствии со таблицей статусов
UPDATE profiles SET status = null;
ALTER TABLE profiles RENAME COLUMN status TO user_status_id; 
ALTER TABLE profiles MODIFY COLUMN user_status_id INT UNSIGNED; 
-- ALTER TABLE profiles ADD FOREIGN KEY (user_status_id) REFERENCES user_statuses(id);
-- Обновляем статус
UPDATE profiles 
  SET user_status_id = (SELECT id FROM user_statuses ORDER BY RAND() LIMIT 1);


 -- Все таблицы
SHOW TABLES;

-- Смотрим структуру таблицы сообщений
DESC messages;
ALTER TABLE messages ADD COLUMN media_id INT UNSIGNED AFTER body; 


-- Анализируем данные
SELECT * FROM messages LIMIT 10;

-- Обновляем значения ссылок на отправителя и получателя сообщения
UPDATE messages SET 
  from_user_id = FLOOR(1 + RAND() * 100),
  to_user_id = FLOOR(1 + RAND() * 100);

-- Добавляем ссылки на медиафайлы
UPDATE messages SET  media_id = FLOOR(1 + RAND() * 100);

-- Приводим в порядок временные метки
UPDATE messages SET updated_at = NOW() WHERE updated_at < created_at;   

-- Смотрим структуру таблицы медиаконтента 
DESC media;

-- Анализируем данные
SELECT * FROM media LIMIT 10;

-- Обновляем ссылку на пользователя - владельца
UPDATE media SET user_id = FLOOR(1 + RAND() * 100);

-- Создаём временную таблицу форматов медиафайлов
DROP TABLE IF EXISTS extensions;
CREATE TEMPORARY TABLE extensions (name VARCHAR(10));

-- Заполняем значениями
INSERT INTO extensions VALUES ('jpeg'), ('avi'), ('mpeg'), ('png');

-- Проверяем
SELECT * FROM extensions;

-- Обновляем ссылку на файл
UPDATE media SET filename = CONCAT(
  'http://dropbox.net/vk/',
  filename,
  '.',
  (SELECT name FROM extensions ORDER BY RAND() LIMIT 1)
);

-- Обновляем размер файлов
UPDATE media SET size = FLOOR(10000 + (RAND() * 1000000)) WHERE size < 1000;

-- Заполняем метаданные
UPDATE media SET metadata = CONCAT('{"owner":"', 
  (SELECT CONCAT(first_name, ' ', last_name) FROM users WHERE id = user_id),
  '"}');  

-- Возвращаем столбцу метеданных правильный тип
ALTER TABLE media MODIFY COLUMN metadata JSON;

-- Анализируем типы медиаконтента
SELECT * FROM media_types;

-- Удаляем все типы
DELETE FROM media_types;

-- Добавляем нужные типы
INSERT INTO media_types (name) VALUES
  ('photo'),
  ('video'),
  ('audio')
;

-- DELETE не сбрасывает счётчик автоинкрементирования,
-- поэтому применим TRUNCATE
TRUNCATE media_types;

INSERT INTO media_types SET name = 'photo';
INSERT INTO media_types SET name = 'video';
INSERT INTO media_types SET name = 'audio';


-- Анализируем данные
SELECT * FROM media LIMIT 10;

-- Обновляем данные для ссылки на тип
UPDATE media SET media_type_id = FLOOR(1 + RAND() * 3);

-- Смотрим структуру таблицы дружбы
DESC friendship;

-- Анализируем данные
SELECT * FROM friendship LIMIT 10;

-- Обновляем ссылки на друзей
 /*!40000 ALTER TABLE `friendship` DISABLE KEYS */;
 UPDATE friendship SET 
  user_id = FLOOR(1 + RAND() * 100),
  friend_id = FLOOR(1 + RAND() * 100);

-- Исправляем случай когда user_id = friend_id

UPDATE friendship SET friend_id = friend_id + 1 WHERE user_id = friend_id;
 /*!40000 ALTER TABLE `friendship` ENABLE KEYS */;
 
-- Анализируем данные 
SELECT * FROM friendship_statuses;

-- Очищаем таблицу
TRUNCATE friendship_statuses;

-- Вставляем значения статусов дружбы
INSERT INTO friendship_statuses (name) VALUES
  ('Requested'),
  ('Confirmed'),
  ('Rejected');

 -- Повторная вставка
INSERT IGNORE INTO friendship_statuses (id, name) VALUES
  (1, 'Requested'),
  (2, 'Confirmed'),
  (3, 'Rejected');

INSERT  INTO friendship_statuses (id, name) VALUES
  (1, 'Requested1'),
  (2, 'Confirmed2'),
  (3, 'Rejected3')
  ON DUPLICATE KEY UPDATE name=VALUES(name);
 
 
 
-- Обновляем ссылки на статус 
UPDATE friendship SET status_id = FLOOR(1 + RAND() * 3); 

-- Смотрим структуру таблицы групп
DESC communities;

-- Анализируем данные
SELECT * FROM communities;

-- Удаляем часть групп
DELETE FROM communities WHERE id > 20;

-- Анализируем таблицу связи пользователей и групп
SELECT * FROM communities_users;

-- Обновляем значения community_id
UPDATE communities_users SET community_id = FLOOR(1 + RAND() * 20);
DELETE FROM communities_users WHERE community_id > 100;

-- Клонирование таблиц

-- 1
CREATE TABLE friendship_statuses_new LIKE friendship_statuses; 
INSERT INTO friendship_statuses_new SELECT * FROM friendship_statuses;
SELECT * FROM friendship_statuses_new;
-- 2
CREATE TABLE friendship_statuses_new2 AS SELECT * FROM friendship_statuses;
SELECT * FROM friendship_statuses_new2;
-- 3
SHOW CREATE TABLE friendship_statuses;
-- Использование справки в терминальном клиенте

HELP SELECT;

-- exercise 4

CREATE TABLE cities (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки", 
  country VARCHAR(50) NOT NULL COMMENT "Страна",
  city VARCHAR(50) NOT NULL COMMENT "Город",
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Справочник стран и городов";  
SELECT * FROM cities;
INSERT INTO cities (country, city) VALUES
('Palau','Melekeok') ,
('Panama','Panama City') ,
('Papua New Guinea','Port Moresby') ,
('Paraguay','Asuncion') ,
('Peru','Lima') ,
('Philippines','Manila') ,
('Poland ','Warsaw') ,
('Portugal','Lisbon') ,
('Qatar','Doha') ,
('Romania','Bucharest') ,
('Russia','Moscow') ,
('Rwanda','Kigali') ,
('Saint Kitts and Nevis','Basseterre') ,
('Saint Lucia','Castries') ,
('Saint Vincent and the Grenadines','Kingstown') ,
('Samoa','Apia');
SELECT * FROM cities;

select * from users;

ALTER TABLE users ADD COLUMN city VARCHAR(50) NOT NULL AFTER email; 
ALTER TABLE users ADD COLUMN country VARCHAR(50) NOT NULL AFTER city; 

UPDATE users SET 
  city = FLOOR(1 + RAND() * 100),
  to_user_id = FLOOR(1 + RAND() * 100);

 UPDATE users u, cities c
  SET u.city = c.city, 
 	  u.country = c.country
  WHERE c.id = (select id from cities ORDER BY RAND() LIMIT 1);
