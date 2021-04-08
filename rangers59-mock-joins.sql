-- Customer Table for Presidents
CREATE TABLE customer(
	customer_id SERIAL PRIMARY KEY,
	first_name VARCHAR(100),
	last_name VARCHAR(100),
	email VARCHAR(200),
	address VARCHAR(150),
	city VARCHAR(150),
	customer_state VARCHAR(100),
	zipcode VARCHAR(50)
);

-- Orders Table for Presidents
CREATE TABLE order_(
	order_id SERIAL PRIMARY KEY,
	order_date DATE DEFAULT CURRENT_DATE,
	amount NUMERIC(5,2),
	customer_id INTEGER,
	FOREIGN KEY(customer_id) REFERENCES customer(customer_id)
);

INSERT INTO customer(customer_id,first_name,last_name,email,address,city,customer_state,zipcode)
VALUES(1,'George','Washington','gwash@usa.gov', '3200 Mt Vernon Hwy', 'Mt Vernon', 'VA', '22121');

INSERT INTO customer(customer_id,first_name,last_name,email,address,city,customer_state,zipcode)
VALUES(2,'John','Adams','jadams@usa.gov','1200 Hancock', 'Quincy', 'MA','02169');

INSERT INTO customer(customer_id,first_name,last_name,email,address,city,customer_state,zipcode)
VALUES(3,'Thomas','Jefferson', 'tjeff@usa.gov', '931 Thomas Jefferson Pkway', 'Charlottesville','VA','02169');

INSERt INTO customer(customer_id,first_name,last_name,email,address,city,customer_state,zipcode)
VALUES(4,'James','Madison', 'jmad@usa.gov', '11350 Conway','Orange','VA','02169');

INSERT INTO customer(customer_id,first_name,last_name,email,address,city,customer_state,zipcode)
VALUES(5,'James','Monroe','jmonroe@usa.gov','2050 James Monroe Parkway','Charlottesville','VA','02169');

-- INSERT INFO INTO ORDERS TABLE

INSERT INTO order_(order_id,amount,customer_id)
VALUES(1,234.56,1);

INSERT INTO order_(order_id,amount,customer_id)
VALUES(2,78.50,3);

INSERT INTO order_(order_id,amount,customer_id)
VALUES(3,124.00,2);

INSERT INTO order_(order_id,amount,customer_id)
VALUES(4,65.50,3);

INSERT INTO order_(order_id,amount,customer_id)
VALUES(5,55.50,NULL);

SELECT *
FROM order_;

SELECT *
FROM customer;


-- SQL JOINS

-- INNER JOIN
-- Grabs the 'intersection data' - returns data that's in both Table A (customer) and Table B (order_)
-- Gives access to the customer info and some of the order info
-- Some repeats because they show up twice in both A and B
-- The ON clause specifies a join condition
SELECT first_name, last_name, order_date, amount
FROM customer
INNER JOIN order_
ON customer.customer_id = order_.customer_id

-- LEFT JOIN
-- Info that only gives us names and only some of the order info, but not all
SELECT first_name, last_name, order_date, amount
FROM customer
LEFT JOIN order_
ON customer.customer_id = order_.customer_id;

-- LEFT JOIN without NULL values
SELECT first_name, last_name, order_date, amount
FROM customer
LEFT JOIN order_
ON customer.customer_id = order_.customer_id
WHERE order_date IS NOT NULL;


-- LEFT JOIN with NULL values (results in data that's in Table A ony - left side only)
SELECT first_name, last_name, order_date, amount
FROM customer
LEFT JOIN order_
ON customer.customer_id = order_.customer_id
WHERE order_date IS NULL;


-- RIGHT JOIN
-- pulls everything on the right plus any intersection data between A and B
-- null in row 5 is maybe an order that was placed by someone who never signed up for an account or maybe an abandoned order
-- Possible use case example- pull orders that have been placed by people who don't have accounts (see RIGHT JOIN for empty values below)
SELECT first_name, last_name, order_date, amount
FROM customer
RIGHT JOIN order_
ON customer.customer_id = order_.customer_id;

-- RIGHT JOIN for empty valus on the customer side
-- returns just the names that are empty
SELECT first_name, last_name, order_date, amount
FROM customer
RIGHT JOIN order_
ON customer.customer_id = order_.customer_id
WHERE first_name IS NULL;


-- FULL JOIN
-- returns everything that intersects in both tables, plus everything else in A and everything else in B
-- use-case example: head of mktg may want to see who purchased recently, and if so, do we have their contact info...
-- and if someone ordered, but did not create an account, anything that explains why didn't they create an account?
SELECT first_name, last_name, order_date, amount
FROM customer
FULL JOIN order_
ON customer.customer_id = order_.customer_id;