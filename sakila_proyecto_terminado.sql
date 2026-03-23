-- =====================================
-- PROYECTO SQL
-- Base de datos: sakila_proyecto
-- =====================================

--Ejercicio 1
--Creación del esquema de la BBDD:
--Se creó la base de datos 'sakila_proyecto' y se ejecutó el script
--'BBDD_Proyecto_shakila_sinuser.sql'.

create database sakila_proyecto;

--Ejercicio 2.
--Muestra los nombres de todas las películas con una clasificación por edades de ‘R’.
select title
from film
where rating = 'R';

--Ejercicio 3
--Encuentra los nombres de los actores que tengan un “actor_id” entre 30 Y 40.
select first_name, last_name 
from actor
where actor_id between 30 and 40;

--Ejercicio 4
--Obtén las películas cuyo idioma coincide con el idioma original.
select f.film_id , f.title 
from film f 
where f.language_id = f.original_language_id;

--Ejercicio 5
--Ordena las películas por duración de forma ascendente.
select f.film_id , f.title , f.length 
from film f 
order by f.length asc;

--Ejercicio 6
--Encuentra el nombre y apellido de los actores que tengan ‘Allen’ en su apellido.
select a.first_name , a.last_name 
from actor a 
where a.last_name ilike 'Allen';

--Ejercicio 7
--Encuentra la cantidad total de películas en cada clasificación de la tabla “film” y muestra la clasificación junto con el recuento.
select f.rating , count(*) as total_peliculas
from film f 
group by f.rating
order by f.rating ;

--Ejercicio 8
--Encuentra el título de todas las películas que son ‘PG-13’ o tienen una duración mayor a 3 horas en la tabla film.
select f.rating , f.length , f.title 
from film f 
where f.rating = 'PG-13'
	or f.length > 180; 

--Ejercicio 9
--Encuentra la variabilidad de lo que costaría reemplazar las películas.
select variance(replacement_cost) as variabilidad_peliculas
from film f ; 

--Ejercicio 10
--Encuentra la mayor y menor duración de una película de nuestra BBDD.
select
MIN(length) as min_duracion , 
MAX(length) as max_duracion
from film f ; 

--Ejercicio 11
--Encuentra lo que costó el antepenúltimo alquiler ordenado por día.
select p.amount , p.payment_date 
from payment p 
order by p.payment_date desc 
offset 2
limit 1;

--Ejercicio 12
--Encuentra el título de las películas en la tabla “film” que no sean ni ‘NC-17’ ni ‘G’ en cuanto a su clasificación.
select f.title 
from film f 
where f.rating <> 'NC-17'
	and f.rating <> 'G' ; 

--Ejercicio 13
--Encuentra el promedio de duración de las películas para cada clasificación de la tabla film 
--Muestra la clasificación junto con el promedio de duración.
select f.rating , AVG("length") as promedio_duracion 
from film f 
group by f.rating ;

--Ejercicio 14
--Encuentra el título de todas las películas que tengan una duración mayor a 180 minutos.
select f.title , f.length 
from film f 
where f.length > 180;

-- Ejercicio 15
--¿Cuánto dinero ha generado la empresa?
select SUM("amount") as dinero_total_generado
from payment p ;

--Ejercicio 16
--Muestra los 10 clientes con mayor valor de id.
select c.customer_id , c.first_name , c.last_name 
from customer c 
order by c.customer_id desc 
limit 10 ; 

--Ejercicio 17
--Encuentra el nombre y apellido de los actores que aparecen en la película con título 'Egg Igby'
select a.first_name , a.last_name , f.title 
from film f 
join film_actor fa 
	on f.film_id = fa.film_id 
join actor a 
	on fa.actor_id = a.actor_id
where f.title ilike 'Egg Igby';

--Ejercicio 18 
--Selecciona todos los nombres de las películas únicos.
select distinct f.title 
from film f ; 

--Ejercicio 19 
--Encuentra el título de las películas que son comedias y tienen una duración mayor a 180 minutos en la tabla “film”.
select f.title , f.length , c."name" 
from film f 
join film_category fc 
	on f.film_id = fc.film_id 
join category c 
	on fc.film_id = c.category_id 
where c."name" ilike 'Comedy'
	and f.length > 180; 

--Ejercicio 20
--Encuentra las categorías de películas que tienen un promedio de duración superior a 110 minutos y muestra el nombre de la categoría
--junto con el promedio de duración
select c."name", AVG("length") as "promedio_duracion" 
from film f 
join film_category fc 
	on f.film_id = fc.film_id 
join category c 
	on fc.category_id = c.category_id
group by c."name" 
having AVG(f.length)> 110;

--Ejercicio 21
--¿Cuál es la media de duración del alquiler de las películas?
select AVG("rental_duration") as "media_duracion_alquiler"
from film f ;
	
--Ejercicio 22 
--Crea una columna con el nombre y apellidos de todos los actores y actrices.
select concat(a.first_name, ' ' ,a.last_name) as actores_actrices
from actor a ;

--Ejercicio 23
--Números de alquiler por día, ordenados por cantidad de alquiler de forma descendente.
select date(r.rental_date) as dia, count("rental_id") as cantidad_alquiler 
from rental r 
group by date(r.rental_date)
order by cantidad_alquiler desc;

--Ejercicio 24
--Encuentra las películas con una duración superior al promedio.
select f.title , f.length 
from film f 
where f.length > (
	select AVG(f2.length) 
	from film f2
);

--Ejercicio 25
--Averigua el número de alquileres registrados por mes.
select extract(month from rental_date) as mes,
	count(rental_id) as alquileres_mes
from rental r 
group by extract(month from rental_date)
order by mes; 

--Ejercicio 26
--Encuentra el promedio, la desviación estándar y varianza del total pagado.
select  
	AVG(p.amount) as promedio_total, 
	stddev(p.amount) as desv_total, 
	variance(p.amount) as varianza_total
from payment p ;

--Ejercicio 27
--¿Qué películas se alquilan por encima del precio medio?
select f.title , f.rental_rate
from film f 
where f.rental_rate > (
	select AVG("rental_rate") as promedio_alquiler
	from film
);

--Ejercicio 28
--Muestra el id de los actores que hayan participado en más de 40 películas.
select a.actor_id , concat(a.first_name ,' ', a.last_name) as nombre_apellido , count(fa.film_id) as total_peliculas
from actor a 
join film_actor fa 
	on a.actor_id = fa.actor_id
group by a.actor_id , concat(a.first_name , ' ', a.last_name) 
having count(fa.film_id) > 40;

--Ejercicio 29 
--Obtener todas las películas y, si están disponibles en el inventario, mostrar la cantidad disponible.
select f.film_id , f.title , count(i.inventory_id) as cantidad_disponible 
from film f 
left join inventory i 
	on f.film_id = i.film_id
group by f.film_id , f.title ;

--Ejercicio 30
--Obtener los actores y el número de películas en las que ha actuado.
select concat(first_name, ' ' , last_name) as nombre_completo ,
	count(fa.film_id) as total_peliculas
from actor a 
join film_actor fa 
	on a.actor_id = fa.actor_id 
group by a.actor_id , a.first_name , a.last_name ;

--Ejercicio 31
--Obtener todas las películas y mostrar los actores que han actuado en ellas, incluso si
--algunas películas no tienen actores asociados.
select f.title , concat(first_name, ' ' , last_name) as nombre_completo 
from film f 
left join film_actor fa 
	on f.film_id = fa.film_id 
left join actor a 
	on a.actor_id  = fa.actor_id  ; 

--Ejercicio 32
--Obtener todos los actores y mostrar las películas en las que han actuado,
--incluso si algunos actores no han actuado en ninguna película.
select concat(first_name, ' ' , last_name) as nombre_completo , f.title 
from actor a 
left join film_actor fa 
	on a.actor_id = fa.actor_id
left join film f 
	on fa.film_id = f.film_id ;

--Ejercicio 33
--Obtener todas las películas que tenemos y todos los registros de alquiler.
select f.title , r.rental_id 
from film f 
full join inventory i 
	on f.film_id = i.film_id
full join rental r 
	on i.inventory_id = r.inventory_id;

--Ejercicio 34
--Encuentra los 5 clientes que más dinero se hayan gastado con nosotros.
select 
	concat(first_name, ' ', last_name) as nombre_clientes ,
	sum(p.amount) as total_gastado 
from customer c 
join payment p 
	on c.customer_id = p.customer_id
group by nombre_clientes , c.customer_id 
order by total_gastado desc 
limit 5;

--Ejercicio 35
--Selecciona todos los actores cuyo primer nombre es 'Johnny'.
select a.first_name , a.last_name 
from actor a 
where a.first_name ilike 'Johnny' ;

--Ejercicio 36
--Renombra la columna “first_name” como Nombre y “last_name” como Apellido.
select first_name as Nombre , 
	a.last_name as Apellido 
from actor a ;

--Ejercicio 37
--Encuentra el ID del actor más bajo y más alto en la tabla actor.
select
	MIN(actor_id) as id_actor_bajo ,
	MAX(actor_id) as id_actor_alto 
from actor a ;

--Ejercicio 38
--Cuenta cuántos actores hay en la tabla “actor”.
select count(*) as total_actores
from actor a ;

--Ejercicio 39
--Selecciona todos los actores y ordénalos por apellido en orden ascendente.
select a.first_name , a.last_name 
from actor a 
order by a.last_name asc; 

--Ejercicio 40
--Selecciona las primeras 5 películas de la tabla “film”.
select f.title 
from film f 
limit 5;

--Ejercicio 41
--Agrupa los actores por su nombre y cuenta cuántos actores tienen el mismo nombre. 
--¿Cuál es el nombre más repetido?
select a.first_name , count(*) as nombre_actores 
from actor a 
group by a.first_name
order by nombre_actores desc
limit 1;

--Ejercicio 42
--Encuentra todos los alquileres y los nombres de los clientes que los realizaron.
select r.rental_id,
	rental_date,
	concat(c.first_name ,' ', c.last_name) as nombre_clientes
from rental r 
join customer c 
	on r.customer_id = c.customer_id;

--Ejercicio 43
--Muestra todos los clientes y sus alquileres si existen, incluyendo aquellos que no
--tienen alquileres.
select r.rental_id ,
	concat(first_name, ' ', last_name) as nombre_clientes
from customer c 
left join rental r 
	on c.customer_id = r.customer_id; 

--Ejercicio 44
--Realiza un CROSS JOIN entre las tablas film y category. ¿Aporta valor
--esta consulta? ¿Por qué? Deja después de la consulta la contestación.
select f.film_id , f.title , c.category_id , c."name" 
from film f 
cross join category c ; 
-- Esta consulta no aporta mucho valor en este caso, porque CROSS JOIN
-- genera todas las combinaciones posibles entre películas y categorías,
-- aunque no exista una relación real entre ellas. Para obtener las
-- categorías reales de cada película sería mejor usar la tabla puente
-- film_category.	

--Ejercicio 45
--Encuentra los actores que han participado en películas de la categoría 'Action'.
select 
    concat(a.first_name, ' ', a.last_name) AS nombre_actor,
    f.title,
    c.name
from actor a
join film_actor fa
    on a.actor_id = fa.actor_id
join film f
    on fa.film_id = f.film_id
join film_category fc
    on f.film_id = fc.film_id
join category c
    on fc.category_id = c.category_id
where c.name ilike 'Action';

--Ejercicio 46
--Encuentra todos los actores que no han participado en películas.
select
    concat(a.first_name, ' ', a.last_name) as nombre_actores,
    a.actor_id
from actor a
left join film_actor fa
    on a.actor_id = fa.actor_id
where fa.film_id is null;

--Ejercicio 47
--Selecciona el nombre de los actores y la cantidad de películas en las que han participado.
select 
    count(fa.film_id) as cantidad_peliculas,
    a.first_name,
    a.last_name
from actor a
join film_actor fa
    on a.actor_id = fa.actor_id
group by a.actor_id, a.first_name, a.last_name
order by cantidad_peliculas;

--Ejercicio 48
--Crea una vista llamada “actor_num_peliculas” que muestre los nombres de los actores 
--y el número de películas en las que han participado.
create view actor_num_peliculas as
select 
    count(fa.film_id) as cantidad_peliculas,
    concat(a.first_name, ' ', a.last_name) as nombre_actores
from actor a
join film_actor fa
    on a.actor_id = fa.actor_id
group by a.actor_id, a.first_name, a.last_name;

--Ejercicio 49
--Calcula el número total de alquileres realizados por cada cliente.
select 
    count(r.rental_id) as total_alquileres,
    concat(c.first_name, ' ', c.last_name) as cliente
from rental r
join customer c
    on r.customer_id = c.customer_id
group by c.customer_id, c.first_name, c.last_name;

--Ejercicio 50
--Calcula la duración total de las películas en la categoría 'Action'.
select sum(f.length) as duracion_peliculas
from film f
join film_category fc
    on f.film_id = fc.film_id
join category c
    on fc.category_id = c.category_id
where c.name ilike 'Action';

--Ejercicio 51
--Crea una tabla temporal llamada “cliente_rentas_temporal” para almacenar 
--el total de alquileres por cliente.
create temporary table cliente_rentas_temporal as
select 
    r.customer_id,
    count(r.rental_id) as total_alquileres
from rental r
group by r.customer_id; 

--Ejercicio 52
--Crea una tabla temporal llamada “peliculas_alquiladas” que almacene las películas 
--que han sido alquiladas al menos 10 veces.
create temporary table peliculas_alquiladas as
select 
    f.film_id,
    f.title,
    count(r.rental_id) as total_alquileres
from film f
join inventory i
    on f.film_id = i.film_id
join rental r
    on r.inventory_id = i.inventory_id
group by f.film_id, f.title
having count(r.rental_id) >= 10;

--Ejercicio 53 
--53. Encuentra el título de las películas que han sido alquiladas por el cliente
--con el nombre ‘Tammy Sanders’ y que aún no se han devuelto. Ordena los resultados 
--alfabéticamente por título de película.
select f.title
from customer c
join rental r
    on c.customer_id = r.customer_id
join inventory i
    on r.inventory_id = i.inventory_id
join film f
    on i.film_id = f.film_id
where c.first_name ilike 'Tammy'
  and c.last_name ilike 'Sanders'
  and r.return_date is null
order by f.title asc;

--Ejercicio 54
--Encuentra los nombres de los actores que han actuado en al menos una película 
--que pertenece a la categoría ‘Sci-Fi’. Ordena los resultados alfabéticamente por apellido.
select distinct a.first_name, a.last_name
from actor a
join film_actor fa
    on a.actor_id = fa.actor_id
join film f
    on fa.film_id = f.film_id
join film_category fc
    on f.film_id = fc.film_id
join category c
    on fc.category_id = c.category_id
where c.name ilike 'Sci-Fi'
order by a.last_name asc;

--Ejercicio 55
--Encuentra el nombre y apellido de los actores que han actuado en películas 
--que se alquilaron después de que la película ‘Spartacus Cheaper’ se alquilara 
--por primera vez. Ordena los resultados alfabéticamente por apellido.
select distinct a.first_name, a.last_name
from actor a
join film_actor fa
    on a.actor_id = fa.actor_id
join film f
    on fa.film_id = f.film_id
join inventory i
    on f.film_id = i.film_id
join rental r
    on i.inventory_id = r.inventory_id
where r.rental_date > (
    select MIN(r2.rental_date)
    from film f2
    join inventory i2
        on f2.film_id = i2.film_id
    join rental r2
        on i2.inventory_id = r2.inventory_id
    where f2.title ilike 'Spartacus Cheaper'
)
order by a.last_name asc;

--Ejercicio 56 
--Encuentra el nombre y apellido de los actores que no han actuado en ninguna película 
--de la categoría ‘Music’.
select a.first_name , a.last_name 
from actor a 
where not exists (
	select
	from film_actor fa
	join film f 
		on fa.film_id = f.film_id
	join film_category fc 
		on f.film_id = fc.film_id
	join category c 
		on fc.category_id = c.category_id
	where fa.actor_id = a.actor_id 
		and c."name" ilike 'Music'
);

--Ejercicio 57
--Encuentra el título de todas las películas que fueron alquiladas por más de 8 días.
select distinct f.title
from film f
join  inventory i
    on f.film_id = i.film_id
join rental r
    on i.inventory_id = r.inventory_id
where r.return_date is not null
  and r.return_date - r.rental_date > interval '8 days';

--Ejercicio 58
--Encuentra el título de todas las películas que son de la misma categoría
--que ‘Animation’.
select f.title
from film f
join film_category fc
    on f.film_id = fc.film_id
join category c
    on fc.category_id = c.category_id
where c.name ilike 'Animation';

--Ejercicio 59
--Encuentra los nombres de las películas que tienen la misma duración que la película 
--con el título ‘Dancing Fever’. Ordena los resultados alfabéticamente por título de película.
select f.title, f.length
from film f
where f.length = (
    select f2.length
    from film f2
    where f2.title ilike 'Dancing Fever'
)
order by f.title asc;

--Ejercicio 60
--Encuentra los nombres de los clientes que han alquilado al menos 7
--películas distintas. Ordena los resultados alfabéticamente por apellido.
select concat(c.first_name ,' ', c.last_name) as nombre_clientes
from customer c 
join rental r 
	on c.customer_id = r.customer_id
join inventory i 
	on r.inventory_id = i.inventory_id
join film f 
	on i.film_id = f.film_id
group by c.customer_id , c.first_name , c.last_name 
having count(distinct f.film_id) >= 7
order by c.last_name asc;

--Ejercicio 61
--Encuentra la cantidad total de películas alquiladas por categoría y
--muestra el nombre de la categoría junto con el recuento de alquileres.
with conteo_por_categoria as (
	select 
		fc.category_id ,
		count(r.rental_id) as total_alquileres	
	from film_category fc 
	join inventory i on fc.film_id = i.film_id 
	join rental r on i.inventory_id = r.inventory_id 
	group by fc.category_id 
)
select c."name" as categoria,
	cp.total_alquileres
from category c 
join conteo_por_categoria cp on c.category_id = cp.category_id 
order by total_alquileres desc;
	

--Ejercicio 62
--Encuentra el número de películas por categoría estrenadas en 2006.
select count(f.film_id) as numero_peliculas,
	c."name" 
from category c 
join film_category fc 
	on c.category_id = fc.film_id
join film f 
	on fc.film_id = f.film_id 
where f.release_year = 2006
group by c.category_id , c.name
order by numero_peliculas desc;

--Ejercicio 63
--Obtén todas las combinaciones posibles de trabajadores con las tiendas
--que tenemos.
select s.staff_id , s.first_name , s.last_name , s2.store_id 
from staff s 
cross join store s2 ;

--Ejercicio 64
--Encuentra la cantidad total de películas alquiladas por cada cliente y
--muestra el ID del cliente, su nombre y apellido junto con la cantidad de
--películas alquiladas.
with conteo_alquileres as (
    select 
        customer_id, 
        count(rental_id) as cantidad_peliculas_alquileres 
    from rental r
    group by customer_id
)
select 
    c.first_name, 
    c.last_name, 
    c.customer_id, 
    ca.cantidad_peliculas_alquileres
from customer c
join conteo_alquileres ca on c.customer_id = ca.customer_id
order by c.customer_id;
