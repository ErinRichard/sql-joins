-- INNER JOIN on the actor and film_actor tables
-- film_id only available in film_actor table, so actor table referenced first below
-- results in list with duplicate names (see below for deduped list)
-- in SELECT below actor_id is in both actor and film_actor tables, so we need to specify which table we want to pull from in the SELECT stmt using table.column_name
SELECT actor.actor_id, first_name, last_name, film_id
FROM actor
INNER JOIN film_actor
ON actor.actor_id = film_actor.actor_id;

-- deduped list from above
SELECT actor.actor_id, first_name, last_name, COUNT(film_id)
FROM actor
INNER JOIN film_actor
ON actor.actor_id = film_actor.actor_id
GROUP BY actor.actor_id 
ORDER by actor.actor_id DESC;


-- LEFT JOIN on customer table and payment table
SELECT first_name, last_name, email, rental_id, amount, payment_date
FROM customer
LEFT JOIN payment
ON customer.customer_id = payment.customer_id;


-- Finding customers that have a country of 'Angola'
-- Below is an example of how to do this in multiple steps, but next he'll show us how to do this with a join without going through multiple steps
-- First select all to see country table to find country_id for Angola (which is 4)
SELECT *
FROM country;

-- Here we see that there are two cities (city_id 67 and 360) with country_id 4 (for Angola)
SELECT *
FROM city
ORDER BY country_id ASC;

-- Can grab the address_id and search for it in the customer table to find the customer
SELECT *
FROM address
WHERE city_id = 67;

SELECT *
FROM customer
WHERE address_id = 534;


-- Full Join that will produce info about a customer
-- Using Join to produce the same results as the multi-step process above
-- From the country of Angola
-- "multi-join" example
-- if multiple tables have the same column names, they can be joined
SELECT customer.first_name, customer.last_name, customer.email, country
FROM customer
FULL JOIN address
ON customer.address_id = address.address_id
FULL JOIN city
ON address.city_id = city.city_id
FULL JOIN country
ON city.country_id = country.country_id
WHERE country = 'Angola';


-- Additional Example of RIGHT JOIN
-- Find the amount of staff members we have
SELECT COUNT(staff_id), store.store_id
FROM staff
RIGHT JOIN store
ON staff.store_id = store.store_id
GROUP BY store.store_id;


-- Additional Example of FULL JOIN (multi-join)
-- see titles, descriptions, ratings, rental_date of movies and which store_id has them
SELECT title, description, rating, store_id, rental_date
FROM film
FULL JOIN inventory
ON film.film_id = inventory.film_id
FULL JOIN rental
ON inventory.inventory_id = rental.inventory_id


-- A subquery is a query within a query 
-- Subqueries allow us to run two queries at once without having to write them separately 
-- Basic Subquery
-- Inner query runs first, then pushes results to the outer query, so:
-- All customers that have an amount > 175 are pulled first, then those are pushe to the outer query
SELECT *
FROM customer
WHERE customer_id IN(
	SELECT customer_id
	FROM payment
	GROUP BY customer_id
	HAVING SUM(amount) > 175
	ORDER BY SUM(amount) DESC
);


-- Find all films with a language of 'English'
SELECT *
FROM film
WHERE language_id IN (
	SELECT language_id
	FROM language
	WHERE name = 'English'
);
