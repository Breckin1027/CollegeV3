DELIMITER //

CREATE OR REPLACE FUNCTION f_validate_name(p_name VARCHAR(255))
RETURNS VARCHAR(255)
DETERMINISTIC -- the function always returns the same result given the same input parameters
BEGIN
  IF p_name IS NULL OR p_name = '' THEN
    RETURN 'Course name is required';
  ELSEIF p_name NOT REGEXP '^[A-Za-z][A-Za-z \\-\\'']{0,99}$' THEN
    RETURN 'Course name may contain only letters, spaces, hyphens, or apostrophes';
  END IF;
  RETURN NULL;
END//

CREATE OR REPLACE FUNCTION f_validate_description(p_desc VARCHAR(255))
RETURNS TEXT
DETERMINISTIC -- the function always returns the same result given the same input parameters
BEGIN
  IF p_desc IS NULL OR p_desc = '' THEN
    RETURN 'Description is required';
  ELSEIF p_desc NOT REGEXP '^[A-Za-z][A-Za-z \\-\\'']{0,99}$' THEN
    RETURN 'Description may contain only letters, spaces, hyphens, or apostrophes';
  END IF;
  RETURN NULL;
END//
/*
Calculate tuition:
   - Avg Cred Hour costs $192 (Hardcoded)
   - Use enrollment table
   - Course Counter
   - Multiply Course Counter by 3 for cred hours
   - Multiply product by 192 for total cost
   - print out grouped by user id
*/

CREATE OR REPLACE FUNCTION f_calculate_tuition (student_id_param INT(11))
RETURNS DECIMAL(9,2)
DETERMINISTIC
BEGIN
	DECLARE course_counter INT(11);
    DECLARE tuition DECIMAL(9,2);
    
    SELECT COUNT(*)
    INTO course_counter
    FROM enrollment
    WHERE student_id = student_id_param;
    
    SET tuition = course_counter * 3 * 192;
    
    RETURN tuition;
END//
    
DELIMITER ;
    
