WITH formula_nums AS(
SELECT *,left(formula,1) AS first_num,
right(formula,1) AS second_num,
(substring(formula,2,1))AS symbol_operator
FROM input)
SELECT a.*,
CASE WHEN a.symbol_operator='+' THEN a.value+b.value
     ELSE a.value-b.value END AS result
FROM formula_nums a
INNER JOIN formula_nums b
ON b.id=a.second_num
ORDER BY a.id
