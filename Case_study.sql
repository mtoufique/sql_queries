---1)
SELECT Segment,COUNT(DISTINCT b.User_ID) AS total_Users,
COUNT(DISTINCT CASE WHEN Line_of_business='Flight' AND YEAR(Booking_date)='2022' AND month(Booking_date)='04' THEN a.User_id END)AS Count_User_April
FROM booking_table a
RIGHT JOIN User_table b ON a.User_id=b.User_id
GROUP BY Segment

--2)
WITH all_bookings AS(
SELECT *,DENSE_RANK()OVER(PARTITION BY User_id ORDER BY Booking_date ASC) AS rn
FROM booking_table)
SELECT * FROM all_bookings
WHERE RN=1 AND [Line_of_business]='Hotel'

---3)
SELECT User_id,max(Booking_date),min(Booking_date),
DATEDIFF(DAY,min(Booking_date),max(Booking_date)) AS No_of_days
FROM booking_table
GROUP BY User_id

--4)
SELECT Segment,
SUM(CASE WHEN Line_of_business='Flight' THEN 1 ELSE 0 END)AS No_of_Flights ,
SUM(CASE WHEN Line_of_business='Hotel' THEN 1 ELSE 0 END)AS No_of_Hotels
FROM booking_table a
INNER JOIN User_table b ON a.User_id=b.User_id
GROUP BY Segment
