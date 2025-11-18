DELIMITER $$

CREATE PROCEDURE sp_insert_student_if_valid(
  IN  p_first_name    	 VARCHAR(255),
  IN  p_last_name     	 VARCHAR(255),
  IN  p_dob           	 DATE,
  IN  p_address 	  	 VARCHAR(255),
  IN  p_email		  	 VARCHAR(255),
  IN  p_phone_number  	 VARCHAR(255),
  IN  p_ssn			  	 INT,
  IN  p_university_id	 INT,
  IN  p_created_user_id  INT,
  OUT p_student_id       INT   -- success path sets this; error path leaves it NULL
)
BEGIN
  DECLARE v_error_msg 	VARCHAR(255);
  DECLARE v_user_id 	INT;
  DECLARE v_sqlstate 	CHAR(5);
  DECLARE v_errno 		INT;
  DECLARE v_num_errors 	INT DEFAULT 0; -- number of data validation errors
  DECLARE v_user_unique INT DEFAULT 0;

  -- Default OUT
  SET p_student_id = NULL;
  
  BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    
    GET DIAGNOSTICS CONDITION 1  -- the most recent error that triggered your handler
      v_sqlstate = RETURNED_SQLSTATE,
      v_errno    = MYSQL_ERRNO,
      v_error_msg      = MESSAGE_TEXT;
      
	  SET v_error_msg = LEFT(CONCAT_WS('',
		  'Proc failed [', IFNULL(v_sqlstate,'HY000'), '/',
		  IFNULL(v_errno,0), ']: ',
		  IFNULL(v_error_msg,'(no message)')
		), 512);  -- using LEFT to make sure we don't exceed the lenght of an error message
        
    ROLLBACK;
    
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = v_error_msg;
  END;
  
  START TRANSACTION;  

  -- Temp table to collect validation messages
  CREATE TEMPORARY TABLE IF NOT EXISTS tmp_user_field_errors (
    field_name    VARCHAR(64),
    error_message VARCHAR(255)
  ) ENGINE=MEMORY;

  TRUNCATE TABLE tmp_user_field_errors;

  -- Call your UDF validators (each returns NULL if valid, else error text)
  SET v_error_msg = f_validate_first_name(p_first_name);
  IF v_error_msg IS NOT NULL THEN
    INSERT INTO tmp_user_field_errors VALUES ('first_name', v_error_msg);
  END IF;

  SET v_error_msg = f_validate_last_name(p_last_name);
  IF v_error_msg IS NOT NULL THEN
    INSERT INTO tmp_user_field_errors VALUES ('last_name', v_error_msg);
  END IF;

  SET v_error_msg = f_validate_dob(p_dob);
  IF v_error_msg IS NOT NULL THEN
    INSERT INTO tmp_user_field_errors VALUES ('dob', v_error_msg);
  END IF;

  SET v_error_msg = f_validate_address(p_address);
  IF v_error_msg IS NOT NULL THEN
    INSERT INTO tmp_user_field_errors VALUES ('address', v_error_msg);
  END IF;

  SET v_error_msg = f_validate_email(p_email);
  IF v_error_msg IS NOT NULL THEN
    INSERT INTO tmp_user_field_errors VALUES ('email', v_error_msg);
  END IF;
  
  IF p_phone_number IS NOT NULL THEN
		SET v_error_msg = f_validate_phone_number(p_phone_number);
	  IF v_error_msg IS NOT NULL THEN
		INSERT INTO tmp_user_field_errors VALUES ('phone_number', v_error_msg);
	  END IF;
  END IF;
  
  IF p_ssn IS NOT NULL THEN
		SET v_error_msg = f_validate_ssn(p_ssn);
	  IF v_error_msg IS NOT NULL THEN
		INSERT INTO tmp_user_field_errors VALUES ('ssn', v_error_msg);
	  END IF;
  END IF;
  
  IF p_university_id IS NOT NULL THEN
		SET v_error_msg = f_validate_university_id(p_university_id);
	   IF v_error_msg IS NOT NULL THEN
			INSERT INTO tmp_user_field_errors VALUES ('phone_number', v_error_msg);
		END IF;
	END IF;
  
  SELECT COUNT(*) INTO v_user_unique
  FROM user
  WHERE email = p_email
		AND ssn = p_ssn
        AND university_id = p_university_id;
        
  IF v_user_unique > 0 THEN 
	SIGNAL SQLSTATE '22000'
		SET MYSQL_ERRNO = 1062,
			MESSAGE_TEXT = "Data not unique";
   END IF;
        
  -- Any validation errors?
  SELECT COUNT(*) INTO v_num_errors FROM tmp_user_field_errors;

  IF v_num_errors > 0 THEN
    SELECT field_name, error_message FROM tmp_user_field_errors;
    ROLLBACK;
  ELSE
	INSERT INTO `user`(first_name, last_name, dob, address, email, phone_number, ssn, university_id, created_user_id)
	VALUES (p_first_name, p_last_name, p_date_of_birth, p_address, p_email, p_phone_number, p_ssn, p_university_id, p_created_user_id);
    
    SET v_user_id = LAST_INSERT_ID();
    
    INSERT INTO `student`(user_id, status, created_user_id)
    VALUES (v_user_id, 1, p_created_user_id);

	SET p_user_id = LAST_INSERT_ID();
	COMMIT;  
  END IF;

END$$

DELIMITER ;
