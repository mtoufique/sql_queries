
WITH recursive_cte AS(
SELECT CAST('2023-01-01' AS DATE) AS month_start_date
UNION ALL
SELECT DATEADD(MONTH,1,month_start_date)
FROM recursive_cte
WHERE month_start_date<='2023-12-01'),
all_prices AS(
SELECT *,LAG(price)OVER(ORDER BY month_start_date) AS previous_price
FROM recursive_cte
left join sku
ON month_start_date<=price_date AND DATEDIFF(MONTH,month_start_date,price_date)=0),
updated_price AS(
SELECT *, CASE WHEN month_start_date< price_date THEN previous_price ELSE price END AS updated_price,
DENSE_RANK()OVER(PARTITION BY month_start_date ORDER BY price_date) AS rn 
FROM all_prices)
SELECT month_start_date,COALESCE(updated_price,previous_price) AS final_price
FROM updated_price
WHERE rn=1 AND COALESCE(updated_price,previous_price) IS NOT NULL