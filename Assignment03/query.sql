-- 1. Display all employees with their commission value. Display 0 commission for employees who do not get any commission.
SELECT EmployeeId, Lname, Fname, NVL(Commission, 0) FROM employee;

-- 2. Count the total number of rooms in LOCATION.
SELECT COUNT(*) AS TotalRooms FROM location;

-- 3. Count the distinct building names in LOCATION.
SELECT COUNT(DISTINCT Building) AS DistinctBuildings FROM location;

-- 4. Display all student names and birth dates. Display birth dates with the format ‘20 OCTOBER, 1970’.
SELECT First, Last, TO_CHAR(BirthDate, 'DD MONTH, YYYY') AS DOB From student;

-- 5. Find the average, highest, and lowest age for students.
SELECT
  ROUND(AVG(MONTHS_BETWEEN(SYSDATE, BirthDate)) / 12) AS AverageAge,
  ROUND(MONTHS_BETWEEN(SYSDATE, MIN(BirthDate)) / 12) AS YoungestAge,
  ROUND(MONTHS_BETWEEN(SYSDATE, MAX(BirthDate)) / 12) AS OldestAge 
FROM student;

-- 6. Display only the year value from each employee’s hire date.
SELECT EmployeeId, EXTRACT(YEAR FROM HireDate) AS HireYear FROM employee;

-- 7. Find average employee commission.
-- i. Ignore NULLs
SELECT AVG(Commission) AS AvgCommission FROM employee
WHERE Commission IS NOT NULL;
-- ii. Do not ignore NULLs
SELECT AVG(NVL(Commission, 0)) AS AvgCommission FROM employee;

-- 8. Find 2 to the power 10.
SELECT POWER(2, 10) AS Result FROM dual;

-- 9. Display courses and prerequisites. If there is no prerequisite, display ‘none’, else display ‘one’.
SELECT Title AS Course, NVL2(PreReq, 'one', 'none') AS Prerequisite FROM course;

-- 10. Find the number of years employees have been working for. Display integer part of value only.
SELECT EmployeeId, FLOOR(MONTHS_BETWEEN(SYSDATE, HireDate) / 12) AS YearsWorked FROM employee;

-- 11. Find students who are born in the month of May.
SELECT StudentId, First, Last, BirthDate FROM student
WHERE EXTRACT(MONTH FROM BirthDate) = 5;

-- 12. Display employee’s last name and first name, followed by salary+commission if commission is not null, else display salary only.
SELECT Lname, Fname, Salary + NVL(Commission, 0) AS TotalEarnings FROM employee;

-- 13. Display employee’s full name followed by a message based on salary.
SELECT Fname, Lname,
       CASE 
           WHEN Salary > 100000 THEN 'HIGH'
           WHEN Salary BETWEEN 50000 AND 100000 THEN 'MEDIUM'
           ELSE 'LOW'
       END AS SalaryCategory
FROM employee;
