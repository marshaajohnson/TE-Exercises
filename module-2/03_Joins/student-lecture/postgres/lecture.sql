-- ********* INNER JOIN ***********

-- Let's find out who made payment 16666:
SELECT *
FROM payment
WHERE payment_id = 16666;

SELECT *
FROM customer
WHERE customer_id = 204;

-- Ok, that gives us a customer_id, but not the name. We can use the customer_id to get the name FROM the customer table

SELECT *
FROM payment
INNER JOIN customer ON payment.customer_id = customer.customer_id
WHERE payment_id = 16666;

-- We can see that the * pulls back everything from both tables. We just want everything from payment and then the first and last name of the customer:

SELECT payment.*, customer.first_name, customer.last_name
FROM payment
INNER JOIN customer ON payment.customer_id = customer.customer_id
WHERE PAYMENT_ID = 16666;

-- But when did they return the rental? Where would that data come from? From the rental table, so let’s join that.

SELECT payment.*, customer.first_name, customer.last_name
FROM payment
INNER JOIN customer ON payment.customer_id = customer.customer_id
INNER JOIN rental ON rental.rental_id = payment.rental_id
WHERE payment_id = 16666;

-- What did they rent? Film id can be gotten through inventory.

SELECT payment.*, customer.first_name, customer.last_name, rental.*
FROM payment
INNER JOIN customer ON customer.customer_id = payment.customer.id
INNER JOIN rental ON rental.rental_id = payment.rental_id
INNER JOIN inventory ON inventory.inventory_id = rental.inventory_id
INNER JOIN film ON film.film_id = inventory.film_id
WHERE payment_id = 16666;

-- What if we wanted to know who acted in that film?
SELECT actor.*, film.title
FROM film
INNER JOIN film_actor ON film.film_id = actor.actor_id
INNER JOIN actor ON film_actor.actor_id = actor.actor_id
WHERE film.title = 'VOICE PEACH';
-- What if we wanted a list of all the films and their categories ordered by film title

SELECT film.title, category.name
FROM film
INNER JOIN film.category ON tilm_cateogry.film_id = film.film_id
INNER JOIN category ON film_category.category_id = category.category_id
ORDER BY film.title ASC;

-- Show all the 'Comedy' films ordered by film title

SELECT film.title, cateogry.name
FROM film
INNER JOIN film.category ON tilm_cateogry.film_id = film.film_id
INNER JOIN category ON film_category.category_id = category.category_id
WHERE category_name = 'Comedy'
ORDER BY film.title ASC;

-- Finally, let's count the number of films under each category

SELECT c.name, COUNT(*)
FROM film_category film_category
JOIN category c ON c.category_id = fc.category_id
GROUP BY c.name;

-- ********* LEFT JOIN ***********

-- (There aren't any great examples of left joins in the "dvdstore" database, so the following queries are for the "world" database)

-- A Left join, selects all records from the "left" table and matches them with records from the "right" table if a matching record exists.

-- Let's display a list of all countries and their capitals, if they have some.

-- Only 232 rows
-- But we’re missing entries:

-- There are 239 countries. So how do we show them all even if they don’t have a capital?
-- That’s because if the rows don’t exist in both tables, we won’t show any information for it. If we want to show data FROM the left side table everytime, we can use a different join:

-- *********** UNION *************

-- Back to the "dvdstore" database...

-- Gathers a list of all first names used by actors and customers
-- By default removes duplicates

-- Gather the list, but this time note the source table with 'A' for actor and 'C' for customer
