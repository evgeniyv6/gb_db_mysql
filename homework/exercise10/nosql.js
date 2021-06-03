// exercise 1

SADD ip '192.168.3.1' '192.168.3.2'
SMEMBERS ip



// exercise 2
SET ann_mail@ya.ru ann 
SET john john_mail@ya.ru

GET ann_mail@ya.ru
GET john


// exercise 3

use prodpos
db.prodpos.insertMany([{"name": "Apple IPhone 11", "description": "Смартфон Apple 11", "price": "10000.00", "catalog_id": "Телефон", "created_at": new Date(), "updated_at": new Date()}, {"name": "Apple Mac Pro M1", "description": "Ноутбук Apple M1", "price": "150000.00", "catalog_id": "Ноутбук", "created_at": new Date(), "updated_at": new Date()}])

use catalog
db.catalog.insertMany([{"name": "Телефон"}, {"name": "Ноутбук"}])