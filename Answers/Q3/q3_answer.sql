/*
1. The bottleneck was a full table scan on the non indexed table
2. I identified teh bottleneck using the EP and QS
3. I created an index for the crsCode field in the Transcript table
	3.1. I also used a join to get rid of the second full table scan
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

-- 3. List the names of students who have taken course v4 (crsCode).
SELECT name FROM Student WHERE id IN (SELECT studId FROM Transcript WHERE crsCode = @v4);

-- Optimized
-- CREATE INDEX crs ON springboardopt.Transcript(crsCode);
-- CREATE INDEX studid ON springboardopt.Transcript(studId);
SELECT 
	name
FROM
	Student
JOIN
	Transcript
ON
	Student.id = Transcript.studId AND Transcript.crsCode = @v4;
