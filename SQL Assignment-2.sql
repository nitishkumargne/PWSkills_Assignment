use sakila;
-- Q.1)--Retrieve the total number of rentals made in the Sakila database. 
-- Hint: Use the COUNT() function. 
select count(rental_id) as number_of_rental from rental;
-- Q.2)--Find the average rental duration (in days) of movies rented from the Sakila database.
-- Hint: Utilize the AVG() function.
select avg(datediff(return_date,rental_date)) as average_rental_duration from rental;
-- Q.3)--Display the first name and last name of customers in uppercase. 
-- Hint: Use the UPPER () function.
select upper(first_name) as upperfirstname, upper(last_name) as upperlastname from customer;
-- Q.4)--Extract the month from the rental date and display it alongside the rental ID. 
-- Hint: Employ the MONTH() function. 
select rental_id, month(rental_date) as rental_month from rental;
-- Q.5)--Retrieve the count of rentals for each customer (display customer ID and the count of rentals). 
-- Hint: Use COUNT () in conjunction with GROUP BY.
select customer_id, count(rental_id) as Count_of_rental from rental group by customer_id;
-- Q.6)--Find the total revenue generated by each store. 
-- Hint: Combine SUM() and GROUP BY.
SELECT s.store_id, SUM(p.amount) AS total_revenue
FROM store s
JOIN staff st ON s.store_id = st.store_id
JOIN payment p ON st.staff_id = p.staff_id
GROUP BY s.store_id;
-- Q.7)--Display the title of the movie, customer s first name, and last name who rented it. 
-- Hint: Use JOIN between the film, inventory, rental, and customer tables. 
select f.title as title_of_the_movie, c.first_name, c.last_name from film f
join inventory i on f.film_id=i.film_id
join rental r on i.inventory_id=r.inventory_id
join customer c on r.customer_id=c.customer_id;
-- Q.8)--Retrieve the names of all actors who have appeared in the film "Gone with the Wind." 
-- Hint: Use JOIN between the film actor, film, and actor tables.
select a.first_name,a.last_name from actor a
join film_actor fa on a.actor_id=fa.actor_id
join film f on fa.film_id=f.film_id where f.title= 'Gone with the Wind';
---getting empty result, there is no movie with name 'Gone with the Wind'.

------------********------------
GROUP BY:
-- Q.1)--Determine the total number of rentals for each category of movies. 
--Hint: JOIN film_category, film, and rental tables, then use cOUNT () and GROUP BY.
select fc.category_id,count(rental_id) from rental r
join inventory i on r.inventory_id=i.inventory_id
join film_category fc on i.film_id=fc.film_id 
join film f on fc.film_id=f.film_id
Group by fc.category_id;
-- Q.2)--Find the average rental rate of movies in each language. 
-- Hint: JOIN film and language tables, then use AVG () and GROUP BY.
select l.name as language, avg(f.rental_rate) as average_rental_rate  from film f
join language l on f.language_id=l.language_id group by l.language_id;
-- Q.3)--Retrieve the customer names along with the total amount they've spent on rentals. 
-- Hint: JOIN customer, payment, and rental tables, then use SUM() and GROUP BY. 
select c.first_name,c.last_name,sum(p.amount) from customer c
join payment p on c.customer_id=p.customer_id
join rental r on p.customer_id=r.customer_id group by c.customer_id;
-- Q.4)--List the titles of movies rented by each customer in a particular city (e.g., 'London'). 
-- Hint: JOIN customer, address, city, rental, inventory, and film tables, then use GROUP BY. 
select f.title as movie_name,c.first_name,c.last_name from customer c
join address a on c.address_id=a.address_id
join city ci on a.city_id=ci.city_id
join rental r on c.customer_id=r.customer_id
join inventory i on r.inventory_id=i.inventory_id
join film f on i.film_id=f.film_id
WHERE ci.city = 'London'ORDER BY c.first_name, c.last_name, f.title;
-- Q.5)--Display the top 5 rented movies along with the number of times they've been rented. 
-- Hint: JOIN film, inventory, and rental tables, then use cOUNT() and GROUP BY, and limit the results.
SELECT f.title AS movie_title, COUNT(*) AS rental_count
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY f.title
ORDER BY rental_count DESC
LIMIT 5;
-- Q.6)--Determine the customers who have rented movies from both stores (store ID 1 and store ID 2). 
-- Hint: Use JOINS with rental, inventory, and customer tables and consider COUNT() and GROUP BY. 
SELECT c.customer_id, c.first_name, c.last_name
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN store s ON i.store_id = s.store_id
WHERE s.store_id IN (1, 2)
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING COUNT(DISTINCT s.store_id)=2;















