/*This first MySQL code brings up customers and the film they rented. */
SET @yesterday := '2001-09-25';
SET @today := curdate();
select b.first_name, b.last_name, b.email, address, address2, district, city_id, postal_code, phone, c.rental_id,c.amount,c.payment_date,f.title,f.description,f.rental_duration,f.rental_rate,f.replacement_cost,date_format(a.last_update, '%Y-%m-%d') AS dates
from sakila.address as a 
left join sakila.customer as b on b.address_id = a.address_id
left join sakila.payment as c on c.customer_id = b.customer_id
left join sakila.rental as d on d.rental_id = c.rental_id
left join sakila.inventory as e on e.inventory_id = d.inventory_id
left join sakila.film as f on f.film_id = e.film_id
where a.last_update between @yesterday and @today
/*this second MySQL code brings up which film has been doing well.*/
select f.title, f.description, f.release_year,f.rental_rate, count(c.rental_id) as AmountRented, count(c.rental_id)*c.amount as Earnings ,f.length,f.replacement_cost
from sakila.payment as c
left join sakila.rental as d on d.rental_id = c.rental_id
left join sakila.inventory as e on e.inventory_id = d.inventory_id
left join sakila.film as f on f.film_id = e.film_id
group by f.title, f.description, f.release_year,f.rental_rate, f.length,f.replacement_cost,c.amount
order by AmountRented DESC