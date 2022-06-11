DROP DATABASE IF EXISTS srh_01;
CREATE DATABASE srh_01;
USE srh_01;

DROP TABLE IF EXISTS employees;
-- TABLE 1
	-- read only to employee
CREATE TABLE employees (
  emp_id INT(10) AUTO_INCREMENT,
  last_name VARCHAR(30) NOT NULL,
  middle_name VARCHAR(30),
  first_name VARCHAR(30) NOT NULL,
  gender ENUM('Male','Female','Diverse'),
  joining_date DATE,
  date_of_birth DATE,
  nationality VARCHAR(15),
  martial_status ENUM('Single','Married','Single parent'),
  children SMALLINT DEFAULT 0,
  offical_email_id VARCHAR(45) NOT NULL,
  PRIMARY KEY (emp_id)
);
ALTER TABLE employees AUTO_INCREMENT=10000;
INSERT INTO employees (last_name, middle_name, first_name, gender, joining_date, date_of_birth, nationality, martial_status, children, offical_email_id)
VALUES ('bashetty', 'r', 'pavan', 'Male', '2019-04-15', '1992-06-05', 'Indian', 'Single', 0, 'prb@gmail.com');
INSERT INTO employees (last_name, middle_name, first_name, gender, joining_date, date_of_birth, nationality, martial_status, children, offical_email_id)
VALUES ('Bandaru', '', 'Sumathi', 'FeMale', '2018-03-26', '1997-09-04', 'Indian', 'Married', 0, 'Sumathirongali@gmail.com');
INSERT INTO employees (last_name, middle_name, first_name, gender, joining_date, date_of_birth, nationality, martial_status, children, offical_email_id)
VALUES ('Cooper', 'L', 'Sheldon', 'Male', '2020-01-20', '1987-05-01', 'USA', 'Married', 0, 'sheldonC@gmail.com');
INSERT INTO employees (last_name, middle_name, first_name, gender, joining_date, date_of_birth, nationality, martial_status, children, offical_email_id)
VALUES ('Hofstder', '', 'Leonard', 'Male', '2021-11-2', '1990-02-21', 'USA', 'Married', 0, 'LeonardH@gmail.com');
INSERT INTO employees (last_name, middle_name, first_name, gender, joining_date, date_of_birth, nationality, martial_status, children, offical_email_id)
VALUES ('Fowler', 'F', 'Amy', 'Female', '2022-01-22', '1989-12-11', 'USA', 'Married', 0, 'Amyff@gmail.com');
INSERT INTO employees (last_name, middle_name, first_name, gender, joining_date, date_of_birth, nationality, martial_status, children, offical_email_id)
VALUES ('Hof', '', 'Penny', 'Female', '2019-04-14', '1986-10-1', 'USA', 'Married', 0, 'Penny@gmail.com');

INSERT INTO employees (last_name, middle_name, first_name, gender, joining_date, date_of_birth, nationality, martial_status, children, offical_email_id)
VALUES ('Mosby', '', 'Ted', 'Male', '2019-05-04', '1980-11-21', 'USA', 'Married', 0, 'TedM@gmail.com');
INSERT INTO employees (last_name, middle_name, first_name, gender, joining_date, date_of_birth, nationality, martial_status, children, offical_email_id)
VALUES ('Erikson', '', 'Marshal', 'Male', '2019-05-04', '1979-1-11', 'USA', 'Married', 0, 'MarshalE@gmail.com');
INSERT INTO employees (last_name, middle_name, first_name, gender, joining_date, date_of_birth, nationality, martial_status, children, offical_email_id)
VALUES ('Aldrin', '', 'Lily', 'Female', '2019-06-01', '1982-2-23', 'USA', 'Married', 0, 'LilyA@gmail.com');
INSERT INTO employees (last_name, middle_name, first_name, gender, joining_date, date_of_birth, nationality, martial_status, children, offical_email_id)
VALUES ('Stinson', '', 'Barney', 'Male', '2021-02-14', '1978-3-06', 'USA', 'Single', 0, 'BarneyS@gmail.com');
INSERT INTO employees (last_name, middle_name, first_name, gender, joining_date, date_of_birth, nationality, martial_status, children, offical_email_id)
VALUES ('Scherbatsky', '', 'Robin', 'Female', '2021-05-28', '1984-7-09', 'USA', 'Married', 0, 'RobinS@gmail.com');

SELECT * FROM employees;


DROP TABLE IF EXISTS emp_project;
-- TABLE 2
	-- read only to employee
CREATE TABLE emp_project (
	emp_id INT(10) NOT NULL,
	reporting_to INT(10),
	project_id VARCHAR(10),
	project_name VARCHAR(30),
    PRIMARY KEY(emp_id,project_id), -- composite primary key
    INDEX `idx_emp_project` (emp_id),
    CONSTRAINT `fk_emp_project_main` FOREIGN KEY (emp_id) REFERENCES employees(emp_id) ON UPDATE CASCADE ON DELETE RESTRICT
);
INSERT INTO emp_project VALUES(10000,10050, 'P10', 'Develop HR UI');
SELECT * FROM emp_project;

DROP TABLE IF EXISTS emp_job_title;
-- TABLE 3
	-- read only to employee
CREATE TABLE emp_job_title (
	emp_id INT(10),
	employment_status ENUM('Internal','External'),
	employment_sub_status ENUM('Full time','Part time', 'Internship', 'Working student'),
	employment_title VARCHAR(50),
	curr_job_title VARCHAR(50),
	working_status ENUM('Active','On leave','Seperated','On notice', 'Prohibition','Retired') DEFAULT NULL,
	PRIMARY KEY(emp_id),
    INDEX `idx_emp_job_title` (emp_id),
    CONSTRAINT `fk_emp_job_title_main` FOREIGN KEY (emp_id) REFERENCES employees(emp_id) ON UPDATE CASCADE ON DELETE RESTRICT
);
INSERT INTO emp_job_title VALUES(10000,'Internal', 'Full time', 'senior_staff', 'senior analyst', 'Active');
SELECT * FROM emp_job_title;


DROP TABLE IF EXISTS emp_address;
-- TABLE 4
	-- employee editing available
CREATE TABLE emp_address (
	emp_id INT(10) NOT NULL UNIQUE,
    street VARCHAR(50),
    house_num VARCHAR(10),
    pin_code DECIMAL(5,0) zerofill, -- restricted to 5 digits
    city VARCHAR(30),
    state VARCHAR(40),
    country VARCHAR(20),
    phone VARCHAR(15),
    personal_email_id VARCHAR(45),
    INDEX `idx_emp_id_address` (emp_id),
    CONSTRAINT `fk_emp_address_main` FOREIGN KEY (emp_id) REFERENCES employees(emp_id) ON UPDATE CASCADE ON DELETE RESTRICT
);
INSERT INTO emp_address VALUES(10000,'BS 13', 740, 69123, 'Heidelberg', 'BW', 'Germany', '+49 1785790081', 'abc@gmail.com');
INSERT INTO emp_address VALUES(10001,'BS 13', 740, 1923, 'Heidelberg', 'BW', 'Germany', '+49 1785790081', 'abc@gmail.com');
SELECT * FROM emp_address;


DROP TABLE IF EXISTS emp_tax_class_ref;
-- TABLE 17
	-- Its data dump
CREATE TABLE emp_tax_class_ref (
	emp_tax_class TINYINT(4) NOT NULL,
    tax_description VARCHAR(300),
    PRIMARY KEY(emp_tax_class)
);
INSERT INTO emp_tax_class_ref VALUES(1, 'Single, widowed, civil partnership, divorced, spouse living abroad or legally separated'),
								    (2, 'Single parents'),
									(3, 'Recently widowed or married with a significantly larger income that the spouse'),
                                    (4, 'Married, both spouses have a similar income'),
                                    (5, 'Married with a significantly smaller income than the spouse'),
                                    (6, 'Workers with multiple employments');
SELECT * FROM emp_tax_class_ref;



DROP TABLE IF EXISTS emp_pay;
-- TABLE 5
	-- read only to employee
CREATE TABLE emp_pay (
	emp_id INT(10),
    emp_tax_class TINYINT(4) NOT NULL,
    gross_yearly DEC(10,2),
    gross_monthly DEC(10,2),
    bonus DEC(10,2),
    job_level VARCHAR(50),
    pay_scale_group CHAR(2),
    payment_method ENUM('Weekly','Monthly'),
    PRIMARY KEY(emp_id),
    INDEX `idx_emp_id_pay` (emp_id),
    INDEX `idx_emp_tax_class_pay`(emp_tax_class),
    CONSTRAINT `fk_emp_pay_main` FOREIGN KEY (emp_id) REFERENCES employees(emp_id) ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT `fk_emp_tax_class_ref` FOREIGN KEY(emp_tax_class) REFERENCES emp_tax_class_ref(emp_tax_class) ON UPDATE CASCADE ON DELETE RESTRICT
);
INSERT INTO emp_pay VALUES(10000, 3, 36000, 3000, 2000, 'd1', 'd','Monthly');
INSERT INTO emp_pay VALUES(10001, 1, 100000, 8333.33, 5000, 'd1', 'd', 'Monthly');
INSERT INTO emp_pay VALUES(10002, 1, 50000, 4000, 3000, 'd1', 'd', 'Monthly');
INSERT INTO emp_pay VALUES(10003, 2, 96000, 8000, 4000, 'c1', 'c', 'Monthly');
UPDATE emp_pay SET gross_yearly = 80000, gross_monthly = 6666.66 WHERE emp_id = 10002;
SELECT * FROM emp_pay;
SELECT * FROM emp_tax_class_ref;

DROP TABLE IF EXISTS emp_bank_details;
-- TABLE 6
	-- employee editing available
CREATE TABLE emp_bank_details (
	emp_id INT(10),
	iban VARCHAR(20),
    bic VARCHAR(20),
    bank_name VARCHAR(15),
    PRIMARY KEY(emp_id),
    INDEX `idx_emp_id_bank_det` (emp_id),
    CONSTRAINT `fk_emp_bank_det_main` FOREIGN KEY (emp_id) REFERENCES employees(emp_id) ON UPDATE CASCADE ON DELETE RESTRICT
);
INSERT INTO emp_bank_details VALUES(10000,'IBAN11111111', 'BIC13y4343', 'Sparkasse');
SELECT * FROM emp_bank_details;


DROP TABLE IF EXISTS emp_insurance;
-- TABLE 7
	-- employee editing available
CREATE TABLE emp_insurance (
	emp_id INT(10),
	social_sec_num VARCHAR(30) NOT NULL UNIQUE,
    tax_id VARCHAR(30) NOT NULL UNIQUE,
    health_ins_type ENUM('Public','Private'),
    health_ins_id VARCHAR(30) NOT NULL UNIQUE,
    health_ins_provider VARCHAR(40),
    PRIMARY KEY(emp_id),
	INDEX `idx_emp_id_benefits` (emp_id),
    CONSTRAINT `fk_emp_benefits_main` FOREIGN KEY (emp_id) REFERENCES employees(emp_id) ON UPDATE CASCADE ON DELETE RESTRICT
);
INSERT INTO emp_insurance VALUES(10000, 'SSN123456', 'TX1234567890', 'Public', 'HI123457', 'TK');
SELECT * FROM emp_insurance;


DROP TABLE IF EXISTS emp_tax;
-- TABLE 8
	-- calculation table
	-- read only to employee
CREATE TABLE emp_tax (
	emp_id INT(10),
    solidarity_surcharge DEC(10,2) NOT NULL DEFAULT 0,
    church_tax DEC(10,2) NOT NULL DEFAULT 0,
    income_tax DEC(10,2) NOT NULL DEFAULT 0,
    total_tax DEC(10,2) NOT NULL DEFAULT 0,
    pension_insurance DEC(10,2) NOT NULL DEFAULT 0,
    unemployment_insurance DEC(10,2) NOT NULL DEFAULT 0,
    health_insurance DEC(10,2) NOT NULL DEFAULT 0,
    care_insurance DEC(10,2) NOT NULL DEFAULT 0,
    social_charges DEC(10,2) NOT NULL DEFAULT 0,
    net_monthly DEC(10,2) NOT NULL DEFAULT 0,
    PRIMARY KEY(emp_id),
	INDEX `idx_emp_id_tax` (emp_id),
    CONSTRAINT `fk_emp_tax_main` FOREIGN KEY (emp_id) REFERENCES employees(emp_id) ON UPDATE CASCADE ON DELETE RESTRICT    
);
-- INSERT INTO emp_tax VALUES(10000, 200, 100, 500, 800, 200, 200, 300, 80, 780);
SELECT * FROM emp_tax;


DROP TABLE IF EXISTS emp_payment_hist;
-- TABLE 9
	-- read only to employee
CREATE TABLE emp_payment_hist (
	emp_id INT(10) NOT NULL,
    gross_yearly INT(10),
    hike DECIMAL(6,2),
    bonus INT(10),
    finanical_year YEAR,
    PRIMARY KEY (emp_id, gross_yearly), -- composite primary key
	INDEX `idx_emp_id_pay_hist` (emp_id),
    CONSTRAINT `fk_emp_pay_hist_main` FOREIGN KEY (emp_id) REFERENCES employees(emp_id) ON UPDATE CASCADE ON DELETE RESTRICT
);
INSERT INTO emp_payment_hist VALUES(10000, 30000, 0.0, 500, 2019), (10000, 36000, 20.0, 1000, 2020);
INSERT INTO emp_payment_hist VALUES(10001, 80000, 0.0, 5000, 2019), (10001, 100000, 25.0, 10000, 2020);
SELECT * FROM emp_payment_hist;


DROP TABLE IF EXISTS emp_exp_hist;
-- TABLE 10
	-- employee editing available
CREATE TABLE emp_exp_hist (
	emp_id INT(10) NOT NULL,
    start_date DATE,
    end_date DATE,
    employer_name VARCHAR(30),
    city VARCHAR(30),
    country_key VARCHAR(10),
    domain VARCHAR(30),
    job VARCHAR(30),
    job_title VARCHAR(30),
    PRIMARY KEY(emp_id, start_date), -- composite primary key
	INDEX `idx_emp_id_exp_hist` (emp_id),
    CONSTRAINT `fk_emp_exp_hist_main` FOREIGN KEY (emp_id) REFERENCES employees(emp_id) ON UPDATE CASCADE ON DELETE RESTRICT
);
INSERT INTO emp_exp_hist VALUES(10000,'2015-04-13', '2018-10-30', 'oracle', 'bangalore', 'in', 'it', 'analyst', 'tech analyst');
SELECT * FROM emp_exp_hist;


DROP TABLE IF EXISTS emp_education;
-- TABLE 11
	-- employee editing available
CREATE TABLE emp_education (
	emp_id INT(10) NOT NULL,
    education_type ENUM('Diploma','Bachelors','Masters','PhD') ,
    start_date DATE,
    end_date DATE,
    country VARCHAR(30),
    institute_name VARCHAR(60),
    major VARCHAR(20),
    grade DEC(4,2),
    PRIMARY KEY(emp_id, education_type), -- composite primary key
	INDEX `idx_emp_id_edu` (emp_id),
    CONSTRAINT `fk_emp_edu_main` FOREIGN KEY (emp_id) REFERENCES employees(emp_id) ON UPDATE CASCADE ON DELETE RESTRICT
);
INSERT INTO emp_education VALUES(10000, 'Bachelors','2010-08-10','2014-05-30','india','PESIT','ECE', 3),
							    (10000, 'Masters','2022-04-01','2024-04-30','germany','SRH','ACS',2),
							    (10001,'Bachelors','2010-08-10','2014-05-30','india','RIT','ECE', 1.5);
SELECT * FROM emp_education;


DROP TABLE IF EXISTS emp_vacation;
-- TABLE 12
	-- employee editing available
CREATE TABLE emp_vacation (
	emp_id INT(10) NOT NULL,
    start_date DATE,
    end_date DATE,
    leave_type ENUM('Casual','Sick','Annual','parental','Volunteering'),
    vacation_status ENUM('Pending','Approved','Rejected'),
    leave_note VARCHAR(100),
    PRIMARY KEY(emp_id, start_date), -- composite primary key
 	INDEX `idx_emp_id_vacay` (emp_id),
    CONSTRAINT `fk_emp_vacay_main` FOREIGN KEY (emp_id) REFERENCES employees(emp_id) ON UPDATE CASCADE ON DELETE RESTRICT   
);
INSERT INTO emp_vacation VALUES(10000, '2021-01-01', '2021-01-10', 'Annual', 'Approved', 'annual vacation'),
							   (10000, '2021-10-05', '2021-10-07', 'Casual', 'Rejected', 'casual vacation');
SELECT * FROM emp_vacation;


DROP TABLE IF EXISTS emp_leave_balance;
-- TABLE 13
	-- This table needs to be updated eveytime a leave is approved and all but annual leave need to hit reset on Jan-01 every year.
		-- Few columns will be kept with constant values.
	-- read only to employee
CREATE TABLE emp_leave_balance (
	emp_id INT(10),
    casual_leaves TINYINT(4) DEFAULT 12,
    sick_leaves TINYINT(4) DEFAULT 11,
    Annual_leaves TINYINT(4) DEFAULT 24,
    parental_leaves INT(10) DEFAULT 365, -- changed materenity and paternity to one column called "parental"
    volunteering_leaves TINYINT(4) DEFAULT 4,
    financial_year YEAR,
    PRIMARY KEY(emp_id),
 	INDEX `idx_emp_id_leave_bal` (emp_id),
    CONSTRAINT `fk_emp_leave_bal_main` FOREIGN KEY (emp_id) REFERENCES employees(emp_id) ON UPDATE CASCADE ON DELETE RESTRICT 
);
INSERT INTO emp_leave_balance(emp_id, financial_year) VALUES(10000,2022), (10001,2022), (10002,2022), (10003,2022), (10004,2022);
INSERT INTO emp_leave_balance(emp_id, financial_year) VALUES(10005,2022), (10006,2022), (10007,2022), (10008,2022), (10009,2022), (10010,2022);
SELECT * FROM emp_leave_balance;
SELECT * FROM employees;

DROP TABLE IF EXISTS emp_family;
-- TABLE 14
	-- employee editing available
CREATE TABLE emp_family (
	emp_id INT(10) NOT NULL,
    last_name VARCHAR(30),
    first_name VARCHAR(30),
    gender ENUM('Male','Female','Diverse'),
    relation ENUM('Mother','Father','Children','Spouse'),
    date_of_birth DATE,
    nationality VARCHAR(30),
    PRIMARY KEY(emp_id, last_name, first_name), -- composite primary key
 	INDEX `idx_emp_id_emp_family` (emp_id),
    CONSTRAINT `fk_emp_emp_family_main` FOREIGN KEY (emp_id) REFERENCES employees(emp_id) ON UPDATE CASCADE ON DELETE RESTRICT 
);
INSERT INTO emp_family VALUES(10000,'bashetty','jayashree','Female','Mother', '1970-01-01','indian');
SELECT * FROM emp_family;


DROP TABLE IF EXISTS equipments;
-- TABLE 15
	-- read only to employee
CREATE TABLE equipments (
	emp_id INT(10) NOT NULL,
    equipment_type ENUM('Hardware','Software'),
    equip_id_num INT(15),
    equip_name VARCHAR(40),
    equip_borrowed_date DATE,
    PRIMARY KEY(emp_id, equip_name, equip_borrowed_date), -- composite primary key
 	INDEX `idx_emp_id_equipments` (emp_id),
    CONSTRAINT `fk_emp_equipments_main` FOREIGN KEY (emp_id) REFERENCES employees(emp_id) ON UPDATE CASCADE ON DELETE RESTRICT 
);    
INSERT INTO equipments VALUES(10000,'Hardware', 123456, 'monitor', '2020-05-04');
INSERT INTO equipments VALUES(10000,'Software', 123457, 'DBMS', '2020-05-25');
INSERT INTO equipments VALUES(10000,'Hardware', 123456, 'monitor', '2020-06-04');
-- INSERT INTO equipments VALUES(10000,'Hardware', 123456, 'monitor', '2020-05-04'); -- Will throw error
SELECT * FROM equipments;


DROP TABLE IF EXISTS country_code_ref;
-- TABLE 16
	-- Its data dump
CREATE TABLE country_code_ref (
	country_key VARCHAR(10) NOT NULL,
    country_name VARCHAR(60) NOT NULL
);
-- INSERT table is at the end





DROP TABLE IF EXISTS emp_payscale_ref;
-- TABLE 18
	-- Its data dump
CREATE TABLE emp_payscale_ref (
	pay_scale_group CHAR(2) NOT NULL,
    title VARCHAR(50),
    employment_title VARCHAR(50),
    job_level VARCHAR(50),
    min_salary_range INT(10),
    max_salary_range INT(10)
);
INSERT INTO emp_payscale_ref VALUES('A','executive management','CEO','A1',100001,150000),
								   ('A','executive management','senior_executive','A2',100001,150000),
								   ('A','executive management','executive','A3',100001,150000),
                                   ('B','middle management','senior director','B1',70001,100000),
                                   ('B','middle management','director','B2',70001,100000),
                                   ('C','manager advisors','senior manager','C1',40001,70000),
                                   ('C','manager advisors','senior advisor','C2',40001,70000),
                                   ('C','manager advisors','manager','C3',40001,70000),
                                   ('C','manager advisors','advisor','C4',40001,70000),
                                   ('D','staff','senior staff','D1',10000,40000),
                                   ('D','staff','intermediate','D2',10000,40000),
                                   ('D','staff','associate','D3',10000,40000),
                                   ('H','middle management','HR','H1',70001,100000);
SELECT * FROM emp_payscale_ref;
-- SELECT * FROM emp_job_title;

DROP TABLE IF EXISTS project_contracts;
-- TABLE 19
	-- contracts table
	-- not visisble to internal employees
CREATE TABLE project_contracts (
	project_id VARCHAR(10),
	project_name VARCHAR(30),
    reporting_to INT(10),
    project_budget INT(10),
    start_date DATE,
    end_date date,
    stakeholder_id VARCHAR(10),
    stakeholder_name VARCHAR(40),
    PRIMARY KEY(project_id, reporting_to, start_Date) -- composite primary key
);
INSERT INTO project_contracts VALUES ('p10','Develop HR UI', 10050, 5000, '2022-05-15', '2022-06-15', 's01', 'SRH');
SELECT * FROM project_contracts;


DROP TABLE IF EXISTS admin_contracts;
-- TABLE 20
	-- contracts table 2
	-- not visible to internal employees
CREATE TABLE admin_contracts (
	contract_type VARCHAR(10),
    contract_id VARCHAR(5),
    contract_manager VARCHAR(40),
    start_date DATE,
    end_date DATE,
    contract_workers INT(5),
    contract_budget INT(10),
    PRIMARY KEY(contract_id)
);
INSERT INTO admin_contracts VALUES('Food', 'A1', 'Maraeck', '2022-01-01', '2022-06-01', 15, 10500);
SELECT * FROM admin_contracts;


DROP TABLE IF EXISTS login;
-- TABLE 21
	-- login table
CREATE TABLE login (
	emp_id INT(10),
    password VARCHAR(50),
    PRIMARY KEY (emp_id),
    INDEX `idx_emp_login` (emp_id),
    CONSTRAINT `fk_emp_login_main` FOREIGN KEY (emp_id) REFERENCES employees(emp_id) ON UPDATE CASCADE ON DELETE RESTRICT
);
INSERT INTO login VALUES(10000, md5('one'));
SELECT * FROM login;



INSERT INTO country_code_ref VALUES ('af','afghanistan'),
('al','albania'),
('dz','algeria'),
('as','american samoa'),
('ad','andorra'),
('ao','angola'),
('ai','anguilla'),
('aq','antarctica'),
('ag','antigua and barbuda'),
('ar','argentina'),
('am','armenia'),
('aw','aruba'),
('au','australia'),
('at','austria'),
('az','azerbaijan'),
('bs','bahamas'),
('bh','bahrain'),
('bd','bangladesh'),
('bb','barbados'),
('by','belarus'),
('be','belgium'),
('bz','belize'),
('bj','benin'),
('bm','bermuda'),
('bt','bhutan'),
('bo','bolivia'),
('ba','bosnia and herzegovina'),
('bw','botswana'),
('bv','bouvet island'),
('br','brazil'),
('io','british indian ocean territory'),
('bn','brunei darussalam'),
('bg','bulgaria'),
('bf','burkina faso'),
('bi','burundi'),
('kh','cambodia'),
('cm','cameroon'),
('ca','canada'),
('cv','cape verde'),
('ky','cayman islands'),
('cf','central african republic'),
('td','chad'),
('cl','chile'),
('cn','china'),
('cx','christmas island'),
('cc','cocos (keeling) islands'),
('co','colombia'),
('km','comoros'),
('cg','congo'),
('cd','congo'),
('ck','cook islands'),
('cr','costa rica'),
('ci','cote d'),
('hr','croatia'),
('cu','cuba'),
('cy','cyprus'),
('cz','czech republic'),
('dk','denmark'),
('dj','djibouti'),
('dm','dominica'),
('do','dominican republic'),
('ec','ecuador'),
('eg','egypt'),
('sv','el salvador'),
('gq','equatorial guinea'),
('er','eritrea'),
('ee','estonia'),
('et','ethiopia'),
('fk','falkland islands (malvinas)'),
('fo','faroe islands'),
('fj','fiji'),
('fi','finland'),
('fr','france'),
('gf','french guiana'),
('pf','french polynesia'),
('tf','french southern territories'),
('ga','gabon'),
('gm','gambia'),
('ge','georgia'),
('de','germany'),
('gh','ghana'),
('gi','gibraltar'),
('gr','greece'),
('gl','greenland'),
('gd','grenada'),
('gp','guadeloupe'),
('gu','guam'),
('gt','guatemala'),
('gn','guinea'),
('gw','guinea-bissau'),
('gy','guyana'),
('ht','haiti'),
('hm','heard island and mcdonald islands'),
('va','holy see (vatican city state)'),
('hn','honduras'),
('hk','hong kong'),
('hu','hungary'),
('is','iceland'),
('in','india'),
('id','indonesia'),
('ir','iran'),
('iq','iraq'),
('ie','ireland'),
('il','israel'),
('it','italy'),
('jm','jamaica'),
('jp','japan'),
('jo','jordan'),
('kz','kazakhstan'),
('ke','kenya'),
('ki','kiribati'),
('kp','korea'),
('kr','korea'),
('kw','kuwait'),
('kg','kyrgyzstan'),
('la','lao people'),
('lv','latvia'),
('lb','lebanon'),
('ls','lesotho'),
('lr','liberia'),
('ly','libyan arab jamahiriya'),
('li','liechtenstein'),
('lt','lithuania'),
('lu','luxembourg'),
('mo','macao'),
('mk','macedonia'),
('mg','madagascar'),
('mw','malawi'),
('my','malaysia'),
('mv','maldives'),
('ml','mali'),
('mt','malta'),
('mh','marshall islands'),
('mq','martinique'),
('mr','mauritania'),
('mu','mauritius'),
('yt','mayotte'),
('mx','mexico'),
('fm','micronesia'),
('md','moldova'),
('mc','monaco'),
('mn','mongolia'),
('ms','montserrat'),
('ma','morocco'),
('mz','mozambique'),
('mm','myanmar'),
('na','namibia'),
('nr','nauru'),
('np','nepal'),
('nl','netherlands'),
('an','netherlands antilles'),
('nc','new caledonia'),
('nz','new zealand'),
('ni','nicaragua'),
('ne','niger'),
('ng','nigeria'),
('nu','niue'),
('nf','norfolk island'),
('mp','northern mariana islands'),
('no','norway'),
('om','oman'),
('pk','pakistan'),
('pw','palau'),
('ps','palestinian territory'),
('pa','panama'),
('pg','papua new guinea'),
('py','paraguay'),
('pe','peru'),
('ph','philippines'),
('pn','pitcairn'),
('pl','poland'),
('pt','portugal'),
('pr','puerto rico'),
('qa','qatar'),
('re','reunion'),
('ro','romania'),
('ru','russian federation'),
('rw','rwanda'),
('sh','saint helena'),
('kn','saint kitts and nevis'),
('lc','saint lucia'),
('pm','saint pierre and miquelon'),
('vc','saint vincent and the grenadines'),
('ws','samoa'),
('sm','san marino'),
('st','sao tome and principe'),
('sa','saudi arabia'),
('sn','senegal'),
('cs','serbia and montenegro'),
('sc','seychelles'),
('sl','sierra leone'),
('sg','singapore'),
('sk','slovakia'),
('si','slovenia'),
('sb','solomon islands'),
('so','somalia'),
('za','south africa'),
('gs','south georgia and the south sandwich islands'),
('es','spain'),
('lk','sri lanka'),
('sd','sudan'),
('sr','suriname'),
('sj','svalbard and jan mayen'),
('sz','swaziland'),
('se','sweden'),
('ch','switzerland'),
('sy','syrian arab republic'),
('tw','taiwan'),
('tj','tajikistan'),
('tz','tanzania'),
('th','thailand'),
('tl','timor-leste'),
('tg','togo'),
('tk','tokelau'),
('to','tonga'),
('tt','trinidad and tobago'),
('tn','tunisia'),
('tr','turkey'),
('tm','turkmenistan'),
('tc','turks and caicos islands'),
('tv','tuvalu'),
('ug','uganda'),
('ua','ukraine'),
('ae','united arab emirates'),
('gb','united kingdom'),
('us','united states'),
('um','united states minor outlying islands'),
('uy','uruguay'),
('uz','uzbekistan'),
('vu','vanuatu'),
('ve','venezuela'),
('vn','viet nam'),
('vg','virgin islands'),
('vi','virgin islands'),
('wf','wallis and futuna'),
('eh','western sahara'),
('ye','yemen'),
('zm','zambia'),
('zw','zimbabwe');

    
