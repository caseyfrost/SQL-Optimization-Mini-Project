/*
1. The bottleneck was multiple full table scans and a hash join
2. Noticed the bottlenecks in the EP and statistics
3. Fixed with indexes
	3.1. I attempted to add a CTE but that made it slightly slower
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

-- 4. List the names of students who have taken a course taught by professor v5 (name).
SELECT name FROM Student,
	(SELECT studId FROM Transcript,
		(SELECT crsCode, semester FROM Professor
			JOIN Teaching
			WHERE Professor.name = @v5 AND Professor.id = Teaching.profId) as alias1
	WHERE Transcript.crsCode = alias1.crsCode AND Transcript.semester = alias1.semester) as alias2
WHERE Student.id = alias2.studId;

CREATE INDEX profName ON springboardopt.Professor(name);
CREATE INDEX teachProfId ON springboardopt.Teaching(profId);

WITH crs AS (
SELECT
	crsCode
FROM
	Teaching AS t
JOIN
	Professor AS p
ON
	p.id = t.profId AND p.name = @v5 
),

stud AS (
SELECT
	studId
FROM
	Transcript AS t
JOIN
	crs
ON
	t.crsCode = crs.crsCode)
    
SELECT
	s1.name
FROM
	Student AS s1
JOIN
	stud AS s2
ON
	s1.id = s2.studID;
	

