--Soln1
WITH lists AS(
SELECT '1' as helper,
string_agg(CAR,',') CAR_list,
string_agg(length,',') length_list,
string_agg(width,',') width_list,
string_agg(height,',') height_list
FROM FOOTER)
Select *, 
right(CAR_list,CHARINDEX(',',REVERSE(CAR_list))-1) AS updated_car,
right(length_list,CHARINDEX(',',REVERSE(length_list))-1) AS updated_length,
right(width_list,CHARINDEX(',',REVERSE(width_list))-1) AS updated_width,
right(height_list,CHARINDEX(',',REVERSE(height_list))-1) AS updated_height
FROM lists
--Soln2
WITH rn_columns AS(
SELECT *,COUNT(CAR)OVER(ORDER BY id) AS CAR_rn,
COUNT(LENGTH)OVER(ORDER BY id) AS length_rn,
COUNT(width)OVER(ORDER BY id) AS width_rn,
COUNT(height)OVER(ORDER BY id) AS height_rn
FROM FOOTER
)
SELECT TOP 1 first_value(car)OVER(PARTITION BY CAR_rn ORDER BY id) AS car_updated,
first_value(length)OVER(PARTITION BY length_rn ORDER BY id) AS lenth_updated,
first_value(width)OVER(PARTITION BY width_rn ORDER BY id) AS width_updated,
first_value(height)OVER(PARTITION BY height_rn ORDER BY id) AS height_updated
FROM rn_columns
ORDER BY id DESC