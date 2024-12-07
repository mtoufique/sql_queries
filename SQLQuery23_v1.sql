WITH buses_all_time AS(
SELECT 1 AS bus_strt_time
UNION all
SELECT bus_strt_time+1
FROM buses_all_time
WHERE bus_strt_time<=24),
bus_psng_time AS(
SELECT bus_strt_time,max(bus_id) AS bus_id,count(passenger_id) AS total_passengers,
LAG(count(passenger_id))OVER(ORDER BY bus_strt_time) as previous_psng,
max(capacity) AS capacity
---bus_id,capacity,a.arrival_time AS Bus_arrival_time,b.arrival_time AS passenger_arrival_time,
--CASE WHEN passenger_id IS NULL THEN 0 ELSE 1 END AS IND_PASSENGER
FROM buses_all_time
LEFT JOIN buses a ON bus_strt_time=a.arrival_time 
LEFT JOIN passengers b ON bus_strt_time=b.arrival_time
WHERE a.arrival_time IS NOT NULL OR b.arrival_time IS NOT NULL
GROUP BY bus_strt_time)
SELECT *,
(CASE WHEN capacity<(previous_psng+total_passengers) THEN capacity ELSE (previous_psng+total_passengers)END) AS Boarded_passengers,
(CASE WHEN capacity<(previous_psng+total_passengers) THEN ((previous_psng+total_passengers)-capacity)ELSE 0 END) AS Non_boarded_passengers
--LEAD(total_passengers)OVER(ORDER BY bus_strt_time) as next_psng
FROM bus_psng_time