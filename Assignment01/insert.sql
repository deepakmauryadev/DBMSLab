-- 1. Insert data into TERM
INSERT INTO term (TermId, TermDesc, StartDate, EndDate) 
VALUES (1, 'Spring 2025', TO_DATE('2025-01-01', 'YYYY-MM-DD'), TO_DATE('2025-05-31', 'YYYY-MM-DD'));

-- 2. Insert data into MAJOR
INSERT INTO major (MajorId, MajorDesc) 
VALUES (1, 'Computer Science');

-- 3. Insert data into COURSE
INSERT INTO course (CourseId, Title, Credits, PreReq) 
VALUES (1, 'Database Systems', 3, NULL);

-- 4. Insert data into ROOM
INSERT INTO room (RoomType, RoomDesc) 
VALUES ('Lecture', 'Large Lecture Room');

-- 5. Insert data into LOCATION
INSERT INTO location (RoomId, Building, RoomNo, Capacity, RoomType) 
VALUES (1, 'Science Building', '101', 100, 'Lecture');

-- 6. Insert data into DEPARTMENT
INSERT INTO department (DeptId, DeptName, FacultyId) 
VALUES (1, 'Engineering', NULL);

-- 7. Insert data into FACULTY
INSERT INTO faculty (FacultyId, Name, RoomId, Phone, DeptId) 
VALUES (1, 'Dr. John Doe', 1, 1234567890, 1);

-- Update DEPARTMENT to set the FacultyId (Circular Reference Handling)
UPDATE department SET FacultyId = 1 WHERE DeptId = 1;

-- 8. Insert data into STUDENT
INSERT INTO student (StudentId, Last, First, Street, City, State, Zip, StartTerm, BirthDate, FacultyId, MajorId, Phone) 
VALUES (1, 'Smith', 'Jane', '123 Main St', 'Anytown', 'CA', 123456, TO_DATE('2025-01-01', 'YYYY-MM-DD'), TO_DATE('2003-05-10', 'YYYY-MM-DD'), 1, 1, 9876543210);

-- 9. Insert data into CROSSECTION
INSERT INTO crossection (CsId, CourseId, Section, TermId, FacultyId, Day, StratTime, EndTime, RoomId, MaxCount) 
VALUES (1, 1, 'A', 1, 1, 'Monday', '10:00', '12:00', 1, 30);

-- 10. Insert data into REGISTRATION
INSERT INTO registration (StudentId, CsId, Midterm, Final, RegStatus) 
VALUES (1, 1, TO_DATE('2025-03-15', 'YYYY-MM-DD'), TO_DATE('2025-05-15', 'YYYY-MM-DD'), 'Enrolled');


-- 1. Insert data into POSITION
INSERT INTO position (PositionId, PosDesc) 
VALUES (1, 'Manager');

-- 2. Insert data into QUALIFICATION
INSERT INTO qualification (QualId, QualDesc) 
VALUES (1, 'MBA');

-- 3. Insert data into EMPLEVEL
INSERT INTO emplevel (LevelNo, LowSalary, HighSalary) 
VALUES (1, 50000, 100000);

-- 4. Insert data into DEPT (without EmployeeId initially due to circular dependency)
INSERT INTO dept (DeptId, DeptName, Location, EmployeeId) 
VALUES (1, 'Finance', 'Building A', NULL);

-- 5. Insert data into EMPLOYEE
INSERT INTO employee (EmployeeId, Lname, Fname, PositionId, Supervisor, HireDate, Salary, Commission, DeptId, QualId) 
VALUES (1, 'Doe', 'John', 1, 'CEO', TO_DATE('2020-01-15', 'YYYY-MM-DD'), 75000, 5000, 1, 1);

-- 6. Update DEPT to set EmployeeId (Circular Reference Handling)
UPDATE dept SET EmployeeId = 1 WHERE DeptId = 1;

-- 7. Insert data into DEPENDENT
INSERT INTO dependent (EmployeeId, DependentId, DepDOB, Relation) 
VALUES (1, 1, TO_DATE('2010-05-20', 'YYYY-MM-DD'), 'Child');
