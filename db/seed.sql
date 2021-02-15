SELECT * 
FROM invoice i 
JOIN invoice_line il 
on il.invoice_id = i.invoice_id
WHERE il.unit_price > 0.99;

SELECT i.invoice_date, c.first_name, c.last_name, i.total
FROM invoice i
JOIN customer c 
ON i.customer_id = c.customer_id;

SELECT c.first_name, c.last_name, e.first_name, e.last_name
FROM customer c
JOIN employee e 
ON c.support_rep_id = e.employee_id;

SELECT al.title, ar.name
FROM album al
JOIN artist ar
ON al.artist_id = ar.artist_id;

SELECT pt.playlist_track_id
FROM playlist_track pt
JOIN playlist p
ON pt.playlist_id =p.playlist_id
WHERE p.name = 'Music';

SELECT t.name
FROM track t
JOIN playlist_track pt
ON t.track_id = pt.track_id
WHERE pt.playlist_id = 5; 

SELECT t.name, p.name
FROM track t
JOIN playlist_track pt
ON t.track_id = pt.track_id
JOIN playlist p
ON pt.playlist_id = p.playlist_id;

SELECT t.name, al.title
FROM track t
JOIN genre g
ON g.genre_id = t.genre_id
JOIN album al
ON t.album_id = al.album_id
WHERE g.name = 'Alternative & Punk';

-- PRACTICE NESTED QUERIES

SELECT * 
FROM invoice
WHERE invoice_id IN(
    SELECT invoice_id
    FROM invoice_line
    WHERE unit_price > 0.99
);

SELECT * 
FROM playlist_track
WHERE playlist_id IN(
    SELECT playlist_id
    FROM playlist
    WHERE name = 'Music'
);

SELET name
FROM track
WHERE track_id IN(
    SELECT track_id
    FROM playlist_track
    WHERE playlist_id = 5
);

SELECT *
FROM track
WHERE genre_id IN(
    SELECT genre_id
    FROM genre
    WHERE name = 'Comedy'
);

SELECT * 
FROM track
WHERE album_id IN(
    SELECT album_id
    FROM album
    WHERE title = 'Fireball'
);

SELECT *
FROM track 
WHERE album_id IN(
    SELECT album_id
    FROM album
    WHERE artist_id IN(
        SELECT artist_id
        FROM artist 
        WHERE name = 'Queen'
    )
);

-- PRACTICE UPDATING ROWS

UPDATE customer
SET fax = null
WHERE fax IS NOT null;

UPDATE customer
SET company = 'Self'
WHERE company IS null; 

UPDATE customer
SET last_name = 'Thompson'
WHERE first_name = 'Julia' AND last_name = 'Barnett';

UPDATE customer 
SET support_rep_id = 4
WHERE email = 'luisrojas@yahoo.cl';

UPdate track
SET composer = 'The darkness around us'
WHERE genre_id = (
    SELECT genre_id
    FROM genre
    WHERE name = 'Metal'
)
AND composer IS null;

-- GROUP BY

SELECT COUNT(*), g.name
FROM track t
JOIN genre g
ON t.genre_id = g.genre_id
GROUP BY g.name;

SELECT COUNT (*), g.name
FROM track t
JOIN genre g
ON t.genre_id = g.genre_id
WHERE g.name = 'Pop' OR g.name = 'Rock'
GROUP BY g.name;

SELECT COUNT(*), ar.name
FROM artist ar
JOIN album al
ON ar.artist_id = al.artist_id
GROUP BY ar.name

-- USE DISTINCT

SELECT DISTINCT composer
FROM track;

SELECT DISTINCT billing_postal_code
FROM invoice;

SELECT DISTINCT company
FROM customer;

-- DELETE ROWS

DELETE FROM practice_delete 
WHERE type = bronze;

DELETE FROM practice_delete
WHERE type = silver;

DELETE FROM practice_delete
WHERE value = 150;

-- ECOMMERCE SIMULATION - NO HINTS

CREATE TABLE users(
    user_id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    email VARCHAR(50)
);

CREATE TABLE products(
    products_id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    price FLOAT
);

CREATE TABLE orders(
    order_id SERIAL PRIMARY KEY,
    product_number INTEGER,
    quantity INTEGER
);

INSERT INTO users
(name, email)
VALUES
('Bob', 'bob@email.com'),
('Tom', 'tom@email.com'),
('Rob', 'rob@email.com');

INSERT INTO products
(name, price)
VALUES
('product1', 1.50),
('product2', 2.50),
('product3', 3.50);

INSERT INTO orders
(product_number, quantity)
VALUES
(1, 3),
(2, 4),
(3, 5);

SELECT *
FROM products p
JOIN users u
ON u.user_id = p.products_id
JOIN orders o
ON u.user_id = o.order_id
WHERE user_id = 1;

SELECT * FROM orders;

SELECT SUM(p.price)
FROM orders o
JOIN products p
ON p.products_id = o.order_id
WHERE p.price * quantity;


