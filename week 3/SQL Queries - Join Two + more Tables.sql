#1 Which actor has appeared in the most films
    
select actor_id,count(*) as count,first_name,last_name 
from sakila.film_actor a
join sakila.actor b using (actor_id)
group by actor_id
order by count desc
limit 1;

#2  Most active customer (the customer that has rented the most number of films
  
select count(*) as count ,first_name,last_name 
from sakila.rental a
join sakila.customer b using (customer_id)
group by first_name,last_name
order by count desc
limit 1;

#3 List number of films per category.

select b.name ,a.film_id,a.category_id ,count(*)as count
from sakila.film_category a
join sakila.category b using (category_id)
group by category_id;

#4 Display the first and last names, as well as the address, of each staff member.

select a.first_name,a.last_name, b.address
from staff as a 
join address as b using(address_id);

#5 get films titles where the film language is either English or italian,
# and whose titles starts with letter "M" , sorted by title descending.

select a.title, b.name
from film as a
join language as b using(language_id)
where name like 'English' or name like 'Italian'
having  a.title regexp '^M'
order by title desc;

#6 Display the total amount rung up by each staff member in August of 2005.

SELECT a.staff_id, sum(a.amount),b.first_name,b.last_name
from payment as a
join staff as b using (staff_id)
where payment_date between '2005-08-01' and '2005-08-31'
group by b.first_name,b.last_name;

#7 List each film and the number of actors who are listed for that film.

select a.actor_id,count(a.film_id) as count , b.title
from film_actor as a
left join film as b using (film_id)
group by film_id
order by count desc;

#8 Using the tables payment and customer and the JOIN command, 
#list the total paid by each customer. List the customers alphabetically by last name.

select b.first_name,b.last_name,sum(a.amount)
from payment as a
join customer as b using (customer_id)
group by customer_id
order by b.last_name;

#9 Write sql statement to check if you can find any actor who never particiapted in any film.
 
select a.actor_id, b.film_id
from actor as a
left join film_actor as b using (actor_id)
where film_id is null;

#10 get the addresses that has NO customers, and ends with the letter "e"

select a.address,a.address2, b.customer_id
from address as a
left join customer as b using (address_id)
where customer_id is null
having a.address regexp 'e$';

#11 what is the most rented film?
select * from rental;

select title,count(*) as count
from rental as a
join inventory as b using(inventory_id)
join film as c using (film_id)
group by title
order by count desc
limit 1;
---------------------------------------------------------------------------
# SQL Joins on multiple tables


#1 Write a query to display for each store its store ID, city, and country.
select a.store_id,c.city,d.country
from store as a
join address as b using(address_id)
join city as c using(city_id)
join country as d using(country_id);

#2 Write a query to display how much business, in dollars, each store brought in.

select c.store_id , sum(a.amount)
from payment as a  
left join staff as b using(staff_id)
left join store as c using(store_id)
group by 1;

#3 What is the average running time(length) of films by category?
 
select a.name,round(avg(c.length),2)
from category as a
left join film_category as b using(category_id)
left join film as c using (film_id)
group by 1;

#4 Which film categories are longest(length) (find Top 5)? (Hint: You can rely on question 3 output.)

select a.name,round(avg(c.length),2)
from category as a
left join film_category as b using(category_id)
left join film as c using (film_id)
group by 1
order by 2 desc
limit 5;

#5 Display the top 5 most frequently(number of times) rented movies in descending order.

select title,count(*) as count
from rental as a
join inventory as b using(inventory_id)
join film as c using (film_id)
group by title
order by count desc
limit 5;

#6 List the top five genres in gross revenue in descending order.

select e.name,sum(a.amount) as revenue
from payment as a
left join rental as b using(rental_id)
left join inventory as c using(inventory_id)
left join film_category as d using (film_id)
left join category as e using(category_id)
group by 1
order by 2 desc 
limit 5;

#7 Is "Academy Dinosaur" available for rent from Store 1?

select a.title, b. store_id
from film as a
left join inventory as b using(film_id)
where title like 'Academy Dinosaur'
having store_id = 1