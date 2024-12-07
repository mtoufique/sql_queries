WITH PAIRS AS(
SELECT *,CASE WHEN brand1<brand2 THEN CONCAT(brand1,',',brand2,',',year) ELSE 
CONCAT(brand2,',',brand1,',',year)END AS pairs,
CASE WHEN custom1=custom3 AND custom2=custom4 THEN 1 ELSE 0 END AS IND_EQUALS
--CASE WHEN custom1!=custom3 OR custom2!=custom4 THEN 1 END AS IND_UNEQUAL
FROM brands),
rn AS(
SELECT *,ROW_NUMBER()OVER(PARTITION BY pairs ORDER BY year) AS rn
FROM PAIRS)
SELECT * FROM rn 
WHERE IND_EQUALS=0 OR(IND_EQUALS=1 AND rn=1)
ORDER BY brand1