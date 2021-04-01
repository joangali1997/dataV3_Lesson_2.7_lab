# Lab | SQL Join (Part I)
USE sakila;


# 1. How many films are there for each of the categories in the category table. Use appropriate join to write this query.
SELECT * FROM sakila.film_category;
SELECT * FROM sakila.film;

SELECT c.category_id, COUNT(film_id)
FROM sakila.film_category c
JOIN sakila.film f
USING (film_id)
GROUP BY c.category_id;


# 2. Display the total amount rung up by each staff member in August of 2005.
SELECT * FROM sakila.rental;

SELECT r.staff_id, COUNT(r.rental_id)
FROM sakila.rental r
JOIN sakila.staff s
USING (staff_id)
WHERE convert(r.rental_date,DATE) BETWEEN '2005-08-01' AND '2005-08-30'
GROUP BY r.staff_id;


# 3. Which actor has appeared in the most films?
SELECT * FROM sakila.film_actor;
SELECT * FROM sakila.actor;

SELECT first_name, last_name , COUNT(film_id) 
FROM sakila.film_actor fa
JOIN sakila.actor a
USING (actor_id)
GROUP BY first_name, last_name, actor_id
ORDER BY COUNT(film_id) DESC
LIMIT 1;
-- The actor that has appear to most films is an actress named 'Gina Degeneres'


# 4. Most active customer (the customer that has rented the most number of films)
SELECT * FROM sakila.customer;
SELECT * FROM sakila.rental;
SELECT * FROM sakila.inventory;

SELECT c.first_name, c.last_name, COUNT(DISTINCT i.film_id)
FROM sakila.customer c
JOIN sakila.rental r
USING (customer_id)
JOIN sakila.inventory i
USING (inventory_id)
WHERE c.active = '1'
GROUP BY first_name, last_name
ORDER BY COUNT(DISTINCT i.film_id) DESC
LIMIT 1;
-- The most active customer is Eleanor Hunt with 46 rented films.alter


# 5. Display the first and last names, as well as the address, of each staff member.
SELECT * FROM sakila.address;
SELECT * FROM sakila.staff;

SELECT DISTINCT s.staff_id, s.first_name, s.last_name, a.address
FROM sakila.address a
JOIN sakila.staff s
USING (address_id);


# 6. List each film and the number of actors who are listed for that film. 
SELECT f.title, COUNT(fa.actor_id)
FROM sakila.film f
JOIN sakila.film_actor fa
USING (film_id)
GROUP BY f.title;


# 7. Using the tables payment and customer and the JOIN command, list the total paid by each customer. List the customers alphabetically by last name.
SELECT * FROM sakila.payment;
SELECT * FROM sakila.customer;

SELECT last_name, SUM(amount)
FROM sakila.payment p
JOIN sakila.customer c
USING (customer_id)
GROUP BY last_name
ORDER BY last_name;


# 8. List number of films per category.
SELECT * FROM sakila.film_category;

SELECT ca.name, COUNT(film_id)
FROM sakila.film_category c
JOIN sakila.category ca
USING (category_id)
GROUP BY ca.name;
