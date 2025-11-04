/*
Procedure Ideas:
- Create a new user (Student, Faculty)
- Current passing students
- Create a new course 
- Remove old courses
*/
SELECT s.user_id, s.gpa, CONCAT(u.first_name, ' ', u.last_name) AS user_name  FROM student s JOIN user u ON s.id = u.id GROUP BY s.id;