/*
Add data validation to this procedure 

DELIMITER //

CREATE OR REPLACE PROCEDURE sp_insert_course_if_valid
(
	IN course_name_param VARCHAR(255),
    IN course_description_param TEXT,
    IN course_active_param TINYINT(4),
    IN created_userid_param INT(11),
    OUT course_id_param INT(11)
)
BEGIN
	DECLARE date_created TIMESTAMP;
    
    SET course_id_param = NULL;
    
    START TRANSACTION; 
    
	INSERT INTO course(name, description, active, created_userid)
    VALUES (course_name_param, course_description_param, course_active_param, created_userid_param);
	
    SET course_id_param = LAST_INSERT_ID();
    COMMIT;
END//
DELIMITER ;
*/


