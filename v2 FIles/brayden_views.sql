-- STUDENT OVERVIEW
CREATE VIEW student_overview AS
SELECT s.id AS student_id,
		concat(u.first_name, " ", u.last_name) AS full_name,
        u.email,
        s.gpa,
        s.admission_date,
        COUNT(e.student_id) AS enrolled_classes
FROM student s
JOIN user u ON s.user_id = u.id
JOIN enrollment e ON s.id = e.student_id
GROUP BY s.id, u.first_name, u.last_name, u.email, s.gpa, s.admission_date;

-- INSTRUCTOR SCHEDULE
CREATE VIEW instructor_schedule AS
SELECT e.id AS employee_id,
		concat(u.first_name, " ", u.last_name) AS full_name,
        d.name AS department,
        c.name AS course_name,
        concat(m.term, " ", m.year) AS term,
        s.dow,
        concat(s.start_time, " - ", s.end_time) AS class_time,
        concat(b.name, " ",r.name) AS location
FROM employee e
JOIN user u ON e.user_id = u.id
JOIN department d ON d.id = e.department_id
JOIN section s ON s.instructor_id = e.id
JOIN semester m ON m.id = s.semester_id
JOIN section_room sr ON sr.section_id = s.id
JOIN room r ON r.id = sr.room_id
JOIN building b ON b.id = r.building
JOIN course c ON c.id = course_id
ORDER BY u.first_name ASC;

-- ROOM UTILIZATION
CREATE VIEW room_utilization AS
SELECT b.name AS building_name,
		r.name AS room_name,
        r.capacity,
		COUNT(DISTINCT sr.section_id) AS section_count,
        COUNT(DISTINCT e.student_id) AS filled_seats
FROM room r
JOIN building b ON b.id = r.building
JOIN section_room sr ON sr.room_id = r.id
JOIN section s ON s.id = sr.section_id
JOIN enrollment e ON e.section_id = s.id
GROUP BY b.name, r.name, r.capacity	

-- Building Supervisers
CREATE VIEW building_supervisers AS
SELECT b.name AS building_name,
		b.campus,
        concat(u.first_name, " ", u.last_name) AS supervisor,
        d.name AS department,
        u.phone_number
FROM building b
JOIN employee e ON e.id = b.building_supervisor
JOIN user u ON u.id = e.user_id
JOIN department d ON d.id = e.department_id
