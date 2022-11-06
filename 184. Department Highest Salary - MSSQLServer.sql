--First solution

WITH CTE AS (
    SELECT 
        d.id AS DepartmentId,
        d.name AS DepartmentName,
        max(e.salary) AS Salary 
    FROM Employee e 
    INNER JOIN Department d on (d.id = e.departmentId)
    GROUP BY d.id, d.name
)

SELECT 
    CTE.DepartmentName AS Department,
    e.name AS Employee,
    e.salary AS Salary 
FROM Employee e 
INNER JOIN CTE on (CTE.DepartmentId = e.departmentId)
WHERE e.salary = CTE.Salary

--Second solution(almost 10% faster)

SELECT 
    d1.name AS Department,
    e.name AS Employee,
    e.salary AS Salary 
FROM Employee e 
INNER JOIN Department d1 on (d1.id = e.departmentId)
WHERE e.salary = (
        SELECT 
            max(e.salary) AS Salary 
    FROM Employee e 
    INNER JOIN Department d2 on (d2.id = e.departmentId)
    WHERE d1.id = d2.id
    GROUP BY d2.id, d2.name
)