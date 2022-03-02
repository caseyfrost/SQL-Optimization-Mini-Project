/*
1. The bottleneck I identified was a full table scan on the Student table
2. I identified the bottleneck by running the query and checking the execution plan
	2.1. I also checked the table for indexes
3. To solve the bottleneck I ran the SQL command below (which is now commented out)

CREATE INDEX studentids ON springboardopt.Student(id);
*/
CREATE UNIQUE INDEX studentids ON springboardopt.Student(id);

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

-- 1. List the name of the student with id equal to v1 (id).
SELECT name FROM Student WHERE id = @v1;