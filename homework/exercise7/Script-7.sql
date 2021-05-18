SELECT u.name, o.id as order_id FROM orders o left join users u on o.user_id = u.id;

SELECT p.name, p.price, c.id, c.name from products p join catalogs c on  p.catalog_id = c.id;

SELECT (SELECT name from cities where label = `from`) from_label, 
(SELECT name from cities where label = `to`) to_label from flights;