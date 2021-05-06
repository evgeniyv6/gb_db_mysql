/*
1. Установите СУБД MySQL. Создайте в домашней директории файл .my.cnf, задав в нем логин и пароль, который указывался при установке.
	Выполнено. Файл ~/.my.cnf
2. Создайте базу данных example, разместите в ней таблицу users, состоящую из двух столбцов, числового id и строкового name.
3. Создайте дамп базы данных example из предыдущего задания, разверните содержимое дампа в новую базу данных sample.
4. (по желанию) Ознакомьтесь более подробно с документацией утилиты mysqldump. Создайте дамп единственной таблицы help_keyword базы данных mysql. Причем добейтесь того, чтобы дамп содержал только первые 100 строк таблицы.
*/

-- 2
create schema example;
use example;

create table users (
	id int,
	name VARCHAR(100)
);


-- 3
create schema sample;
-- mysqldump -u root example > /tmp/example.sql
-- sed -i 's/example/sample/g' /tmp/example.sql
-- mysql -u root sample < /tmp/example.sql

-- 4
-- mysqldump -u root mysql help_keyword --where="true limit 100" > /tmp/example2.sql



