select * from dbo.Messy_Employee_dataset
SELECT TOP 10 * FROM dbo.Messy_Employee_dataset;
SELECT 
  Employee_ID,
  First_Name,
  Last_Name,
  COALESCE(Age, AVG(Age) OVER()) AS Clean_Age
FROM dbo.messy_employee_dataset;

SELECT *
FROM dbo.messy_employee_dataset
WHERE Age IS NULL;

SELECT 
  COUNT(*) AS null_after
FROM (
  SELECT COALESCE(Age, AVG(Age) OVER()) AS Clean_Age
  FROM dbo.messy_employee_dataset
) t
WHERE Clean_Age IS NULL;

SELECT 
  Employee_ID,
  First_Name,
  Last_Name,
  COALESCE(Age, AVG(Age) OVER()) AS Age,
  Salary,
  Department_Region,
  Join_Date,
  Email,
  Phone,
  Performance_Score,
  Status,
  Remote_Work
INTO dbo.employees_clean
FROM dbo.messy_employee_dataset;
SELECT COUNT(*) 
FROM dbo.employees_clean
WHERE Age IS NULL;

select Top 10 * from dbo.employees_clean
SELECT 
  Salary,
  ROUND(Salary, 2) AS Clean_Salary
FROM dbo.employees_clean;
UPDATE dbo.employees_clean
SET Salary = ROUND(Salary, 2);

SELECT TOP 10 Salary
FROM dbo.employees_clean;

SELECT 
  Department_Region,
  LEFT(Department_Region, CHARINDEX('-', Department_Region) - 1) AS Department,
  SUBSTRING(
    Department_Region,
    CHARINDEX('-', Department_Region) + 1,
    LEN(Department_Region)
  ) AS Region
FROM dbo.employees_clean;

ALTER TABLE dbo.employees_clean
ADD Department VARCHAR(50),
    Region VARCHAR(50);
UPDATE dbo.employees_clean
SET 
  Department = LEFT(Department_Region, CHARINDEX('-', Department_Region) - 1),
  Region = SUBSTRING(
    Department_Region,
    CHARINDEX('-', Department_Region) + 1,
    LEN(Department_Region)
  );

 SELECT TOP 10 Department_Region, Department, Region
FROM dbo.employees_clean;
ALTER TABLE dbo.employees_clean
DROP COLUMN Department_Region;

select * from dbo.employees_clean
SELECT TOP 20 Phone
FROM dbo.employees_clean;

SELECT 
  Phone,
  ABS(Phone) AS Clean_Phone
FROM dbo.employees_clean;
UPDATE dbo.employees_clean
SET Phone = ABS(Phone);

SELECT TOP 20 Phone
FROM dbo.employees_clean;

SELECT TOP 10 Join_Date
FROM dbo.employees_clean;

SELECT 
  Join_Date,
  TRY_CONVERT(DATE, Join_Date, 101) AS Clean_Join_Date
FROM dbo.employees_clean;

ALTER TABLE dbo.employees_clean
ALTER COLUMN Join_Date DATE;
UPDATE dbo.employees_clean
SET Join_Date = TRY_CONVERT(DATE, Join_Date, 101);

SELECT TOP 10 Join_Date
FROM dbo.employees_clean;

SELECT DISTINCT Status FROM dbo.employees_clean;

SELECT DISTINCT Performance_Score FROM dbo.employees_clean;

UPDATE dbo.employees_clean
SET 
  Status = UPPER(Status),
  Performance_Score = UPPER(Performance_Score);

  UPDATE dbo.employees_clean
SET 
  First_Name = LTRIM(RTRIM(First_Name)),
  Last_Name = LTRIM(RTRIM(Last_Name));

  SELECT DISTINCT Status FROM dbo.employees_clean;
  SELECT * FROM dbo.employees_clean;