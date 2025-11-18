DELIMITER $$

CREATE OR REPLACE FUNCTION f_validate_first_name(p_first VARCHAR(255))
RETURNS VARCHAR(255)
DETERMINISTIC -- the function always returns the same result given the same input parameters
BEGIN
  IF p_first IS NULL OR p_first = '' THEN
    RETURN 'First name is required';
  ELSEIF p_first NOT REGEXP '^[A-Za-z][A-Za-z \\-\\'']{0,99}$' THEN
    RETURN 'First name may contain only letters, spaces, hyphens, or apostrophes';
  END IF;
  RETURN NULL;
END$$

CREATE OR REPLACE FUNCTION f_validate_last_name(p_last VARCHAR(255))
RETURNS VARCHAR(255)
DETERMINISTIC -- the function always returns the same result given the same input parameters
BEGIN
  IF p_last IS NULL OR p_last = '' THEN
    RETURN 'Last name is required';
  ELSEIF p_last NOT REGEXP '^[A-Za-z][A-Za-z \\-\\'']{0,99}$' THEN
    RETURN 'Last name may contain only letters, spaces, hyphens, or apostrophes';
  END IF;
  RETURN NULL;
END$$

CREATE OR REPLACE FUNCTION f_validate_dob(p_dob DATE)
RETURNS VARCHAR(255)
DETERMINISTIC -- the function always returns the same result given the same input parameters
BEGIN
  IF p_dob IS NULL THEN
    RETURN 'Date of birth is required';
  ELSEIF p_dob > CURDATE() THEN
    RETURN 'Date of birth cannot be in the future';
  ELSEIF TIMESTAMPDIFF(YEAR, p_dob, CURDATE()) < 14 THEN
    RETURN 'User must be at least 14 years old';
  END IF;
  RETURN NULL;
END$$

CREATE OR REPLACE FUNCTION f_validate_address(p_address VARCHAR(255))
RETURNS VARCHAR(255)
DETERMINISTIC -- the function always returns the same result given the same input parameters
BEGIN
  IF p_address IS NULL OR p_address = '' THEN
    RETURN 'Address is required';
  END IF;
  RETURN NULL;
END$$

CREATE OR REPLACE FUNCTION f_validate_email(p_email VARCHAR(255))
RETURNS VARCHAR(255)
DETERMINISTIC -- the function always returns the same result given the same input parameters
BEGIN
DECLARE v_exists INT DEFAULT 0;
  IF p_email IS NULL OR p_email = '' THEN
    RETURN 'Email address is required';
  ELSEIF p_email NOT REGEXP '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$' THEN
    RETURN 'Email address is invalid';
  END IF;
  
  SELECT COUNT(*) INTO v_exists
  FROM user
  WHERE email = p_email_address;
  RETURN NULL;
END$$

CREATE OR REPLACE FUNCTION f_validate_phone_number(p_phone_number VARCHAR(255))
RETURNS VARCHAR(255)
DETERMINISTIC
BEGIN
	IF p_phone_number IS NULL OR p_phone_number = '' THEN
		RETURN 'Phone number must not be null';
	ELSEIF p_phone_number NOT REGEXP '^[0-9]{3}-[0-9]{3}-[0-9]{4}$' THEN
		RETURN 'Phone number is invalid';
	END IF;
    RETURN NULL;
END$$

CREATE OR REPLACE FUNCTION f_validate_ssn(p_ssn INT(11))
RETURNS INT(11)
DETERMINISTIC
BEGIN
	IF p_ssn IS NULL OR p_ssn = '' THEN
		RETURN 'Social Security must not be null';
	ELSEIF p_ssn NOT REGEXP '^[0-9]{9}$' THEN
		RETURN 'Social Security is invalid';
	END IF;
    RETURN NULL;
END$$

CREATE OR REPLACE FUNCTION f_validate_university_id(p_university_id INT(11))
RETURNS INT(11)
DETERMINISTIC
BEGIN
	IF p_university_id IS NULL OR p_university_id = '' THEN
		RETURN 'university_id must not be null';
	ELSEIF p_university_id NOT REGEXP '^[0-9]{9}$' THEN
		RETURN 'University ID is invalid';
	END IF;
    RETURN NULL;
END$$


DELIMITER ;