
IF OBJECT_ID('ASSIGNMENTSS', 'U') IS NOT NULL
    DROP TABLE ASSIGNMENTSS;

IF OBJECT_ID('PROJECTSS', 'U') IS NOT NULL
    DROP TABLE PROJECTSS;

IF OBJECT_ID('EMPLOYEESS', 'U') IS NOT NULL
    DROP TABLE EMPLOYEESS;

IF OBJECT_ID('JOBSS', 'U') IS NOT NULL
    DROP TABLE JOBSS;

CREATE TABLE JOBSS(
    JOB_CODE CHAR(3) NOT NULL,
    JOB_DESCRIPTION VARCHAR(30),
    JOB_CHG_HOUR NUMERIC(6,2),
    JOB_LAST_UPDATE DATE,
    PRIMARY KEY(JOB_CODE)
);

CREATE TABLE EMPLOYEESS(
    EMP_NUM CHAR(3) NOT NULL,
    EMP_LNAME VARCHAR(30),
    EMP_FNAME VARCHAR(30),
    EMP_INITIAL VARCHAR(5),
    EMP_HIREDATE DATE,
    JOB_CODE CHAR(3) NOT NULL,
    PRIMARY KEY (EMP_NUM),
    FOREIGN KEY (JOB_CODE) REFERENCES JOBSS(JOB_CODE)
);

CREATE TABLE PROJECTSS(
    PROJ_NUM CHAR(3) NOT NULL,
    PROJ_NAME VARCHAR(30),
    PROJ_VALUE NUMERIC(10,2),
    PROJ_BALANCE NUMERIC(10,2),
    EMP_NUM CHAR(3) NOT NULL,
    PRIMARY KEY (PROJ_NUM),
    FOREIGN KEY (EMP_NUM) REFERENCES EMPLOYEESS(EMP_NUM)
);

CREATE TABLE ASSIGNMENTSS(
    ASSIGN_NUM CHAR(4) NOT NULL,
    ASSIGN_DATE DATE,
    ASSIGN_JOB VARCHAR(30),
    ASSIGN_CHG_HR VARCHAR(30),
    ASSIGN_HOURS INT,
    ASSIGN_CHARGE NUMERIC(10,2),
    EMP_NUM CHAR(3) NOT NULL,
    PROJ_NUM CHAR(3) NOT NULL,
    PRIMARY KEY (ASSIGN_NUM),
    FOREIGN KEY (EMP_NUM) REFERENCES EMPLOYEESS(EMP_NUM),
    FOREIGN KEY (PROJ_NUM) REFERENCES PROJECTSS(PROJ_NUM)
);

IF NOT EXISTS (SELECT 1 FROM JOBSS WHERE JOB_CODE = '500')
BEGIN
INSERT INTO JOBSS VALUES  
    ('500', 'Programmer', 35.75, '20-Nov-2017'),
    ('501', 'Systems Analyst', 96.75, '20-Nov-2017'),
    ('502', 'Database Designer', 125.00, '21-Mar-2018'),
    ('503', 'Electrical Engineer', 84.50, '20-Nov-2017'),
    ('504', 'Mechanical Engineer', 67.90, '20-Nov-2017'),
    ('505', 'Civil Engineer', 55.78, '20-Nov-2017'),
    ('506', 'Clerical Support', 26.87, '20-Nov-2017'),
    ('507', 'DSS Analyst', 45.95, '20-Nov-2017'),
    ('508', 'Applications Designer', 48.10, '21-Mar-2018'),
    ('509', 'Bio Technician', 34.55, '20-Nov-2017'),
    ('510', 'General Support', 18.36, '20-Nov-2017');
END

INSERT INTO EMPLOYEESS(EMP_NUM, EMP_LNAME, EMP_FNAME, EMP_INITIAL, EMP_HIREDATE, JOB_CODE)
VALUES
    ('101', 'News', 'John', 'G', '2000-11-08', '502'),
    ('102', 'Senior', 'David', 'H', '1989-07-12', '501'),
    ('103', 'Arbough', 'June', 'E', '1996-12-01', '500'),
    ('104', 'Ramoras', 'Anne', 'K', '1987-11-15', '501'),
    ('105', 'Johnston', 'Alice', 'K', '1993-02-01', '502'),
    ('106', 'Smithfield', 'William', NULL, '2004-06-22', '500'),
    ('107', 'Alonzo', 'Maria', 'D', '1993-10-10', '500'),
    ('108', 'Washington', 'Ralph', 'B', '1991-08-22', '501'),
    ('109', 'Smith', 'Larry', 'W', '1997-07-18', '501'),
    ('110', 'Olenko', 'Gerald', 'A', '1995-12-11', '505'),
    ('111', 'Wabash', 'Geoff', 'B', '1991-04-04', '506'),
    ('112', 'Smithson', 'Darlene', 'M', '1994-10-23', '507'),
    ('113', 'Joenbrood', 'Delbert', 'K', '1996-11-15', '508'),
    ('114', 'Jones', 'Annelise', NULL, '1993-08-20', '508'),
    ('115', 'Bawangi', 'Travis', 'B', '1992-01-25', '501'),
    ('116', 'Pratt', 'Gerald', 'L', '1997-03-05', '510'),
    ('117', 'Williamson', 'Angie', 'H', '1996-06-19', '509'),
    ('118', 'Frommer', 'James', 'J', '2005-01-04', '510');

INSERT INTO PROJECTSS (PROJ_NUM, PROJ_NAME, PROJ_VALUE, PROJ_BALANCE, EMP_NUM)
VALUES
    ('15', 'Evergreen', 1453500.00, 1002350.00, '103'),
    ('18', 'Amber Wave', 3500500.00, 2110346.00, '108'),
    ('22', 'Rolling Tide', 805000.00, 500345.20, '102'),
    ('25', 'Star flight', 2650500.00, 2309880.00, '107');

INSERT INTO ASSIGNMENTSS(ASSIGN_NUM, ASSIGN_DATE, PROJ_NUM, EMP_NUM, 
    ASSIGN_JOB, ASSIGN_CHG_HR, ASSIGN_HOURS, ASSIGN_CHARGE)
VALUES 
    ('1001', '2018-03-22', '18', '103', '500', 35.75, 3.5, 125.13),
    ('1002', '2018-03-22', '22', '117', '509', 34.55, 4.2, 145.11),
    ('1003', '2018-03-23', '18', '117', '509', 34.55, 2.0, 69.10),
    ('1004', '2018-03-23', '18', '103', '500', 35.75, 5.9, 210.93),
    ('1005', '2018-03-23', '25', '108', '501', 96.75, 2.2, 212.85),
    ('1006', '2018-03-23', '22', '104', '501', 96.75, 4.2, 406.35),
    ('1007', '2018-03-23', '25', '113', '508', 48.10, 3.8, 182.78),
    ('1008', '2018-03-24', '18', '103', '500', 35.75, 0.9, 32.18),
    ('1009', '2018-03-24', '15', '115', '501', 96.75, 5.6, 541.80),
    ('1010', '2018-03-24', '15', '117', '509', 34.55, 2.4, 82.92),
    ('1011', '2018-03-24', '25', '105', '502', 125.00, 4.3, 537.50),
    ('1012', '2018-03-24', '18', '108', '501', 96.75, 3.4, 328.95),
    ('1013', '2018-03-25', '25', '115', '501', 96.75, 2.0, 193.50),
    ('1014', '2018-03-25', '22', '104', '501', 96.75, 2.8, 270.90),
    ('1015', '2018-03-25', '15', '103', '500', 35.75, 6.1, 218.08),
    ('1016', '2018-03-25', '22', '105', '502', 125.00, 4.7, 587.50),
    ('1017', '2018-03-25', '18', '117', '509', 34.55, 3.8, 131.29),
    ('1018', '2018-03-26', '25', '117', '509', 34.55, 2.2, 76.01),
    ('1019', '2018-03-26', '25', '104', '501', 96.75, 4.9, 474.08),
    ('1020', '2018-03-26', '15', '101', '502', 125.00, 3.1, 387.50),
    ('1021', '2018-03-26', '22', '108', '501', 96.75, 2.7, 261.23),
    ('1022', '2018-03-26', '22', '115', '501', 96.75, 4.9, 474.08),
    ('1023', '2018-03-26', '22', '105', '502', 125.00, 3.5, 437.50),
    ('1024', '2018-03-26', '15', '103', '500', 35.75, 3.3, 117.98),
    ('1025', '2018-03-27', '18', '117', '509', 34.55, 4.2, 145.11);












    