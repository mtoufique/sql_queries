create table students  (
student_id int,
skill varchar(20)
);
delete from students;
insert into students values
(1,'sql'),(1,'python'),(1,'tableau'),(2,'sql'),(3,'sql'),(3,'python'),(4,'tableau'),(5,'python'),(5,'tableau');
--11
SELECT student_id,count(*),STRING_AGG(skill,',')WITHIN GROUP(ORDER BY skill) AS skillset
FROM students
GROUP BY student_id
HAVING STRING_AGG(skill,',')WITHIN GROUP(ORDER BY skill)='python,sql';

