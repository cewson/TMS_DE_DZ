
--Рейсы в бизнес-классе, вылетающие из Москвы
select 
	f.flight_no,
	a.city,
	a.airport_name,
	f.scheduled_departure, 
	s.fare_conditions
from flights f
left join airports a  on  f.departure_airport = a.airport_code
left join seats s  on f.aircraft_code  = s.aircraft_code  
where a.city = 'Москва' and s.fare_conditions = 'Business'



--Самолеты, которые никогда не использовались в полетах
select 
	a.aircraft_code,
	a.model 
from aircrafts a 
left join flights f on a.aircraft_code = f.aircraft_code
where f.flight_id is null
group by a.aircraft_code 










