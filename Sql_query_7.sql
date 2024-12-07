Hi Thanks for the content...My approach 
WITH updated_day_week AS(
select *,
CASE WHEN (DATEPART(WEEKDAY,Dates)-1)=0 THEN 7 ELSE (DATEPART(WEEKDAY,Dates)-1) 
END AS Updated_Day_of_week
from Day_Indicator)
SELECT *,SUBSTRING(Day_Indicator,Updated_Day_of_week,1) AS Updated_Indicator
FROM updated_day_week
WHERE SUBSTRING(Day_Indicator,Updated_Day_of_week,1)=1