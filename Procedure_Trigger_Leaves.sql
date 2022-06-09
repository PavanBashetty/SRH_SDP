-- CREATE TRIGGER FOR EMPLOYEE LEAVES
USE srh_01;
SHOW TRIGGERS LIKE 'emp_pay';

-- CREATE TRIGGER FOR EMPLOYEE LEAVES
DROP TRIGGER IF EXISTS srh_01.empVacationInsert;
DELIMITER //
CREATE TRIGGER srh_01.empVacationInsert
AFTER INSERT ON emp_vacation FOR EACH ROW
empVac:	BEGIN
DECLARE Leave_empID INT(10);
DECLARE Leave_vacation_status VARCHAR(10);
DECLARE Leave_l_type VARCHAR(10);
DECLARE Leave_start_date DATE;
DECLARE Leave_end_date DATE;

SET Leave_empID = NEW.emp_id;
SET Leave_vacation_status = NEW.vacation_status;
SET Leave_l_type = NEW.leave_type;
SET Leave_start_date = NEW.start_date;
SET Leave_end_date = NEW.end_date;

IF(Leave_vacation_status = 'Rejected' OR Leave_vacation_status = 'Pending') THEN
	LEAVE empVac;
ELSE
	call calcul_RemainingLeaves(Leave_empID, Leave_l_type, Leave_start_date, Leave_end_date);
END IF;
END //
DELIMITER ; 


DROP TRIGGER IF EXISTS srh_01.empVacationUpdate;
DELIMITER //
CREATE TRIGGER srh_01.empVacationUpdate
AFTER UPDATE ON emp_vacation FOR EACH ROW
empVacUpdate: BEGIN
DECLARE Leave_empID INT(10);
DECLARE Leave_vacation_status VARCHAR(10);
DECLARE Leave_l_type VARCHAR(10);
DECLARE Leave_start_date DATE;
DECLARE Leave_end_date DATE;

SET Leave_empID = NEW.emp_id;
SET Leave_vacation_status = NEW.vacation_status;
SET Leave_l_type = NEW.leave_type;
SET Leave_start_date = NEW.start_date;
SET Leave_end_date = NEW.end_date;
IF(Leave_vacation_status = 'Approved') THEN
	call calcul_RemainingLeaves(Leave_empID, Leave_l_type, Leave_start_date, Leave_end_date);
ELSE
	LEAVE empVacUpdate;
END IF;
END //
DELIMITER ;

-- Stored Procedure to calculate remaining leaves

DROP PROCEDURE IF EXISTS calcul_RemainingLeaves;
DELIMITER //

CREATE PROCEDURE calcul_RemainingLeaves(IN empID INT(10), IN leave_type VARCHAR(10), IN start_date DATE, IN end_date DATE)
BEGIN

DECLARE Pro_casual_leaves TINYINT(4);
DECLARE Pro_sick_leaves TINYINT(4);
DECLARE Pro_Annual_leaves TINYINT(4);
DECLARE Pro_parental_leaves TINYINT(4);
DECLARE Pro_volunteering_leaves TINYINT(4);
DECLARE Pro_leave_type VARCHAR(10);
DECLARE Pro_date_difference INT(5);
-- DELETE FROM emp_leave_balance WHERE emp_id = empID;

SET Pro_date_difference = DATEDIFF(end_date, start_date);
SET Pro_leave_type = leave_type;

IF Pro_leave_type = 'Annual' THEN
SET Pro_Annual_leaves = Pro_date_difference;
UPDATE emp_leave_balance SET Annual_leaves = (Annual_leaves - Pro_Annual_leaves) WHERE emp_id = empID;

ELSEIF Pro_leave_type = 'Casual' THEN
SET Pro_casual_leaves = Pro_date_difference;
UPDATE emp_leave_balance SET casual_leaves = (casual_leaves - Pro_casual_leaves) WHERE emp_id = empID;

ELSEIF Pro_leave_type = 'Sick' THEN
SET Pro_sick_leaves = Pro_date_difference;
UPDATE emp_leave_balance SET sick_leaves = (sick_leaves - Pro_sick_leaves) WHERE emp_id = empID;

ELSEIF Pro_leave_type = 'Volunteering' THEN
SET Pro_volunteering_leaves = Pro_date_difference;
UPDATE emp_leave_balance SET volunteering_leaves = (volunteering_leaves - Pro_volunteering_leaves) WHERE emp_id = empID;

ELSE
SET Pro_parental_leaves = Pro_date_difference;
UPDATE emp_leave_balance SET parental_leaves = (parental_leaves - Pro_parental_leaves) WHERE emp_id = empID;

END IF; 
END //
DELIMITER ; 

