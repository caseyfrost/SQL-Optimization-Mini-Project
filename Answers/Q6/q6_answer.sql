/*
The Transcript talbe studId filed is unique so no students have taken all of the courses in MAT.
1. The bottlneck was multiple full table scans and nested loops
2. Identified in the execution plan becuase there are no results
3. Used CTEs to remove the scans
*/


USE springboardopt;

-- -------------------------------------
SET @v1 = 1612521;
SET @v2 = 1145072;
SET @v3 = 1828467;
SET @v4 = 'MGT382';
SET @v5 = 'Amber Hill';
SET @v6 = 'MGT';
SET @v7 = 'EE';			  
SET @v8 = 'MAT';

-- 6. List the names of students who have taken all courses offered by department v8 (deptId).
SELECT name FROM Student,
	(SELECT studId
	FROM Transcript
		WHERE crsCode IN
		(SELECT crsCode FROM Course WHERE deptId = @v8 AND crsCode IN (SELECT crsCode FROM Teaching))
		GROUP BY studId
		HAVING COUNT(*) = 
			(SELECT COUNT(*) FROM Course WHERE deptId = @v8 AND crsCode IN (SELECT crsCode FROM Teaching))) as alias
WHERE id = alias.studId;

WITH mat_cnt AS (
SELECT COUNT(DISTINCT crsCode) as mat_cls_cnt
FROM Course
WHERE deptId = 'MAT'),

std_cnt AS (
SELECT s.id, s.name, COUNT(s.id) as std_mat_cnt
FROM Student AS s
JOIN Transcript AS t
ON s.id = t.studId
JOIN Course AS c
ON t.crsCode = c.crsCode
WHERE c.deptId = 'MAT'
GROUP BY s.id, s.name)

SELECT std_cnt.name
FROM std_cnt
JOIN mat_cnt
ON std_cnt.std_mat_cnt = mat_cnt.mat_cls_cnt;