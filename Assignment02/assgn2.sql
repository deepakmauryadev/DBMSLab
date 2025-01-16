SAVEPOINT before_assignment_2;

DROP TABLE TERM CASCADE CONSTRAINTS;
DROP TABLE DEPARTMENT CASCADE CONSTRAINTS;
DROP TABLE ROOM CASCADE CONSTRAINTS;
DROP TABLE MAJOR CASCADE CONSTRAINTS;
DROP TABLE COURSE CASCADE CONSTRAINTS;
DROP TABLE LOCATION CASCADE CONSTRAINTS;
DROP TABLE FACULTY CASCADE CONSTRAINTS;
DROP TABLE STUDENT CASCADE CONSTRAINTS;
DROP TABLE CROSSECTION CASCADE CONSTRAINTS;
DROP TABLE REGISTRATION CASCADE CONSTRAINTS;
DROP TABLE POSITION CASCADE CONSTRAINTS;
DROP TABLE QUALIFICATION CASCADE CONSTRAINTS;
DROP TABLE EMPLEVEL CASCADE CONSTRAINTS;
DROP TABLE DEPT CASCADE CONSTRAINTS;
DROP TABLE EMPLOYEE CASCADE CONSTRAINTS;
DROP TABLE DEPENDENT CASCADE CONSTRAINTS;

CREATE TABLE term (
  TermId NUMBER PRIMARY KEY NOT NULL, 
  TermDesc VARCHAR2(50), 
  StartDate DATE, 
  EndDate DATE
);

CREATE TABLE major (
  MajorId NUMBER PRIMARY KEY NOT NULL,
  MajorDesc VARCHAR2(50)
);

CREATE TABLE course (
  CourseId NUMBER PRIMARY KEY NOT NULL, 
  Title VARCHAR2(20), 
  Credits NUMBER, 
  PreReq VARCHAR2(20)
);

CREATE TABLE room (
  RoomType VARCHAR2(20) PRIMARY KEY NOT NULL,
  RoomDesc VARCHAR2(50)
);

CREATE TABLE location (
  RoomId NUMBER PRIMARY KEY NOT NULL,
  Building VARCHAR2(30),
  RoomNo VARCHAR2(20), 
  Capacity NUMBER,
  RoomType VARCHAR2(20),
  FOREIGN KEY (RoomType) REFERENCES room(RoomType)
);

CREATE TABLE faculty (
  FacultyId NUMBER PRIMARY KEY NOT NULL,
  Name VARCHAR2(50),
  RoomId NUMBER,
  FOREIGN KEY (RoomId) REFERENCES location(RoomId),
  Phone NUMBER(10), 
  DeptId NUMBER NOT NULL
);

CREATE TABLE department (
  DeptId NUMBER PRIMARY KEY NOT NULL, 
  DeptName VARCHAR2(50), 
  FacultyId NUMBER
);

ALTER TABLE faculty ADD CONSTRAINT dept_fk FOREIGN KEY (DeptId) REFERENCES department(DeptId);
ALTER TABLE department ADD CONSTRAINT faculty_fk FOREIGN KEY (FacultyId) REFERENCES faculty(FacultyId);

CREATE TABLE student (
  StudentId NUMBER PRIMARY KEY NOT NULL, 
  Last VARCHAR2(20), 
  First VARCHAR2(20) NOT NULL, 
  Street VARCHAR2(50), 
  City VARCHAR2(20), 
  State VARCHAR2(20), 
  Zip NUMBER(6), 
  StartTerm DATE, 
  BirthDate DATE, 
  FacultyId NUMBER, 
  FOREIGN KEY (FacultyId) REFERENCES faculty(FacultyId),
  MajorId NUMBER, 
  FOREIGN KEY (MajorId) REFERENCES major(MajorId),
  Phone NUMBER(10)
);

CREATE TABLE crossection (
  CsId NUMBER PRIMARY KEY NOT NULL, 
  CourseId NUMBER, 
  FOREIGN KEY (CourseId) REFERENCES course(CourseId), 
  Section VARCHAR2(20), 
  TermId NUMBER, 
  FOREIGN KEY (TermId) REFERENCES term(TermId),
  FacultyId NUMBER,
  FOREIGN KEY (FacultyId) REFERENCES faculty(FacultyId), 
  Day VARCHAR2(20), 
  StratTime VARCHAR2(20), 
  EndTime VARCHAR2(20), 
  RoomId NUMBER,
  FOREIGN KEY (RoomId) REFERENCES location(RoomId), 
  MaxCount NUMBER
);

CREATE TABLE registration (
  StudentId NUMBER,
  FOREIGN KEY (StudentId) REFERENCES student(StudentId), 
  CsId NUMBER,
  FOREIGN KEY (CsId) REFERENCES crossection(CsId), 
  PRIMARY KEY (StudentId, CsId),
  Midterm DATE, 
  Final DATE, 
  RegStatus VARCHAR2(20)
);

CREATE TABLE position (
  PositionId NUMBER PRIMARY KEY NOT NULL, 
  PosDesc VARCHAR2(50)
);

CREATE TABLE qualification (
  QualId NUMBER PRIMARY KEY NOT NULL, 
  QualDesc VARCHAR2(50)
);

CREATE TABLE emplevel (
  LevelNo NUMBER PRIMARY KEY NOT NULL, 
  LowSalary NUMBER, 
  HighSalary NUMBER
);

CREATE TABLE dept (
  DeptId NUMBER PRIMARY KEY NOT NULL, 
  DeptName VARCHAR2(20), 
  Location VARCHAR2(50), 
  EmployeeId NUMBER
);

CREATE TABLE employee (
  EmployeeId NUMBER PRIMARY KEY NOT NULL, 
  Lname VARCHAR2(20), 
  Fname VARCHAR2(20) NOT NULL, 
  PositionId NUMBER, 
  FOREIGN KEY (PositionId) REFERENCES position(PositionId),
  Supervisor VARCHAR2(20), 
  HireDate DATE, 
  Salary NUMBER, 
  Commission NUMBER, 
  DeptId NUMBER, 
  FOREIGN KEY (DeptId) REFERENCES dept(DeptId),
  QualId NUMBER,
  FOREIGN KEY (QualId) REFERENCES qualification(QualId)
);

ALTER TABLE dept ADD CONSTRAINT emp_fk FOREIGN KEY (EmployeeId) REFERENCES employee(EmployeeId);

CREATE TABLE dependent (
  EmployeeId NUMBER, 
  FOREIGN KEY (EmployeeId) REFERENCES employee(EmployeeId),
  DependentId NUMBER PRIMARY KEY NOT NULL, 
  DepDOB DATE, 
  Relation VARCHAR2(20)
);

-- Insert data into term
INSERT INTO term (TermId, TermDesc, StartDate, EndDate)
VALUES (1, 'Winter 2020', TO_DATE('2020-01-01', 'YYYY-MM-DD'), TO_DATE('2020-04-30', 'YYYY-MM-DD'));

-- Insert data into major
INSERT INTO major (MajorId, MajorDesc)
VALUES (1, 'Computer Science');

-- Insert data into course
INSERT INTO course (CourseId, Title, Credits, PreReq)
VALUES (1, 'Database Systems', 4, NULL);

-- Insert data into room
INSERT INTO room (RoomType, RoomDesc)
VALUES ('Lecture Hall', 'Large lecture hall with AV facilities');

-- Insert data into location
INSERT INTO location (RoomId, Building, RoomNo, Capacity, RoomType)
VALUES (1, 'Engineering Building', '101', 50, 'Lecture Hall');

-- Insert data into department
INSERT INTO department (DeptId, DeptName, FacultyId)
VALUES (1, 'Computer Science', NULL);

-- Insert data into faculty
INSERT INTO faculty (FacultyId, Name, RoomId, Phone, DeptId)
VALUES (1, 'Dr. John Smith', 1, 1234567890, 1);

-- Update department to set FacultyId
UPDATE department SET FacultyId = 1 WHERE DeptId = 1;

-- Insert data into student
INSERT INTO student (StudentId, Last, First, Street, City, State, Zip, StartTerm, BirthDate, FacultyId, MajorId, Phone)
VALUES (1, 'Doe', 'Jane', '123 Main St', 'New York', 'NY', 10001, TO_DATE('2015-09-01', 'YYYY-MM-DD'), TO_DATE('1998-06-15', 'YYYY-MM-DD'), 1, 1, 9876543210);

-- Insert data into crossection
INSERT INTO crossection (CsId, CourseId, Section, TermId, FacultyId, Day, StratTime, EndTime, RoomId, MaxCount)
VALUES (1, 1, 'A', 1, 1, 'Monday', '10:00', '12:00', 1, 30);

-- Insert data into registration
INSERT INTO registration (StudentId, CsId, Midterm, Final, RegStatus)
VALUES (1, 1, TO_DATE('2020-03-15', 'YYYY-MM-DD'), TO_DATE('2020-04-30', 'YYYY-MM-DD'), 'Enrolled');

-- Insert data into position
INSERT INTO position (PositionId, PosDesc)
VALUES (1, 'Professor');

-- Insert data into qualification
INSERT INTO qualification (QualId, QualDesc)
VALUES (1, 'PhD in Computer Science');

-- Insert data into emplevel
INSERT INTO emplevel (LevelNo, LowSalary, HighSalary)
VALUES (1, 50000, 100000);

-- Insert data into dept
INSERT INTO dept (DeptId, DeptName, Location, EmployeeId)
VALUES (30, 'Mathematics', 'Building A', NULL);

-- Insert data into employee
INSERT INTO employee (EmployeeId, Lname, Fname, PositionId, Supervisor, HireDate, Salary, Commission, DeptId, QualId)
VALUES (111, 'Brown', 'Chris', 1, 'Smith', TO_DATE('2018-01-15', 'YYYY-MM-DD'), 60000, NULL, 30, 1);

-- Update dept to set EmployeeId
UPDATE dept SET EmployeeId = 111 WHERE DeptId = 30;

-- Insert data into dependent
INSERT INTO dependent (EmployeeId, DependentId, DepDOB, Relation)
VALUES (111, 1, TO_DATE('2010-05-10', 'YYYY-MM-DD'), 'Son');

-- Insert additional data into term
INSERT INTO term (TermId, TermDesc, StartDate, EndDate)
VALUES (2, 'Fall 2021', TO_DATE('2021-08-15', 'YYYY-MM-DD'), TO_DATE('2021-12-15', 'YYYY-MM-DD'));

-- Insert additional data into major
INSERT INTO major (MajorId, MajorDesc)
VALUES (2, 'Mechanical Engineering');

-- Insert additional data into course
INSERT INTO course (CourseId, Title, Credits, PreReq)
VALUES (2, 'Thermodynamics', 3, 'Physics I');

-- Insert additional data into room
INSERT INTO room (RoomType, RoomDesc)
VALUES ('Lab', 'Physics laboratory');

-- Insert additional data into location
INSERT INTO location (RoomId, Building, RoomNo, Capacity, RoomType)
VALUES (2, 'Science Building', '202', 20, 'Lab');

-- Insert additional data into department
INSERT INTO department (DeptId, DeptName, FacultyId)
VALUES (2, 'Mechanical Engineering', NULL);

-- Insert additional data into faculty
INSERT INTO faculty (FacultyId, Name, RoomId, Phone, DeptId)
VALUES (2, 'Dr. Sarah Johnson', 2, 2345678901, 2);

-- Update department to set FacultyId
UPDATE department SET FacultyId = 2 WHERE DeptId = 2;

-- Insert additional data into student
INSERT INTO student (StudentId, Last, First, Street, City, State, Zip, StartTerm, BirthDate, FacultyId, MajorId, Phone)
VALUES (2, 'Smith', 'Michael', '456 Elm St', 'Newark', 'NJ', 07102, TO_DATE('2015-09-01', 'YYYY-MM-DD'), TO_DATE('1999-08-25', 'YYYY-MM-DD'), 2, 2, 8765432109);

-- Insert additional data into crossection
INSERT INTO crossection (CsId, CourseId, Section, TermId, FacultyId, Day, StratTime, EndTime, RoomId, MaxCount)
VALUES (2, 2, 'B', 2, 2, 'Wednesday', '14:00', '16:00', 2, 25);

-- Insert additional data into registration
INSERT INTO registration (StudentId, CsId, Midterm, Final, RegStatus)
VALUES (2, 2, TO_DATE('2021-10-15', 'YYYY-MM-DD'), TO_DATE('2021-12-15', 'YYYY-MM-DD'), 'Completed');

-- Insert additional data into position
INSERT INTO position (PositionId, PosDesc)
VALUES (2, 'Lab Assistant');

-- Insert additional data into qualification
INSERT INTO qualification (QualId, QualDesc)
VALUES (2, 'Master in Mechanical Engineering');

-- Insert additional data into emplevel
INSERT INTO emplevel (LevelNo, LowSalary, HighSalary)
VALUES (2, 30000, 70000);

-- Insert additional data into dept
INSERT INTO dept (DeptId, DeptName, Location, EmployeeId)
VALUES (40, 'Physics', 'Building B', NULL);

-- Insert additional data into employee
INSERT INTO employee (EmployeeId, Lname, Fname, PositionId, Supervisor, HireDate, Salary, Commission, DeptId, QualId)
VALUES (222, 'Green', 'Alex', 2, 'Brown', TO_DATE('2020-06-01', 'YYYY-MM-DD'), 40000, 500, 40, 2);

-- Update dept to set EmployeeId
UPDATE dept SET EmployeeId = 222 WHERE DeptId = 40;

-- Insert additional data into dependent
INSERT INTO dependent (EmployeeId, DependentId, DepDOB, Relation)
VALUES (222, 2, TO_DATE('2015-12-10', 'YYYY-MM-DD'), 'Daughter');

-- Insert additional data into term
INSERT INTO term (TermId, TermDesc, StartDate, EndDate)
VALUES (3, 'Spring 2022', TO_DATE('2022-01-15', 'YYYY-MM-DD'), TO_DATE('2022-05-15', 'YYYY-MM-DD'));

-- Insert additional data into major
INSERT INTO major (MajorId, MajorDesc)
VALUES (3, 'Electrical Engineering');

-- Insert additional data into course
INSERT INTO course (CourseId, Title, Credits, PreReq)
VALUES (3, 'Circuit Analysis', 4, 'Math II');

-- Insert additional data into room
INSERT INTO room (RoomType, RoomDesc)
VALUES ('Seminar Room', 'Small seminar room with projectors');

-- Insert additional data into location
INSERT INTO location (RoomId, Building, RoomNo, Capacity, RoomType)
VALUES (3, 'Electrical Building', '303', 15, 'Seminar Room');

-- Insert additional data into department
INSERT INTO department (DeptId, DeptName, FacultyId)
VALUES (3, 'Electrical Engineering', NULL);

-- Insert additional data into faculty
INSERT INTO faculty (FacultyId, Name, RoomId, Phone, DeptId)
VALUES (3, 'Dr. Emily Davis', 3, 3456789012, 3);

-- Update department to set FacultyId
UPDATE department SET FacultyId = 3 WHERE DeptId = 3;

-- Insert additional data into student
INSERT INTO student (StudentId, Last, First, Street, City, State, Zip, StartTerm, BirthDate, FacultyId, MajorId, Phone)
VALUES (3, 'Williams', 'Sophia', '789 Oak St', 'Albany', 'NY', 12203, TO_DATE('2015-01-10', 'YYYY-MM-DD'), TO_DATE('2000-05-05', 'YYYY-MM-DD'), 3, 3, 7654321098);

-- Insert additional data into crossection
INSERT INTO crossection (CsId, CourseId, Section, TermId, FacultyId, Day, StratTime, EndTime, RoomId, MaxCount)
VALUES (3, 3, 'C', 3, 3, 'Friday', '09:00', '11:00', 3, 20);

-- Insert additional data into registration
INSERT INTO registration (StudentId, CsId, Midterm, Final, RegStatus)
VALUES (3, 3, TO_DATE('2022-04-01', 'YYYY-MM-DD'), TO_DATE('2022-05-15', 'YYYY-MM-DD'), 'Enrolled');

-- Insert additional data into position
INSERT INTO position (PositionId, PosDesc)
VALUES (3, 'Research Assistant');

-- Insert additional data into qualification
INSERT INTO qualification (QualId, QualDesc)
VALUES (3, 'Bachelor in Electrical Engineering');

-- Insert additional data into emplevel
INSERT INTO emplevel (LevelNo, LowSalary, HighSalary)
VALUES (3, 20000, 50000);

-- Insert additional data into dept
INSERT INTO dept (DeptId, DeptName, Location, EmployeeId)
VALUES (50, 'Civil Engineering', 'Building C', NULL);

-- Insert additional data into employee
INSERT INTO employee (EmployeeId, Lname, Fname, PositionId, Supervisor, HireDate, Salary, Commission, DeptId, QualId)
VALUES (333, 'Taylor', 'Jordan', 3, 'Green', TO_DATE('2021-02-10', 'YYYY-MM-DD'), 45000, NULL, 50, 3);

-- Update dept to set EmployeeId
UPDATE dept SET EmployeeId = 333 WHERE DeptId = 50;

-- Insert additional data into dependent
INSERT INTO dependent (EmployeeId, DependentId, DepDOB, Relation)
VALUES (333, 3, TO_DATE('2017-03-20', 'YYYY-MM-DD'), 'Spouse');

-- Insert additional data into term
INSERT INTO term (TermId, TermDesc, StartDate, EndDate)
VALUES (4, 'Summer 2023', TO_DATE('2023-06-01', 'YYYY-MM-DD'), TO_DATE('2023-08-31', 'YYYY-MM-DD'));

-- Insert additional data into major
INSERT INTO major (MajorId, MajorDesc)
VALUES (4, 'Chemical Engineering');

-- Insert additional data into course
INSERT INTO course (CourseId, Title, Credits, PreReq)
VALUES (4, 'Organic Chemistry', 4, 'Chemistry I');

-- Insert additional data into room
INSERT INTO room (RoomType, RoomDesc)
VALUES ('Computer Lab', 'Advanced computer lab with simulation tools');

-- Insert additional data into location
INSERT INTO location (RoomId, Building, RoomNo, Capacity, RoomType)
VALUES (4, 'Chemistry Building', '404', 25, 'Computer Lab');

-- Insert additional data into department
INSERT INTO department (DeptId, DeptName, FacultyId)
VALUES (4, 'Chemical Engineering', NULL);

-- Insert additional data into faculty
INSERT INTO faculty (FacultyId, Name, RoomId, Phone, DeptId)
VALUES (4, 'Dr. Daniel Parker', 4, 4567890123, 4);

-- Update department to set FacultyId
UPDATE department SET FacultyId = 4 WHERE DeptId = 4;

-- Insert additional data into student
INSERT INTO student (StudentId, Last, First, Street, City, State, Zip, StartTerm, BirthDate, FacultyId, MajorId, Phone)
VALUES (4, 'Johnson', 'Emma', '901 Pine St', 'Trenton', 'NJ', 08608, TO_DATE('2016-09-01', 'YYYY-MM-DD'), TO_DATE('1997-11-10', 'YYYY-MM-DD'), 4, 4, 6543210987);

-- Insert additional data into crossection
INSERT INTO crossection (CsId, CourseId, Section, TermId, FacultyId, Day, StratTime, EndTime, RoomId, MaxCount)
VALUES (4, 4, 'D', 4, 4, 'Tuesday', '13:00', '15:00', 4, 35);

-- Insert additional data into registration
INSERT INTO registration (StudentId, CsId, Midterm, Final, RegStatus)
VALUES (4, 4, TO_DATE('2023-07-15', 'YYYY-MM-DD'), TO_DATE('2023-08-31', 'YYYY-MM-DD'), 'In Progress');

-- Insert additional data into position
INSERT INTO position (PositionId, PosDesc)
VALUES (4, 'Teaching Assistant');

-- Insert additional data into qualification
INSERT INTO qualification (QualId, QualDesc)
VALUES (4, 'Master in Chemical Engineering');

-- Insert additional data into emplevel
INSERT INTO emplevel (LevelNo, LowSalary, HighSalary)
VALUES (4, 40000, 80000);

-- Insert additional data into dept
INSERT INTO dept (DeptId, DeptName, Location, EmployeeId)
VALUES (60, 'Biotechnology', 'Building D', NULL);

-- Insert additional data into employee
INSERT INTO employee (EmployeeId, Lname, Fname, PositionId, Supervisor, HireDate, Salary, Commission, DeptId, QualId)
VALUES (444, 'Martinez', 'Olivia', 4, 'Taylor', TO_DATE('2022-03-01', 'YYYY-MM-DD'), 50000, 1000, 60, 4);

-- Update dept to set EmployeeId
UPDATE dept SET EmployeeId = 444 WHERE DeptId = 60;

-- Insert additional data into dependent
INSERT INTO dependent (EmployeeId, DependentId, DepDOB, Relation)
VALUES (444, 4, TO_DATE('2019-01-15', 'YYYY-MM-DD'), 'Parent');

-- Insert additional data into term
INSERT INTO term (TermId, TermDesc, StartDate, EndDate)
VALUES (5, 'Fall 2024', TO_DATE('2024-09-01', 'YYYY-MM-DD'), TO_DATE('2024-12-20', 'YYYY-MM-DD'));

-- Insert additional data into major
INSERT INTO major (MajorId, MajorDesc)
VALUES (5, 'Computer Science');

-- Insert additional data into course
INSERT INTO course (CourseId, Title, Credits, PreReq)
VALUES (5, 'Data Structures', 3, 'Intro to Programming');

-- Insert additional data into room
INSERT INTO room (RoomType, RoomDesc)
VALUES ('Auditorium', 'Large lecture hall with audio-visual equipment');

-- Insert additional data into location
INSERT INTO location (RoomId, Building, RoomNo, Capacity, RoomType)
VALUES (5, 'Computer Science Building', '105', 150, 'Auditorium');

-- Insert additional data into department
INSERT INTO department (DeptId, DeptName, FacultyId)
VALUES (5, 'Computer Science', NULL);

-- Insert additional data into faculty
INSERT INTO faculty (FacultyId, Name, RoomId, Phone, DeptId)
VALUES (5, 'Dr. Ethan Cooper', 5, 5678901234, 5);

-- Update department to set FacultyId
UPDATE department SET FacultyId = 5 WHERE DeptId = 5;

-- Insert additional data into student
INSERT INTO student (StudentId, Last, First, Street, City, State, Zip, StartTerm, BirthDate, FacultyId, MajorId, Phone)
VALUES (5, 'Brown', 'Isabella', '234 Maple Ave', 'Boston', 'MA', 02118, TO_DATE('2017-01-15', 'YYYY-MM-DD'), TO_DATE('1998-03-12', 'YYYY-MM-DD'), 5, 5, 5432109876);

-- Insert additional data into crossection
INSERT INTO crossection (CsId, CourseId, Section, TermId, FacultyId, Day, StratTime, EndTime, RoomId, MaxCount)
VALUES (5, 5, 'E', 5, 5, 'Thursday', '10:00', '12:00', 5, 100);

-- Insert additional data into registration
INSERT INTO registration (StudentId, CsId, Midterm, Final, RegStatus)
VALUES (5, 5, TO_DATE('2024-10-20', 'YYYY-MM-DD'), TO_DATE('2024-12-20', 'YYYY-MM-DD'), 'Completed');

-- Insert additional data into position
INSERT INTO position (PositionId, PosDesc)
VALUES (5, 'Senior Lecturer');

-- Insert additional data into qualification
INSERT INTO qualification (QualId, QualDesc)
VALUES (5, 'PhD in Computer Science');

-- Insert additional data into emplevel
INSERT INTO emplevel (LevelNo, LowSalary, HighSalary)
VALUES (5, 60000, 120000);

-- Insert additional data into dept
INSERT INTO dept (DeptId, DeptName, Location, EmployeeId)
VALUES (70, 'Mathematics', 'Building E', NULL);

-- Insert additional data into employee
INSERT INTO employee (EmployeeId, Lname, Fname, PositionId, Supervisor, HireDate, Salary, Commission, DeptId, QualId)
VALUES (555, 'Lopez', 'Sophia', 5, 'Martinez', TO_DATE('2023-04-15', 'YYYY-MM-DD'), 75000, NULL, 70, 5);

-- Update dept to set EmployeeId
UPDATE dept SET EmployeeId = 555 WHERE DeptId = 70;

-- Insert additional data into dependent
INSERT INTO dependent (EmployeeId, DependentId, DepDOB, Relation)
VALUES (555, 5, TO_DATE('2020-05-25', 'YYYY-MM-DD'), 'Sibling');

SAVEPOINT after_assignment_2;

-- 1. Display all employee names (last name and first name separated by a comma and a space) 
SELECT 
  Lname || ', ' || Fname AS "Employee Name", 
  Salary AS "Salary" 
FROM employee;

-- 2. Display all employees who do not get any commission.
SELECT EmployeeId, Lname, Fname, Salary 
FROM employee 
WHERE Commission IS NULL;

-- 3. Display unique building names from LOCATION table.
SELECT DISTINCT Building FROM location;

-- 4. Display all course sections offered in Winter 2020.
SELECT 
  CsId, 
  CourseId, 
  Section, 
  TermId 
FROM crossection 
WHERE TermId = (SELECT TermId FROM term WHERE TermDesc = 'Winter 2020');

-- 5. Display names of faculty members who work in department 1 or 2.
SELECT 
  Name 
FROM faculty 
WHERE DeptId IN (1, 2);

-- 6. Find all New York and New Jersey students.
SELECT 
  StudentId, 
  Last, 
  First, 
  City, 
  State 
FROM student 
WHERE State IN ('NY', 'NJ');

-- 7. Give a 10% raise to employee number 111.
UPDATE employee 
SET Salary = Salary * 1.10 
WHERE EmployeeId = 111;

-- 8. Delete department number 30 from the department table.
DELETE FROM department 
WHERE DeptId = 30;

-- 9. For each course ID, display the maximum count in descending order.
SELECT 
  CourseId, 
  MAX(MaxCount) AS "Maximum Count" 
FROM crossection 
GROUP BY CourseId 
ORDER BY MAX(MaxCount) DESC;

-- 10. Insert a new term in the TERM table.
INSERT INTO term (TermId, TermDesc, StartDate, EndDate)
VALUES (6, 'Winter 2025', TO_DATE('2025-01-05', 'YYYY-MM-DD'), TO_DATE('2025-04-25', 'YYYY-MM-DD'));

-- 11. Find courses with no required prerequisite.
SELECT 
  CourseId, 
  Title 
FROM course 
WHERE PreReq IS NULL;

-- 12. Find faculty members whose names start with C.
SELECT 
  FacultyId, 
  Name 
FROM faculty 
WHERE Name LIKE 'C%';

-- 13. Find students who started in the year 2015. Use StartTerm column and wild card.
SELECT 
  StudentId, 
  Last, 
  First, 
  StartTerm 
FROM student 
WHERE TO_CHAR(StartTerm, 'YYYY') LIKE '2015%';

ROLLBACK TO after_assignment_2;
