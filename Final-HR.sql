create database HR_Analytics;
use HR_Analytics;

# 1. Total Employees
SELECT COUNT(*) AS TotalEmployees
FROM HR_1;

# 2. Total Attrition Employees
SELECT COUNT(*) AS AttritionEmployees
FROM HR_1
WHERE Attrition = 'Yes';

# 3. Overall Attrition Rate
SELECT
    ROUND(
        AVG(CASE WHEN Attrition = 'Yes' THEN 1.0 ELSE 0 END) * 100,
        2
    ) AS OverallAttritionRate
FROM HR_1;

# 4. Gender Wise Employee Count
SELECT
    Gender,
    COUNT(*) AS EmployeeCount
FROM HR_1
GROUP BY Gender;

# 5. Department Wise Employee Count
SELECT
    Department,
    COUNT(*) AS EmployeeCount
FROM HR_1
GROUP BY Department;

# 6. Highest Monthly Income
SELECT MAX(MonthlyIncome) AS HighestIncome
FROM HR_2;

# 7. Lowest Monthly Income
SELECT MIN(MonthlyIncome) AS LowestIncome
FROM HR_2;

# 8. Average Monthly Income
SELECT ROUND(AVG(MonthlyIncome),2) AS AvgIncome
FROM HR_2;

# 9. Top 10 Highest Paid Employees
SELECT
h1.EmployeeNumber,
h1.JobRole,
h2.MonthlyIncome
FROM HR_1 h1
INNER JOIN HR_2 h2
ON h1.EmployeeNumber = h2.EmployeeNumber
ORDER BY h2.MonthlyIncome DESC
LIMIT 10;

# 10. Employees Working More Than 10 Years
SELECT
    h1.EmployeeNumber,
    h1.Department,
    h2.TotalWorkingYears
FROM HR_1 h1
INNER JOIN HR_2 h2
ON h1.EmployeeNumber = h2.EmployeeNumber
WHERE h2.TotalWorkingYears > 10;

# 11. Department With Highest Attrition
SELECT
Department,
ROUND(
AVG(CASE WHEN Attrition='Yes' THEN 1.0 ELSE 0 END)*100,
2
) AS AttritionRate
FROM HR_1
GROUP BY Department
ORDER BY AttritionRate DESC
LIMIT 1;

# 12. Average Income By Job Role
SELECT
    h1.JobRole,
    ROUND(AVG(h2.MonthlyIncome),2) AS AvgIncome
FROM HR_1 h1
INNER JOIN HR_2 h2
ON h1.EmployeeNumber = h2.EmployeeNumber
GROUP BY h1.JobRole
ORDER BY AvgIncome DESC;

# 13. KPI 1 : Average Attrition Rate for All Departments
SELECT
    h1.Department,
    ROUND(
        AVG(CASE WHEN h1.Attrition = 'Yes' THEN 1.0 ELSE 0 END) * 100,
        2
    ) AS AttritionRate
FROM HR_1 h1
GROUP BY h1.Department;

# 14. KPI 2 : Average Hourly Rate of Male Research Scientist
SELECT
    ROUND(AVG(h1.HourlyRate),2) AS AvgHourlyRate
FROM HR_1 h1
INNER JOIN HR_2 h2
ON h1.EmployeeNumber = h2.EmployeeNumber
WHERE h1.Gender = 'Male'
AND h1.JobRole = 'Research Scientist';

# 15. KPI 3 : Attrition Rate Vs Monthly Income Stats
SELECT
    CASE
        WHEN h2.MonthlyIncome < 3000 THEN '0-3K'
        WHEN h2.MonthlyIncome < 6000 THEN '3K-6K'
        WHEN h2.MonthlyIncome < 9000 THEN '6K-9K'
        ELSE '9K+'
    END AS IncomeGroup,
    ROUND(
        AVG(CASE WHEN h1.Attrition = 'Yes' THEN 1.0 ELSE 0 END) * 100,
        2
    ) AS AttritionRate
FROM HR_1 h1
INNER JOIN HR_2 h2
ON h1.EmployeeNumber = h2.EmployeeNumber
GROUP BY IncomeGroup
ORDER BY IncomeGroup;

# 16. KPI 4 : Average Working Years for Each Department
SELECT
    h1.Department,
    ROUND(AVG(h2.TotalWorkingYears),2) AS AvgWorkingYears
FROM HR_1 h1
INNER JOIN HR_2 h2
ON h1.EmployeeNumber = h2.EmployeeNumber
GROUP BY h1.Department;

# 17 . KPI 5 : Job Role Vs Work Life Balance
SELECT
    h1.JobRole,
    ROUND(AVG(h2.WorkLifeBalance),2) AS AvgWorkLifeBalance
FROM HR_1 h1
INNER JOIN HR_2 h2
ON h1.EmployeeNumber = h2.EmployeeNumber
GROUP BY h1.JobRole
ORDER BY AvgWorkLifeBalance DESC;

# 18. KPI 6 : Attrition Rate Vs Years Since Last Promotion
SELECT
    h2.YearsSinceLastPromotion,
    ROUND(
        AVG(CASE WHEN h1.Attrition = 'Yes' THEN 1.0 ELSE 0 END) * 100,
        2
    ) AS AttritionRate
FROM HR_1 h1
INNER JOIN HR_2 h2
ON h1.EmployeeNumber = h2.EmployeeNumber
GROUP BY h2.YearsSinceLastPromotion
ORDER BY h2.YearsSinceLastPromotion;

# 19. Average Age By Department
SELECT
    Department,
    ROUND(AVG(Age),2) AS AvgAge
FROM HR_1
GROUP BY Department;
