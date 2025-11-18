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
	DECLARE v_error_message VARCHAR(255);
    DECLARE v_sqlstate      CHAR(5);
    DECLARE v_errno         INT;
    DECLARE v_num_errors    INT DEFAULT 0;    
    DECLARE v_course_exists INT DEFAULT 0;
    
    SET course_id_param = NULL;
    
    BEGIN 
		DECLARE EXIT HANDLER FOR SQLEXCEPTION
        
        GET DIAGNOSTICS CONDITION 1
			v_error_message    = MESSAGE_TEXT,
            v_errno            = MYSQL_ERRNO,
			v_sqlstate         = RETURNED_SQLSTATE;
		
			SET v_error_message = LEFT(CONCAT_WS('',
			  'Proc failed [', IFNULL(v_sqlstate, 'HY000'), '/', 
			  IFNULL(v_errno, 0), ']: ',
			  IFNULL(v_error_message, '(no message)')
			), 512); 
			
		ROLLBACK;
		
		SIGNAL SQLSTATE '40000' SET MESSAGE_TEXT = v_error_message;  
	
    END;
    
	START TRANSACTION;
	
	  CREATE TEMPORARY TABLE IF NOT EXISTS tmp_course_field_errors (
		field_name    VARCHAR(64),
		error_message VARCHAR(255)
	  ) ENGINE=MEMORY;

	  TRUNCATE TABLE tmp_course_field_errors;

	  SET v_error_message = f_validate_name(course_name_param);
	  IF v_error_message IS NOT NULL THEN
		INSERT INTO tmp_course_field_errors VALUES ('name', v_error_message);
	  END IF;

	  SET v_error_message = f_validate_description(course_description_param);
	  IF v_error_message IS NOT NULL THEN
		INSERT INTO tmp_course_field_errors VALUES ('description', v_error_message);
	  END IF;
      
	SELECT COUNT(*)
	INTO v_num_errors 
    FROM tmp_course_field_errors;

	  IF v_num_errors > 0 THEN
		SELECT field_name, error_message FROM tmp_course_field_errors;
		SIGNAL SQLSTATE '22000'      
		   SET MYSQL_ERRNO  = 1366,   
			   MESSAGE_TEXT = "Invalid Course Data";
	  END IF;
      
	SELECT COUNT(*)
	INTO v_course_exists 
    FROM course
	WHERE
		name = course_name_param
	AND description = course_description_param;
	  
	  IF v_course_exists > 0 THEN 
		SIGNAL SQLSTATE '23000'       
		   SET MYSQL_ERRNO  = 1062,  
			   MESSAGE_TEXT = "Course Already Exists";
	  END IF;
	  
	  INSERT INTO course (name, description, active, created_userid)
	  VALUES (course_name_param, course_description_param, course_active_param, created_userid_param);

	  SET course_id_param = LAST_INSERT_ID();
	  
	  COMMIT;  

END//
      
DELIMITER ;