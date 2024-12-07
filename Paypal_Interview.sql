
WITH CTE as(
SELECT *,avg(salary)OVER(PARTITION BY department_id)AS avg_dept_salary,
count(emp_id)OVER(PARTITION BY department_id) AS emp_dept_count,
avg(salary)OVER() AS total_avg_salary,
count(emp_id)OVER() AS emp_overall_count
FROM emp),
cte_2 AS(
SELECT *,((total_avg_salary*emp_overall_count)-(emp_dept_count*avg_dept_salary))/(emp_overall_count-emp_dept_count) AS avg_desired
FROM CTE)
SELECT * FROM cte_2
WHERE avg_dept_salary<avg_desired
