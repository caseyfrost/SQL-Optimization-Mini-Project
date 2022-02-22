/*
1. The bottleneck was the id column allwoing nulls and therefore doing a full table scan
2. I identified the bottlneck by looking at the statistics, execution plan, and google 
3. To resolve the bottlneck I altered the id column to be a primary key which creates an index "Primary" and doesn't allow nulls
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

-- 2. List the names of students with id in the range of v2 (id) to v3 (inclusive).
SELECT name FROM Student WHERE id BETWEEN @v2 AND @v3;

-- Optimized
-- DROP INDEX `studentids` ON `springboardopt`.`Student`;
-- ALTER TABLE Student ADD PRIMARY KEY (ID);

ALTER TABLE Student ADD PRIMARY KEY (ID);
SELECT name FROM Student WHERE id BETWEEN @v2 AND @v3;
