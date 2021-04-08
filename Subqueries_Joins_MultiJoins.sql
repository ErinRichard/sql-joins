-- Inner Join on the Actor and Film_Actor Table
SELECT actor.actor_id, first_name,last_name,film_id
FROM film_actor
INNER JOIN actor
ON actor.actor_id = film_actor.actor_id;

-- Left Join on the Actor and Film_Actor Table
SELECT actor.actor_id, first_name,last_name,film_id
FROM film_actor
LEFT JOIN actor
ON actor.actor_id = film_actor.actor_id
WHERE first_name IS NULL AND last_name IS NULL;

-- Join that will produce info about a customer
-- From the country of Angola
SELECT customer.first_name,customer.last_name,customer.email,country
FROM customer
FULL JOIN address
ON customer.address_id = address.address_id
FULL JOIN city
ON address.city_id = city.city_id
FULL JOIN country
ON city.country_id = country.country_id
WHERE country = 'Angola';



-- SubQuery Examples

-- Two queries split apart (which will become a subquery later)

-- Find a customer_id that has a amount greater
-- Than 175 in total payments
SELECT customer_id
FROM payment
GROUP BY customer_id
HAVING SUM(amount) > 175
ORDER BY SUM(amount) DESC;

-- Find ALL customer info
SELECT *
FROM customer;

-- Subquery to find the 6 customers that have
-- A total amount of payments greater than 175

SELECT store_id,first_name,last_name
FROM customer
WHERE customer_id IN (
	SELECT customer_id
	FROM payment
	GROUP BY customer_id
	HAVING SUM(amount) > 175
	ORDER BY SUM(amount) DESC
)
GROUP BY store_id,first_name,last_name;

SELECT store_id,first_name,last_name,address
FROM customer
INNER JOIN address
ON customer.address_id = address.address_id
INNER JOIN city
ON address.city_id = city.city_id
INNER JOIN country
ON city.country_id = country.country_id
WHERE country = 'Angola' AND customer_id IN (
	SELECT customer_id
	FROM payment
	GROUP BY customer_id
	HAVING SUM(amount) > 175
	ORDER BY SUM(amount) DESC
);

-- Basic Subquery
SELECT *
FROM customer
WHERE customer_id IN (
	SELECT customer_id
	FROM payment
	GROUP BY customer_id
	HAVING SUM(amount) > 175
	ORDER BY SUM(amount) DESC
);

-- Basic Subquery 
-- Find all films with a language of 'English'

SELECT *
FROM film
WHERE language_id IN (
	SELECT language_id
	FROM language
	WHERE name = 'English'
);