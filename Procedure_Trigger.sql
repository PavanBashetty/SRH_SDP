-- TRIGGER 1 FOR EMPLOYEE PAYMENT_TAX TABLE
USE srh_01;
SHOW TRIGGERS LIKE 'emp_pay';

DROP TRIGGER IF EXISTS srh_01.empPayInsert;
DELIMITER //
CREATE TRIGGER srh_01.empPayInsert 
AFTER INSERT ON emp_pay FOR EACH ROW
BEGIN
DECLARE Tri_empID INT(10);
DECLARE Tri_empTaxClass INT(4);
DECLARE Tri_grossMonthly DEC(10,2);

SET Tri_empID = NEW.emp_id;
SET Tri_empTaxClass = NEW.emp_tax_class;
SET Tri_grossMonthly = NEW.gross_monthly;
call tax_deductions(Tri_empID, Tri_empTaxClass, Tri_grossMonthly); 
END //
DELIMITER ;

-- TRIGGER 2 FOR EMPLOYEE PAYMENT_TAX TABLE
DROP TRIGGER IF EXISTS srh_01.empPayUpdate;
DELIMITER //
CREATE TRIGGER srh_01.empPayUpdate
AFTER UPDATE ON srh_01.emp_pay FOR EACH ROW
BEGIN
DECLARE Tri_empID INT(10);
DECLARE Tri_empTaxClass INT(4);
DECLARE Tri_grossMonthly DEC(10,2);

SET Tri_empID = NEW.emp_id;
SET Tri_empTaxClass = NEW.emp_tax_class;
SET Tri_grossMonthly = NEW.gross_monthly;
call tax_deductions(Tri_empID, Tri_empTaxClass, Tri_grossMonthly); 
END //
DELIMITER ;


-- Stored Procedure to calculate tax deductions

DROP PROCEDURE IF EXISTS tax_deductions;
DELIMITER //

CREATE PROCEDURE tax_deductions(IN empID INT(10), IN empTaxClass INT(4), IN gross_monthly INT(10))
BEGIN


DECLARE Pro_Solidarity_surcharge DEC(10,2);
DECLARE Pro_chruch_tax DEC(10,2);
DECLARE Pro_income_tax DEC(10,2);
DECLARE Pro_Pension_insurance DEC(10,2);
DECLARE Pro_Unemployment_insurance DEC(10,2);
DECLARE Pro_Health_insurance DEC(10,2);
DECLARE Pro_Care_insurance DEC(10,2);
DECLARE Pro_total_tax DEC(10,2);
DECLARE Pro_social_charges DEC(10,2);
DECLARE Pro_netSal DEC(10,2);

DELETE FROM emp_tax WHERE emp_id = empID;

IF empTaxClass = 1 THEN

SET Pro_Solidarity_surcharge = gross_monthly * 0;
SET Pro_chruch_tax = gross_monthly * 0.005;
SET Pro_income_tax = gross_monthly * 0.054;
SET Pro_total_tax = Pro_Solidarity_surcharge + Pro_chruch_tax + Pro_income_tax;

SET Pro_Pension_insurance = gross_monthly * 0.113;
SET Pro_Unemployment_insurance = gross_monthly * 0.015;
SET Pro_Health_insurance = gross_monthly * 0.095;
SET Pro_Care_insurance = gross_monthly * 0.018;
SET Pro_social_charges = Pro_Pension_insurance + Pro_Unemployment_insurance + Pro_Health_insurance + Pro_Care_insurance;
SET Pro_netSal = gross_monthly - Pro_total_tax - Pro_social_charges;

INSERT INTO emp_tax VALUES(empID, Pro_Solidarity_surcharge, Pro_chruch_tax, Pro_income_tax, Pro_total_tax, Pro_Pension_insurance, 
							Pro_Unemployment_insurance, Pro_Health_insurance, Pro_Care_insurance, Pro_social_charges, Pro_netSal);


ELSEIF empTaxClass = 2 THEN

SET Pro_Solidarity_surcharge = gross_monthly * 0;
SET Pro_chruch_tax = gross_monthly * 0.004;
SET Pro_income_tax = gross_monthly * 0.045;
SET Pro_total_tax = Pro_Solidarity_surcharge + Pro_chruch_tax + Pro_income_tax;

SET Pro_Pension_insurance = gross_monthly * 0.094;
SET Pro_Unemployment_insurance = gross_monthly * 0.012;
SET Pro_Health_insurance = gross_monthly * 0.079;
SET Pro_Care_insurance = gross_monthly * 0.015;
SET Pro_social_charges = Pro_Pension_insurance + Pro_Unemployment_insurance + Pro_Health_insurance + Pro_Care_insurance;
SET Pro_netSal = gross_monthly - Pro_total_tax - Pro_social_charges;

INSERT INTO emp_tax VALUES(empID, Pro_Solidarity_surcharge, Pro_chruch_tax, Pro_income_tax, Pro_total_tax, Pro_Pension_insurance, 
							Pro_Unemployment_insurance, Pro_Health_insurance, Pro_Care_insurance, Pro_social_charges, Pro_netSal);


ELSEIF empTaxClass = 3 THEN

SET Pro_Solidarity_surcharge = gross_monthly * 0;
SET Pro_chruch_tax = gross_monthly * 0.003;
SET Pro_income_tax = gross_monthly * 0.036;
SET Pro_total_tax = Pro_Solidarity_surcharge + Pro_chruch_tax + Pro_income_tax;

SET Pro_Pension_insurance = gross_monthly * 0.075;
SET Pro_Unemployment_insurance = gross_monthly * 0.010;
SET Pro_Health_insurance = gross_monthly * 0.063;
SET Pro_Care_insurance = gross_monthly * 0.012;
SET Pro_social_charges = Pro_Pension_insurance + Pro_Unemployment_insurance + Pro_Health_insurance + Pro_Care_insurance;
SET Pro_netSal = gross_monthly - Pro_total_tax - Pro_social_charges;

INSERT INTO emp_tax VALUES(empID, Pro_Solidarity_surcharge, Pro_chruch_tax, Pro_income_tax, Pro_total_tax, Pro_Pension_insurance, 
							Pro_Unemployment_insurance, Pro_Health_insurance, Pro_Care_insurance, Pro_social_charges, Pro_netSal);


ELSEIF empTaxClass = 4 THEN

SET Pro_Solidarity_surcharge = gross_monthly * 0;
SET Pro_chruch_tax = gross_monthly * 0.005;
SET Pro_income_tax = gross_monthly * 0.054;
SET Pro_total_tax = Pro_Solidarity_surcharge + Pro_chruch_tax + Pro_income_tax;

SET Pro_Pension_insurance = gross_monthly * 0.113;
SET Pro_Unemployment_insurance = gross_monthly * 0.015;
SET Pro_Health_insurance = gross_monthly * 0.095;
SET Pro_Care_insurance = gross_monthly * 0.018;
SET Pro_social_charges = Pro_Pension_insurance + Pro_Unemployment_insurance + Pro_Health_insurance + Pro_Care_insurance;
SET Pro_netSal = gross_monthly - Pro_total_tax - Pro_social_charges;

INSERT INTO emp_tax VALUES(empID, Pro_Solidarity_surcharge, Pro_chruch_tax, Pro_income_tax, Pro_total_tax, Pro_Pension_insurance, 
							Pro_Unemployment_insurance, Pro_Health_insurance, Pro_Care_insurance, Pro_social_charges, Pro_netSal);


ELSEIF empTaxClass = 5 THEN

SET Pro_Solidarity_surcharge = gross_monthly * 0;
SET Pro_chruch_tax = gross_monthly * 0.007;
SET Pro_income_tax = gross_monthly * 0.073;
SET Pro_total_tax = Pro_Solidarity_surcharge + Pro_chruch_tax + Pro_income_tax;

SET Pro_Pension_insurance = gross_monthly * 0.150;
SET Pro_Unemployment_insurance = gross_monthly * 0.019;
SET Pro_Health_insurance = gross_monthly * 0.127;
SET Pro_Care_insurance = gross_monthly * 0.025;
SET Pro_social_charges = Pro_Pension_insurance + Pro_Unemployment_insurance + Pro_Health_insurance + Pro_Care_insurance;
SET Pro_netSal = gross_monthly - Pro_total_tax - Pro_social_charges;

INSERT INTO emp_tax VALUES(empID, Pro_Solidarity_surcharge, Pro_chruch_tax, Pro_income_tax, Pro_total_tax, Pro_Pension_insurance, 
							Pro_Unemployment_insurance, Pro_Health_insurance, Pro_Care_insurance, Pro_social_charges, Pro_netSal);


ELSE 

SET Pro_Solidarity_surcharge = gross_monthly * 0;
SET Pro_chruch_tax = gross_monthly * 0.007;
SET Pro_income_tax = gross_monthly * 0.076;
SET Pro_total_tax = Pro_Solidarity_surcharge + Pro_chruch_tax + Pro_income_tax;

SET Pro_Pension_insurance = gross_monthly * 0.158;
SET Pro_Unemployment_insurance = gross_monthly * 0.020;
SET Pro_Health_insurance = gross_monthly * 0.133;
SET Pro_Care_insurance = gross_monthly * 0.026;
SET Pro_social_charges = Pro_Pension_insurance + Pro_Unemployment_insurance + Pro_Health_insurance + Pro_Care_insurance;
SET Pro_netSal = gross_monthly - Pro_total_tax - Pro_social_charges;

INSERT INTO emp_tax VALUES(empID, Pro_Solidarity_surcharge, Pro_chruch_tax, Pro_income_tax, Pro_total_tax, Pro_Pension_insurance, 
							Pro_Unemployment_insurance, Pro_Health_insurance, Pro_Care_insurance, Pro_social_charges, Pro_netSal);


END IF;
END //

DELIMITER ;

-- --------------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------------


-- TRIGGER1 FOR EMPLOYEE LEAVES

SHOW TRIGGERS LIKE 'emp_vacation';

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

-- TRIGGER2 FOR EMPLOYEE LEAVES

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

-- --------------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------------

-- TRIGGER 3 FOR EMPLOYEE Job_Title TABLE - Working Status insert
DROP TRIGGER IF EXISTS srh_01.empJobTitleInsert;
DELIMITER //
CREATE TRIGGER srh_01.empJobTitleInsert
AFTER INSERT ON employees FOR EACH ROW
BEGIN
DECLARE New_empID INT(10);
DECLARE New_WorkingStatus VARCHAR(50);



SET New_empID = NEW.emp_id;
SET New_WorkingStatus = 'Active';


INSERT INTO srh_01.emp_job_title (emp_id, working_status) VALUES (New_empID, New_WorkingStatus);
END //
DELIMITER ;
