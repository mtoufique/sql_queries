
select name,
count(DISTINCT event_name) AS no_events
from events a INNER JOIN employees b ON a.emp_id=b.id
GROUP BY emp_id,name
HAVING count(DISTINCT event_name)=3
