select 
    fare_conditions, 
    DATE(actual_arrival) as date, 
    sum(amount) as day_sum
from ticket_flights 
join flights using(flight_id)
where status = 'Arrived'
group by fare_conditions, DATE(actual_arrival);

select 
    model['ru'], 
    fare_conditions, 
    COUNT(*)
from seats 
join aircrafts_data using(aircraft_code)
group by 1, 2;

SELECT 
    model['ru'] AS model,
    AVG(amount) AS avg_price
FROM ticket_flights
JOIN flights USING(flight_id)
JOIN aircrafts_data USING(aircraft_code)
GROUP BY 1
ORDER BY avg_price DESC;

select 
    model['ru'] as model, 
    ROUND(AVG(amount), 2) as avg_price
from ticket_flights 
join flights using(flight_id)
join aircrafts_data using(aircraft_code)
group by 1;
