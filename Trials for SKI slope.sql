WITH all_routes AS(
SELECT hut1,hut2 
FROM trails
UNION ALL 
SELECT hut2,hut1
FROM trails
),
two_routes AS(
SELECT a.hut1,a.hut2,
CASE WHEN b.hut2!=a.hut2 THEN b.hut2 ELSE b.hut1 END as hut3,
c.name AS startpt,d.name AS middlept,c.altitude AS startpt_alt,
d.altitude AS middlept_alt
FROM all_routes a
INNER JOIN all_routes b 
ON a.hut2=b.hut1 
INNER JOIN mountain_huts c ON c.id=a.hut1
INNER JOIN mountain_huts d ON d.id=a.hut2)
SELECT startpt,middlept,e.name AS endpt
FROM two_routes
INNER JOIN mountain_huts e ON e.id=hut3
WHERE startpt_alt>middlept_alt AND middlept_alt>e.altitude