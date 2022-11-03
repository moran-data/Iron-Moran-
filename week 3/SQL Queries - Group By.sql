#1

select last_name from(
select  last_name, count(*)as count
from actor
group by 1) a
where count = 1;

#2 

select last_name from(
select  last_name, count(*)as count
from actor
group by 1) a
where count <> 1;

#3 

select staff_id,count(*)
from rental
group by 1;

#4

select rating , count(*)
from film
group by 1;

#5 
select rating , round(avg(length),2)
from film
group by 1;

#6 
select rating from(
select rating , round(avg(length),2)as avg_length
from film
group by 1)a
where avg_length > 120
