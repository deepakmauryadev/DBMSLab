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
