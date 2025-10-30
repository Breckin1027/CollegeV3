USE `af25nicot1_college_V2`;

-- ---------------------------
-- Users (people)
-- ---------------------------
INSERT INTO `user`
(id, first_name, last_name, dob, address, email, phone_number, ssn, university_id, created, created_userid, updated, updated_userid)
VALUES
(1,  'System',  'Admin',     '1970-01-01','123 Admin Way, Anywhere, NE','admin@college.edu',      '402-000-0000', 100000001, 900000001, NOW(), 1, NOW(), 1),
(2,  'Melissa', 'Garcia',    '1980-04-12','45 Oak St, Wayne, NE',       'mgarcia@college.edu',     '402-555-1200', 100000002, 900000002, NOW(), 1, NOW(), 1),
(3,  'Robert',  'Nguyen',    '1975-09-23','12 Pine Ave, Wayne, NE',      'rnguyen@college.edu',     '402-555-1201', 100000003, 900000003, NOW(), 1, NOW(), 1),
(4,  'Aisha',   'Khan',      '1987-02-08','78 Cedar Rd, Wayne, NE',      'akhan@college.edu',       '402-555-1202', 100000004, 900000004, NOW(), 1, NOW(), 1),
(5,  'David',   'Lopez',     '1990-11-15','90 Maple St, Wayne, NE',      'dlopez@college.edu',      '402-555-1203', 100000005, 900000005, NOW(), 1, NOW(), 1),
(6,  'Priya',   'Patel',     '1983-06-19','201 Elm St, Wayne, NE',       'ppatel@college.edu',      '402-555-1204', 100000006, 900000006, NOW(), 1, NOW(), 1),
(7,  'Ethan',   'Miller',    '1999-08-01','5 Birch Ct, Wayne, NE',       'ethan.miller@students.edu','402-555-2200',100000007, 100100001, NOW(), 1, NOW(), 1),
(8,  'Heidi',   'Taylor',    '2004-03-25','77 Walnut Dr, Wayne, NE',     'heidi.taylor@students.edu','402-555-2201',100000008, 100100002, NOW(), 1, NOW(), 1),
(9,  'Diego',   'Martinez',  '2003-12-02','88 Poplar Ln, Wayne, NE',     'diego.martinez@students.edu','402-555-2202',100000009,100100003, NOW(), 1, NOW(), 1),
(10, 'Chloe',   'Kaufman',   '2002-07-14','11 Aspen Pl, Wayne, NE',      'chloe.kaufman@students.edu','402-555-2203',100000010,100100004, NOW(), 1, NOW(), 1),
(11, 'Kaleb',   'Johnson',   '2001-10-05','19 Spruce St, Wayne, NE',     'kaleb.johnson@students.edu','402-555-2204',100000011,100100005, NOW(), 1, NOW(), 1),
(12, 'McKenna', 'Plumbtree', '2003-04-30','33 Sycamore St, Wayne, NE',   'mckenna.plumbtree@students.edu','402-555-2205',100000012,100100006,NOW(),1,NOW(),1),
(13, 'Adeline', 'Riedmann',  '1985-01-17','2 River Rd, Wayne, NE',       'adeline.riedmann@college.edu','402-555-1205',100000013,900000007,NOW(),1,NOW(),1),
(14, 'Debby',   'Johnson',   '1978-05-22','3 Lake Dr, Wayne, NE',        'debby.johnson@college.edu','402-555-1206',100000014,900000008,NOW(),1,NOW(),1),
(15, 'Nicolas', 'Tagliafichi','1998-09-10','100 College View, Wayne, NE','nicolas.tagliafichi@students.edu','402-555-2206',100000015,100100007,NOW(),1,NOW(),1);

-- ---------------------------
-- Departments
-- ---------------------------
INSERT INTO `department`
(id, name, created, created_userid, updated, updated_userid)
VALUES
(1,'Computer Science', NOW(),1,NOW(),1),
(2,'Mathematics',      NOW(),1,NOW(),1),
(3,'Business',         NOW(),1,NOW(),1),
(4,'Biology',          NOW(),1,NOW(),1);

-- ---------------------------
-- Roles
-- ---------------------------
INSERT INTO `role`
(id, name, description, created, created_userid, updated, updated_userid)
VALUES
(1,'Professor','Tenure-track or tenured faculty',NOW(),1,NOW(),1),
(2,'Lecturer','Teaching-focused faculty',NOW(),1,NOW(),1),
(3,'IT Director','Leads IT operations',NOW(),1,NOW(),1),
(4,'Department Chair','Leads a department',NOW(),1,NOW(),1),
(5,'Administrator','General staff/administration',NOW(),1,NOW(),1);

-- ---------------------------
-- Employees (faculty/staff) - tie to users
-- ---------------------------
INSERT INTO `employee`
(id, user_id, department_id, role_id, created, created_userid, updated, updated_userid)
VALUES
(1, 2, 1, 4, NOW(),1,NOW(),1), -- Melissa Garcia, CS Chair
(2, 3, 3, 3, NOW(),1,NOW(),1), -- Robert Nguyen, IT Director (Business/IT ops)
(3, 4, 1, 1, NOW(),1,NOW(),1), -- Aisha Khan, Professor CS
(4, 5, 2, 2, NOW(),1,NOW(),1), -- David Lopez, Lecturer Math
(5, 6, 4, 1, NOW(),1,NOW(),1), -- Priya Patel, Professor Biology
(6,13,3, 1, NOW(),1,NOW(),1),  -- Adeline Riedmann, Professor Business
(7,14,3, 5, NOW(),1,NOW(),1);  -- Debby Johnson, Admin Business

-- ---------------------------
-- Buildings
-- ---------------------------
INSERT INTO `building`
(id, name, building_supervisor, campus, created, created_userid, updated, updated_userid)
VALUES
(1,'Gardner Hall', 2, 'Main', NOW(),1,NOW(),1),
(2,'Science Center',5, 'Main', NOW(),1,NOW(),1),
(3,'Business Hall',6, 'Main', NOW(),1,NOW(),1),
(4,'Math Annex',   4, 'Main', NOW(),1,NOW(),1);

-- ---------------------------
-- Rooms
-- ---------------------------
INSERT INTO `room`
(id, name, building, capacity, description, created, created_userid, updated, updated_userid)
VALUES
(1, 'GH-101', 1, 40, 'Lecture hall with projector', NOW(),1,NOW(),1),
(2, 'GH-202', 1, 28, 'Computer lab',               NOW(),1,NOW(),1),
(3, 'SC-110', 2, 32, 'Bio lab benches',            NOW(),1,NOW(),1),
(4, 'BH-201', 3, 45, 'Tiered classroom',           NOW(),1,NOW(),1),
(5, 'MA-104', 4, 26, 'Math classroom',             NOW(),1,NOW(),1);

-- ---------------------------
-- Student Statuses
-- ---------------------------
INSERT INTO `status`
(id, label, description, created, created_userid, updated, updated_userid)
VALUES
(1,'Active','Enrolled and in good standing',NOW(),1,NOW(),1),
(2,'On Leave','Temporary leave of absence',NOW(),1,NOW(),1),
(3,'Graduated','Completed degree requirements',NOW(),1,NOW(),1),
(4,'Probation','Academic probation',NOW(),1,NOW(),1);

-- ---------------------------
-- Students (link to users)
-- ---------------------------
INSERT INTO `student`
(id, user_id, admission_date, gpa, status, created, created_userid, updated, updated_userid)
VALUES
(1, 7,  '2023-08-20', 3.40, 1, NOW(),1,NOW(),1), -- Ethan
(2, 8,  '2024-08-20', 3.85, 1, NOW(),1,NOW(),1), -- Heidi
(3, 9,  '2022-08-20', 3.10, 4, NOW(),1,NOW(),1), -- Diego (probation)
(4, 10, '2021-08-20', 3.70, 3, NOW(),1,NOW(),1), -- Chloe (graduated)
(5, 11, '2022-08-20', 2.95, 1, NOW(),1,NOW(),1), -- Kaleb
(6, 12, '2023-08-20', 3.25, 2, NOW(),1,NOW(),1), -- McKenna (on leave)
(7, 15, '2024-08-20', 3.55, 1, NOW(),1,NOW(),1); -- Nicolas

-- ---------------------------
-- Semesters
-- ---------------------------
INSERT INTO `semester`
(id, term, year, created, created_userid, updated, updated_userid)
VALUES
(1,'Fall',   2024, NOW(),1,NOW(),1),
(2,'Spring', 2025, NOW(),1,NOW(),1),
(3,'Fall',   2025, NOW(),1,NOW(),1);

-- ---------------------------
-- Courses
-- ---------------------------
INSERT INTO `course`
(id, name, description, active, created, created_userid, updated, updated_userid)
VALUES
(1,'CSCI 101 - Intro to Programming','Fundamentals of programming with Python',1,NOW(),1,NOW(),1),
(2,'CSCI 201 - Data Structures','Arrays, lists, trees, hash maps',1,NOW(),1,NOW(),1),
(3,'MATH 210 - Calculus I','Limits, derivatives, integrals',1,NOW(),1,NOW(),1),
(4,'BIOL 150 - General Biology','Cell biology, genetics, ecology',1,NOW(),1,NOW(),1),
(5,'BUS 310 - Principles of Management','Planning, organizing, leading, controlling',1,NOW(),1,NOW(),1),
(6,'CSCI 330 - Databases','Relational modeling, SQL, normalization',1,NOW(),1,NOW(),1);

-- ---------------------------
-- Sections (per semester/course/instructor)
-- dow examples: 'MWF', 'TR'
-- ---------------------------
INSERT INTO `section`
(id, semester_id, course_id, instructor_id, dow, start_time, end_time, created, created_userid, updated, updated_userid)
VALUES
(1, 3, 1, 3, 'MWF', '09:00:00', '09:50:00', NOW(),1,NOW(),1), -- CSCI 101, Prof A. Khan
(2, 3, 2, 3, 'TR',  '11:00:00', '12:15:00', NOW(),1,NOW(),1), -- CSCI 201, Prof A. Khan
(3, 3, 3, 4, 'MWF', '10:00:00', '10:50:00', NOW(),1,NOW(),1), -- Calc I,   D. Lopez
(4, 3, 4, 5, 'TR',  '13:30:00', '14:45:00', NOW(),1,NOW(),1), -- Gen Bio,  P. Patel
(5, 3, 5, 6, 'MWF', '14:00:00', '14:50:00', NOW(),1,NOW(),1), -- Mgmt,     A. Riedmann
(6, 3, 6, 2, 'TR',  '15:00:00', '16:15:00', NOW(),1,NOW(),1); -- Databases, R. Nguyen

-- ---------------------------
-- Section-Room assignments
-- ---------------------------
INSERT INTO `section_room`
(id, room_id, section_id, created, created_userid, updated, updated_userid)
VALUES
(1, 1, 1, NOW(),1,NOW(),1), -- GH-101 for CSCI101
(2, 2, 2, NOW(),1,NOW(),1), -- GH-202 for CSCI201
(3, 5, 3, NOW(),1,NOW(),1), -- MA-104 for Calc I
(4, 3, 4, NOW(),1,NOW(),1), -- SC-110 for Bio
(5, 4, 5, NOW(),1,NOW(),1), -- BH-201 for Mgmt
(6, 2, 6, NOW(),1,NOW(),1); -- GH-202 for Databases

-- ---------------------------
-- Enrollments (students into sections)
-- ---------------------------
INSERT INTO `enrollment`
(id, student_id, section_id, created, created_userid, updated, updated_userid)
VALUES
-- Ethan (student 1)
(1, 1, 1, NOW(),1,NOW(),1),
(2, 1, 2, NOW(),1,NOW(),1),
(3, 1, 3, NOW(),1,NOW(),1),
-- Heidi (student 2)
(4, 2, 1, NOW(),1,NOW(),1),
(5, 2, 6, NOW(),1,NOW(),1),
-- Diego (student 3)
(6, 3, 1, NOW(),1,NOW(),1),
(7, 3, 3, NOW(),1,NOW(),1),
-- Kaleb (student 5)
(8, 5, 2, NOW(),1,NOW(),1),
(9, 5, 5, NOW(),1,NOW(),1),
-- McKenna (student 6 - on leave, but had a past enrollment)
(10,6, 4, NOW(),1,NOW(),1),
-- Nicolas (student 7)
(11,7, 6, NOW(),1,NOW(),1),
(12,7, 5, NOW(),1,NOW(),1);

-- ---------------------------
-- Grade Types
-- ---------------------------
INSERT INTO `grade_type`
(id, name, created, created_userid, updated, updated_userid)
VALUES
(1,'Homework',NOW(),1,NOW(),1),
(2,'Quiz',    NOW(),1,NOW(),1),
(3,'Midterm', NOW(),1,NOW(),1),
(4,'Final',   NOW(),1,NOW(),1),
(5,'Project', NOW(),1,NOW(),1);

-- ---------------------------
-- Grades (letters are single char)
-- ---------------------------
INSERT INTO `grade`
(id, letter, enrollment_id, type, created, created_userid, updated, updated_userid)
VALUES
-- Ethan in CSCI101 (enrollment 1)
(1,'A', 1, 1, NOW(),1,NOW(),1),
(2,'B', 1, 2, NOW(),1,NOW(),1),
(3,'A', 1, 3, NOW(),1,NOW(),1),
(4,'A', 1, 4, NOW(),1,NOW(),1),
-- Ethan in CSCI201 (enrollment 2)
(5,'A', 2, 1, NOW(),1,NOW(),1),
(6,'A', 2, 5, NOW(),1,NOW(),1),
(7,'B', 2, 3, NOW(),1,NOW(),1),
(8,'A', 2, 4, NOW(),1,NOW(),1),
-- Ethan in Calc I (enrollment 3)
(9,'B', 3, 2, NOW(),1,NOW(),1),
(10,'B',3, 3, NOW(),1,NOW(),1),
(11,'B',3, 4, NOW(),1,NOW(),1),

-- Heidi in CSCI101 (enrollment 4)
(12,'A', 4, 1, NOW(),1,NOW(),1),
(13,'A', 4, 3, NOW(),1,NOW(),1),
(14,'A', 4, 4, NOW(),1,NOW(),1),
-- Heidi in Databases (enrollment 5)
(15,'A', 5, 5, NOW(),1,NOW(),1),
(16,'A', 5, 3, NOW(),1,NOW(),1),
(17,'A', 5, 4, NOW(),1,NOW(),1),

-- Diego in CSCI101 (enrollment 6)
(18,'C', 6, 1, NOW(),1,NOW(),1),
(19,'C', 6, 2, NOW(),1,NOW(),1),
(20,'B', 6, 3, NOW(),1,NOW(),1),
(21,'C', 6, 4, NOW(),1,NOW(),1),
-- Diego in Calc I (enrollment 7)
(22,'C', 7, 2, NOW(),1,NOW(),1),
(23,'C', 7, 3, NOW(),1,NOW(),1),
(24,'D', 7, 4, NOW(),1,NOW(),1),

-- Kaleb in CSCI201 (enrollment 8)
(25,'B', 8, 1, NOW(),1,NOW(),1),
(26,'B', 8, 5, NOW(),1,NOW(),1),
(27,'B', 8, 4, NOW(),1,NOW(),1),
-- Kaleb in Management (enrollment 9)
(28,'A', 9, 2, NOW(),1,NOW(),1),
(29,'A', 9, 3, NOW(),1,NOW(),1),
(30,'A', 9, 4, NOW(),1,NOW(),1),

-- McKenna in Biology (enrollment 10)
(31,'B',10, 1, NOW(),1,NOW(),1),
(32,'B',10, 3, NOW(),1,NOW(),1),
(33,'B',10, 4, NOW(),1,NOW(),1),

-- Nicolas in Databases (enrollment 11)
(34,'A',11, 5, NOW(),1,NOW(),1),
(35,'A',11, 3, NOW(),1,NOW(),1),
(36,'A',11, 4, NOW(),1,NOW(),1),
-- Nicolas in Management (enrollment 12)
(37,'A',12, 1, NOW(),1,NOW(),1),
(38,'A',12, 2, NOW(),1,NOW(),1),
(39,'A',12, 4, NOW(),1,NOW(),1);

-- Done!
