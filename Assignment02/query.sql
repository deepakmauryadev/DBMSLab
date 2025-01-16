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

