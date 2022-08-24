-- GRADED QUES II

-- Busiest Actor
-- Description
-- Write a query to find the full name of the actor who has acted in the maximum number of movies.
-- Sample Output
	-- Full_name
	-- PENELOPE GUINESS
use upgrad;
# Write your code below
select concat(first_name,' ',last_name) as Full_name
from actor 
where actor_id = (
    select actor_id from film_actor
    group by actor_id
    order by count(*) desc
    limit 1
);


-- Third most Busy Actor
-- Description
-- Write a query to find the full name of the actor who has acted in the third most number of movies.
-- Sample Output
	-- Actor_name
	-- PENELOPE GUINESS
use upgrad;
# Write your code below
select concat(first_name,' ',last_name) as Actor_name
from actor 
where actor_id = (
    select actor_id from film_actor
    group by actor_id
    order by count(*) desc
    limit 2,1
);
    

-- Highest Grossing Film
-- Description
-- Write a query to find the film which grossed the highest revenue for the video renting organisation.
-- Sample Output
	-- title
	-- ACADEMY DINOSAUR
use upgrad;
# Write your code below
select title from film
where film_id = (
    select film_id from inventory
    where inventory_id = (
        select inventory_id from rental 
        where rental_id = (
            select rental_id from payment
            group by rental_id
            order by sum(amount) desc
            limit 1
        )
    )
);


-- GRADED QUES III
-- Film-obsessed City
-- Description
-- Write a query to find the city which generated the maximum revenue for the organisation.
-- Sample Output
	-- city
	-- Abu Dhabi
use upgrad;
# Write your code below
select city from city
where city_id = (
    select city_id from address
    where address_id = (
        select address_id from customer
        where customer_id = (
            select customer_id from payment
            group by customer_id
            order by sum(amount) desc
            limit 1
        )
    )
);


-- GRADED QUES IV

-- Analysis of Movie Categories
-- Description
-- Write a query to find out how many times a particular movie category is rented. Arrange these categories in the decreasing order of the number of times they are rented.
use upgrad;
# Write your code below
select name, count(rental_id) as Rental_count 
from rental
inner join inventory using (inventory_id)
inner join film_category using (film_id)
inner join category using (category_id)
group by name
order by Rental_count desc;


-- Science Fiction Enthusiasts
-- Description
-- Write a query to find the full names of customers who have rented sci-fi movies more than 2 times. Arrange these names in the alphabetical order.
use upgrad;
select concat(first_name,' ',last_name) as Customer_name
from category
inner join film_category using (category_id)
inner join film using (film_id)
inner join inventory using (film_id)
inner join rental using (inventory_id)
inner join customer using (customer_id)
where name = 'Sci-Fi'
group by Customer_name
having count(rental_id)>2
order by Customer_name;



-- GRADED QUES V

-- Movie Fans from Arlington
-- Description
-- Write a query to find the full names of those customers who have rented at least one movie and belong to the city Arlington.
use upgrad;
# Write your code below
select concat(first_name,' ',last_name) as Customer_name 
from rental
inner join customer using (customer_id)
inner join address using (address_id)
inner join city using (city_id)
where city='Arlington'
group by Customer_name
having count(rental_id)>0
;

-- Country-wise Analysis of Movies
-- Description
-- Write a query to find the number of movies rented across each country. Display only those countries where at least one movie was rented. Arrange these countries in the alphabetical order.
use upgrad;
# Write your code below
select country, count(rental_id) as Rental_count 
from rental
inner join customer using (customer_id)
inner join address using (address_id)
inner join city using (city_id)
inner join country using (country_id)
group by country
having Rental_count>0
order by country
;
