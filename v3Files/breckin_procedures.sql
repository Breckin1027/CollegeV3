/*
Procedure Ideas:
- Create a new user (Student, Faculty)
- Current passing students
- Create a new course 
- Remove old courses
*/

DROP PROCEDURE IF EXISTS p_create_course()

DELIMITER //

CREATE PROCEDURE create_course
(
	IN course_name_param VARCHAR(255),
    IN course_description_param TEXT,
    OUT course_id_param INT(11)
)
BEGIN
	DECLARE date_created TIMESTAMP;
    DECLARE course_active TINYINT(4);
    
END//
DELIMITER ;
    
	/*
    First Step: Validate the data. Make sure it isn't bad data before using it.
    Second Step: Insert the new data into the table 
    */