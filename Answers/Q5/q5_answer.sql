/*
1. The bottleneck is two full table scans and a hash join
2. Identified in the statistics and execution plan
3. Created a couple of indexes and a couple of CTEs
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

-- 5. List the names of students who have taken a course from department v6 (deptId), but not v7.
SELECT * FROM Student, 
	(SELECT studId FROM Transcript, Course WHERE deptId = @v6 AND Course.crsCode = Transcript.crsCode
	AND studId NOT IN
	(SELECT studId FROM Transcript, Course WHERE deptId = @v7 AND Course.crsCode = Transcript.crsCode)) as alias
WHERE Student.id = alias.studId;

CREATE INDEX crsCode ON springboardopt.Course(crsCode);
CREATE INDEX dept ON springboardopt.Course(deptId);

WITH mgt AS (
SELECT 
	studId 
FROM 
	Transcript,
    Course 
WHERE
	deptId = @v6 AND Course.crsCode = Transcript.crsCode
AND
	studId NOT IN (SELECT studId FROM Transcript, Course WHERE deptId = @v7 AND Course.crsCode = Transcript.crsCode))

SELECT 
	* 
FROM 
	Student
JOIN
	mgt
ON
	Student.id = mgt.studId;
