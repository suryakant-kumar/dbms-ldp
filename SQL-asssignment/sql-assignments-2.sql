-- 1. Find out the number of documentaries with deleted scenes.
select count(distinct f.film_id) 
from film f
	join film_category fc using(film_id)
	join category c on fc.category_id = c.category_id
where c.name = 'Documentary' 
	and f.special_features Like '%Deleted Scenes%';

-- 2. find out the number of sci-fi movies rented by the store managed by Jon Stephens.
select count(*) 
from rental r
	join inventory i using (inventory_id)
    join film f on i.film_id = f.film_id
where staff_id = (
	select staff_id 
    from staff
    where staff.first_name = 'Jon' and staff.last_name = 'Stephens'
) and f.film_id in (
	select fc.film_id 
    from film_category fc
		join category c using(category_id)
	where c.name = 'sci-fi'
);

--  3. Find out the total sales from Animation movies.

select sum(p.amount) as total_sales
from payment p
	join rental r using(rental_id)
    join inventory i on r.inventory_id = i.inventory_id
    join film f on f.film_id = i.film_id
where f.film_id in (
	select fc.film_id 
    from film_category fc
		join category c using(category_id)
	where c.name = 'Animation'
);

-- 4. Find out the top 3 rented category of movies  by “PATRICIA JOHNSON”.

select ca.name category, count(all fc.category_id) rented_count
from film_category fc
	join category ca using (category_id)
	join film f on f.film_id = fc.film_id
	join inventory i on f.film_id = i.film_id
	join rental r on r.inventory_id = i.inventory_id
	join customer c on r.customer_id = c.customer_id
where c.first_name = 'PATRICIA' and c.last_name = 'JOHNSON'
group by fc.category_id
order by count(*) desc
limit 3;

-- 5. Find out the number of R rated movies rented by “SUSAN WILSON”.

select count(all f.film_id) R_Rated_Movie
from film f
	join inventory i on f.film_id = i.film_id
	join rental r on r.inventory_id = i.inventory_id
	join customer c on r.customer_id = c.customer_id
where c.first_name = 'SUSAN' and c.last_name = 'WILSON' and f.rating = 'R'
group by f.rating