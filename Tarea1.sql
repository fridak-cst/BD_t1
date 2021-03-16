-- 1 ¿Cómo obtenemos todos los nombres y correos de nuestros clientes canadienses para una campaña?
select concat(c.first_name, ' ', c.last_name), c.email from customer c
join address a using (address_id) 
join city ci using (city_id)
join country co using (country_id)
where co.country_id = 20;
-- 2 ¿Qué cliente ha rentado más de nuestra sección de adultos?
select concat(c.first_name, ' ', c.last_name), count(r.rental_id) as rentas from customer c
join rental r using (customer_id)
join inventory i using (inventory_id) 
join film f using (film_id) 
where f.rating = 'NC-17'
group by c.first_name, c.last_name order by count(r.rental_id) desc limit 5;
--(Ahi podemos ver que hay dos que tienen el mismo numero de rentas

-- 3 ¿Qué películas son las más rentadas en todas nuestras stores?
select f.title, s.store_id, count(r.rental_id) from film f
join inventory i using (film_id) 
join store s using (store_id)
join rental r using (inventory_id)
group by f.title, s.store_id 
order by count(r.rental_id) desc limit 10;

-- Película mas rentada por tienda
select i.store_id, f.title, count(i.film_id) from rental r 
join inventory i using (inventory_id)
join film f using (film_id)
group by f.film_id, i.store_id 
order by count(i.film_id) desc limit 2;

-- 4 ¿Cuál es nuestro revenue por store?
select s2.store_id, sum(amount) from store s2 
inner join staff s on s2.store_id = s.store_id
inner join payment p on p.staff_id = s.staff_id
group by s2.store_id order by sum(amount);