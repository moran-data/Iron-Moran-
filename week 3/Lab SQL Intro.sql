#3 Select one column from a table. Get film titles.
SELECT title FROM sakila.filmstaff;

#4 Select one column from a table and alias it
SELECT description  as des  FROM film;

#4 Get unique list of film languages under the alias language
SELECT DISTINCT name  FROM sakila.language;

#5 5.1 Find out how many stores does the company have?

SELECT * FROM  sakila.store;

# 5.2 Find out how many employees staff does the company have?
SELECT * FROM  sakila.staff;

# 5.3 Return a list of employee first names only?
SELECT first_name FROM  sakila.staff;




