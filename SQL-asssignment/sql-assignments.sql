--  1) Find out the PG-13 rated comedy movies. DO NOT use the film_list table.
select f.title
from film f
	join film_category fc 
		on f.film_id = fc.film_id
    join category c
		using (category_id)
where f.rating = "pg-13" and c.name = 'comedy';



-- 2) Find out the top 3 rented horror movies.
select f.title, count(f.title) total_rented
from film f
	join inventory i on i.film_id = f.film_id
    join rental r on r.inventory_id = i.inventory_id
    join film_category fc on f.film_id = fc.film_id
    join category c using (category_id)
where c.name = 'horror'
group by f.title
order by total_rented desc
limit 3;



-- 3) Find out the list of customers from India who have rented sports movies.

select c.first_name, c.last_name
from customer c
where c.customer_id in (
	select r.customer_id
	from rental r
		join inventory i using (inventory_id)
		join film f on f.film_id = i.film_id
		join film_category fc on f.film_id = fc.film_id
		join category c on fc.category_id = c.category_id
	where c.name = "sports" 
) and c.address_id in (
	select a.address_id 
    from address a
		join city c using (city_id)
        join country co on co.country_id = c.country_id
     where co.country = "india"   
);

-- or
select c.first_name, c.last_name
from customer c
    join address a using (address_id)
    join city ci on ci.city_id = a.city_id
	join country co on co.country_id = ci.country_id
where c.customer_id in (
	select r.customer_id
	from rental r
		join inventory i using (inventory_id)
		join film f on f.film_id = i.film_id
		join film_category fc on f.film_id = fc.film_id
		join category c on fc.category_id = c.category_id
	where c.name = "sports" 
) and co.country = "india";
   
   
   
   
 -- 4) Find out the list of customers from Canada who have rented “NICK WAHLBERG” movies.  
 select c.first_name, c.last_name
from customer c
    join address a using (address_id)
    join city ci on ci.city_id = a.city_id
	join country co on co.country_id = ci.country_id
where c.customer_id in (
	select r.customer_id
	from rental r
		join inventory i using (inventory_id)
		join film f on f.film_id = i.film_id
		join film_actor fa on f.film_id = fa.film_id
		join actor a on fa.actor_id = a.actor_id
	where a.first_name = "NICK" and a.last_name = "WAHLBERG"
) and co.country = "canada";



-- 5) Find out the number of movies in which “SEAN WILLIAMS” acted.
select count(*) from film f
where film_id in (
	select distinct fa.film_id 
    from film_actor fa
		join actor a using(actor_id)
    where a.first_name = "SEAN" and a.last_name = "WILLIAMS"    
);
