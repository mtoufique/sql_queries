WITH salary_breakup AS(
select emp_id,emp_name,income,percentage,(base_salary*(percentage*1.0/100)) AS amount
from salary
CROSS JOIN income
UNION ALL
SELECT emp_id,emp_name,deduction,percentage,(base_salary*(percentage*1.0/100)) AS amount
from salary
CROSS JOIN deduction)
SELECT emp_name,sum(CASE WHEN income='Basic' THEN amount END) AS Basic,
sum(CASE WHEN income='Allowance' THEN amount END) AS Allowance,
sum(CASE WHEN income='Others' THEN amount END) AS Others,
sum(CASE WHEN income='Insurance' THEN amount END) AS Insurance,
sum(CASE WHEN income='House' THEN amount END) AS House,
sum(CASE WHEN income in ('Basic','Allowance','Others') THEN amount END) AS Gross,
sum(CASE WHEN income in ('Insurance','House','Health') THEN amount END) AS Total_Deductions,
sum(CASE WHEN income in ('Basic','Allowance','Others') THEN amount ELSE (-1*amount) END) AS Net_Salary
FROM salary_breakup
GROUP BY emp_name





