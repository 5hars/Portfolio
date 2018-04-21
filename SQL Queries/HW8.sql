USE Sakila;
-- 1a. 
SHOW TABLES FROM sakila;
SHOW columns FROM actor;
-- 1b. 
SELECT first_name, last_name FROM actor;

SELECT UPPER(CONCAT(first_name,' ', last_name)) AS actor_name
FROM actor;

-- 2a. 
SELECT first_name, last_name, actor_id 
FROM actor 
WHERE first_name = "JOE";

-- 2b. 
SELECT first_name, last_name 
FROM actor 
WHERE last_name LIKE "%GEN%";

-- 2c. 
SELECT actor_id, first_name, last_name
FROM actor 
WHERE last_name LIKE "%LI%"
ORDER BY last_name, first_name;

-- 2d. 
SELECT country_id, country FROM country WHERE country IN ("Afghanistan", "Bangladesh", "China");

-- 3a. 
ALTER TABLE actor
ADD COLUMN `middle_name` VARCHAR(45) NOT NULL AFTER `first_name`;
-- 3b. 

ALTER TABLE actor
CHANGE COLUMN 'middle_name' BLOB NOT NULL;
SHOW COLUMNS FROM actor;

-- 3c.
ALTER TABLE actor 
DROP COLUMN middle_name;
-- 4a. 
SELECT last_name FROM actor;
SELECT last_name, count(last_name) as count FROM actor GROUP BY last_name;
-- 4b. 
SELECT last_name, COUNT(last_name) AS counts
FROM actor
GROUP BY last_name
HAVING (counts > 1);
-- 4c. 
SELECT actor_id, first_name, last_name FROM actor where first_name = "GROUCHO" AND last_name = "WILLIAMS";
SELECT actor_id FROM actor where first_name = "GROUCHO" AND last_name = "WILLIAMS";
UPDATE actor SET `first_name` = "HARPO" 
	WHERE first_name = "GROUCHO" AND last_name = "WILLIAMS";
SELECT actor_id, first_name, last_name FROM actor where first_name = "HARPO" AND last_name = "WILLIAMS";
-- 4d. 
SELECT actor_id, first_name, last_name from actor where first_name = "HARPO";
UPDATE actor SET `first_name` = "GROUCHO" 
	WHERE actor_id = 172;
SELECT actor_id, first_name, last_name from actor where actor_id = 172;
-- 5a. 
SHOW CREATE TABLE address;
-- 6a. 
SELECT * FROM staff;
SELECT * FROM address;
SELECT first_name, last_name, address FROM staff INNER JOIN address ON staff.address_id = address.address_id;
-- 6b. 
SELECT * FROM staff;
SELECT * FROM payment;
SELECT first_name, last_name, payment_date, SUM(amount) AS total FROM staff INNER JOIN payment ON staff.staff_id = payment.staff_id 
WHERE payment_date LIKE "2005-08%" GROUP BY last_name;
-- 6c.
SELECT * FROM film;
SELECT * FROM film_actor;
SELECT title, count(actor_id) FROM film INNER JOIN film_actor ON film.film_id = film_actor.film_id GROUP BY title;

-- 6d. 
SELECT * FROM inventory;
SELECT * FROM film;

SELECT COUNT(inventory_id) FROM inventory INNER JOIN film ON film.film_id = inventory.film_id WHERE film.film_id IN
(SELECT film.film_id FROM film WHERE film.title = "HUNCHBACK IMPOSSIBLE");

SELECT film_id FROM film WHERE film.title = "HUNCHBACK IMPOSSIBLE";
SELECT * FROM inventory WHERE film_id = 439;
-- 6e. 
SELECT * FROM payment;
SELECT * FROM customer;

SELECT first_name, last_name, SUM(amount) AS Total_Paid FROM payment INNER JOIN customer
ON customer.customer_id = payment.customer_id GROUP BY last_name;

-- 7a. 
SELECT * FROM film;
SELECT * FROM language;

SELECT title FROM film
WHERE ((title LIKE "K%") OR (title LIKE "Q%")) AND title IN (
	SELECT title FROM film 
	WHERE language_id IN (
		SELECT language_id FROM language
		WHERE name = "English"));
-- 7b. 
SELECT * FROM film;
SELECT * FROM film_actor;

SELECT first_name, last_name FROM actor 
WHERE actor_id IN (
	SELECT actor_id FROM film_actor
    WHERE film_id IN (
		SELECT film_id FROM film 
        WHERE title = "ALONE TRIP"));
-- 7c. 
SELECT * FROM address;
SELECT * FROM city;
SELECT * FROM country;
SELECT * FROM customer;

SELECT first_name, last_name, address, email, country FROM 
(((address INNER JOIN customer ON address.address_id = customer.address_id)
INNER JOIN city ON address.city_id = city.city_id) 
INNER JOIN country ON country.country_id = city.country_id) WHERE country = "Canada";
-- 7d. 
SELECT * FROM film_category;
SELECT * FROM film;
SELECT * FROM category;

SELECT title FROM film
WHERE film_id IN (
	SELECT film_id FROM film_category
    WHERE category_id IN (
		SELECT category_id FROM category
        WHERE name = "Family"));
-- 7e.
SELECT title, COUNT(rental_id) AS count
FROM film f, inventory i, rental r
WHERE f.film_id = i.film_id
AND i.inventory_id = r.inventory_id
GROUP BY title
ORDER BY title DESC;

DROP TABLE IF EXISTS rented_value;      
CREATE TABLE rented_value( SELECT film_id,
	SUM((SELECT COUNT(inventory_id) 
    FROM rental
    WHERE rental.inventory_id = inventory.inventory_id)) AS total_rented
    FROM inventory GROUP BY film_id);
SELECT title, total_rented FROM rented_value INNER JOIN film ON rented_value.film_id = film.film_id 
	ORDER BY total_rented DESC;
-- 7f. 
SELECT * FROM inventory;
SELECT * FROM payment;
SELECT * FROM rental;

SELECT film_id, store_id, 
 	SUM((SELECT COUNT(rental_id) 
    FROM rental
    WHERE rental.inventory_id = inventory.inventory_id)) AS total_rented
    FROM inventory GROUP BY film_id;
    
select rental.rental_id, inventory_id, payment_id, sum(amount) 
	from rental inner join payment on rental.rental_id = payment.rental_id 
	group by inventory_id;
-- 7g. 
SELECT s.store_id, city, country
FROM store s, address a, city ci, country co
WHERE s.address_id = a.address_id
AND a.city_id = ci.city_id
AND ci.country_id = co.country_id;
-- 7h. 
SELECT c.name, concat ('$', format(SUM(amount), 2)) AS 'Gross Revenue' 
FROM category c, film_category fc, inventory i, rental r,  payment p
WHERE c.category_id = fc.category_id
AND fc.film_id = i.film_id
AND i.inventory_id = r.inventory_id
AND r.rental_id = p.rental_id
GROUP BY c.name
ORDER BY SUM(amount) DESC
LIMIT 5;
-- 8a.
CREATE VIEW view_8a AS
SELECT c.name, concat ('$', format(SUM(amount), 2)) AS 'Gross Revenue' 
FROM category c, film_category fc, inventory i, rental r,  payment p
WHERE c.category_id = fc.category_id
AND fc.film_id = i.film_id
AND i.inventory_id = r.inventory_id
AND r.rental_id = p.rental_id
GROUP BY c.name
ORDER BY SUM(amount) DESC
LIMIT 5;
-- 8b. How would you display the view that you created in 8a?
SELECT * FROM view_8a

-- 8c. You find that you no longer need the view top_five_genres. Write a query to delete it.

DROP VIEW view_8a
