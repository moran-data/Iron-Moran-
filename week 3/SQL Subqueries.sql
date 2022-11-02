#1 List all films whose length is longer than the average of all the films.

select title 
from film 
where length > (select avg(length) from film);

#2 How many copies of the film Hunchback Impossible exist in the inventory system?

select count(*) as count from inventory 
where film_id in(
select film_id 
from film
where title = 'Hunchback Impossible' );

#3 Use subqueries to display all actors who appear in the film Alone Trip.
select first_name,last_name
from actor 
where actor_id in(
select actor_id from film_actor
where film_id in (
select film_id 
from film 
where title='Alone Trip')) ;

#4 Sales have been lagging among young families, 
# and you wish to target all family movies for a promotion. Identify all movies categorized as family films.


select title 
from film 
where film_id in(
select film_id 
from film_category
where category_id in(
(select category_id 
from category  
where name like'family')));

#5 Get name and email from customers from Canada using subqueries. Do the same with joins. Note that to create a join, 
# you will have to identify the correct tables with their 
# primary keys and foreign keys, that will help you get the relevant information.

select * from address;
select * from city;


select first_name,last_name, email
from customer 
where address_id in(
select address_id
from address 
where city_id in(
select city_id 
from city
where country_id in(
(select country_id 
from country
where country like 'Canada'))));


select c.first_name,c.last_name, c.email from country 
left join  city as a using(country_id)
left join address as b using(city_id)
left join customer as c using(address_id)
where country like 'Canada' and first_name <> ' '; 



# 6 Which are films starred by the most prolific actor? Most prolific actor is defined as the actor 
# that has acted in the most number of films.
# First you will have to find the most prolific actor and then use that 
# actor_id to find the different films that he/she starred.

select title 
from film 
where film_id in(
select film_id 
from film_actor 
where actor_id in(
select actor_id from(
select actor_id, count(actor_id)as count
from film_actor
group by 1
order by 2 desc 
limit 1) as a) );

#7 Films rented by most profitable customer. You can use the customer 
# table and payment table to find the most profitable customer ie the customer that has made the largest sum of payments

select title 
from film 
where film_id in( 
select film_id 
from inventory
where inventory_id in(
select inventory_id 
from rental 
where rental_id in(
select rental_id 
from rental
where customer_id in(
select customer_id from (
select customer_id , sum(amount)
from payment
group by 1
order by 2 desc
limit 1)as a))));

#8  Customers who spent more than the average payments(this refers to the average of all amount spent per each customer).

select first_name,last_name 
from customer
where customer_id in(
select customer_id from (
select customer_id, sum(amount) as sum
from payment
group by 1 
having sum(amount)>
(select avg(sum)as mean from(
select customer_id, sum(amount) as sum
from payment
group by 1)as a))as b)
order by 1 asc

