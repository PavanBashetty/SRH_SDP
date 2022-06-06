-- CREATE TRIGGER
USE srh_01;
DELIMITER //
CREATE TRIGGER srh_01.empPayInsert 
AFTER INSERT ON srh_01.emp_pay FOR EACH ROW -- in servlet, if we write there, we can take IN values right from there
BEGIN
call tax_deductions(emp_pay.emp_id, emp_pay.emp_tax_class, emp_pay.gross_monthly); 
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER srh_01.empPayUpdate
AFTER UPDATE ON srh_01.emp_pay FOR EACH ROW -- in servlet
BEGIN
call tax_deductions(emp_pay.emp_id, emp_pay.emp_tax_class, emp_pay.gross_monthly);
END //
DELIMITER ;


-- Stored Procedure to calculate tax deductions

DROP PROCEDURE IF EXISTS tax_deductions;
DELIMITER //

CREATE PROCEDURE tax_deductions(IN empID INT(10), IN empTaxClass INT(4), IN gross_monthly INT(10))
-- call tax_deductions(10000, 3, 3000);
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

SELECT * FROM emp_pay;
SELECT * FROM emp_tax;

-- INSERT INTO emp_pay VALUES(10001, 48000, 4000, 3000, 'c2', 'c', 'Monthly');
call tax_deductions(10000, 3, 3000);