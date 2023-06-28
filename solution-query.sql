SELECT COUNT(i.film_id) FROM sakila.inventory as i
JOIN sakila.film as f
ON i.film_id = f.film_id
WHERE title = "Hunchback Impossible";

SELECT film_id, title, length
FROM sakila.film
WHERE length > (
    SELECT AVG(length)
    FROM sakila.film
)
ORDER BY length DESC;


SELECT first_name,last_name
FROM sakila.actor
WHERE actor_id IN (
  SELECT actor_id
  FROM sakila.film_actor
  WHERE film_id = (
    SELECT film_id
    FROM sakila.film
    WHERE title = 'Alone Trip'
  )
);

SELECT title FROM sakila.film
WHERE title like '%FAMILY%';


SELECT first_name, email
FROM customer as c
JOIN sakila.address as ad
ON ad.address_id = c.address_id
JOIN sakila.city as ci
ON ci.city_id = ad.city_id
WHERE country_id = (
  SELECT country_id
  FROM country
  WHERE country = 'Canada'
);


SELECT a.actor_id, a.first_name, a.last_name, COUNT(f.film_id) AS film_count
FROM actor AS a
JOIN film_actor AS fa ON a.actor_id = fa.actor_id
JOIN film AS f ON fa.film_id = f.film_id
GROUP BY a.actor_id, a.first_name, a.last_name
ORDER BY film_count DESC
LIMIT 1;


SELECT f.film_id,f.title
FROM sakila.film AS f
JOIN inventory AS i ON f.film_id = i.film_id
JOIN rental AS r ON i.inventory_id = r.inventory_id
JOIN payment AS p ON r.rental_id = p.rental_id
WHERE p.customer_id = (
	SELECT customer_id
	FROM payment
	GROUP BY customer_id
	ORDER BY SUM(amount) DESC
	LIMIT 1
    );
    
SELECT SUM(amount) as total_amount_spent, c.customer_id
FROM payment as p
JOIN sakila.customer as c
ON p.customer_id = c.customer_id
HAVING total_amount_spent > (
    SELECT AVG(amount)
    FROM payment
);



 
