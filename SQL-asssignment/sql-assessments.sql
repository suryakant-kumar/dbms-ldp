-- Create required schema of assessment table
CREATE TABLE IF NOT EXISTS assessments (
  id INT NOT NULL unique,
  experience INT not null,
  `sql` INT,
  algo INT,
  bug_fixing INT,
  CHECK (`sql` BETWEEN 0 AND 100 ),
  CHECK (algo BETWEEN 0 AND 100 ),
  CHECK (bug_fixing BETWEEN 0 AND 100 )
);



-- Test case :1 
insert into assessments 
values (1, 3, 100, null, 50),
	   (2, 5, null, 100, 100),
       (3, 1, 100, 100, 100),
       (4, 5, 100, 50, null),
       (5, 5, 100, 100, 100);

-- soln:
SELECT a.experience, 
	   sum(
		CASE WHEN (a.algo IS NULL OR a.algo = 100) AND 
				  (a.sql IS NULL OR a.sql = 100) AND 
                  (a.bug_fixing IS NULL OR a.bug_fixing = 100) THEN 1
		     ELSE 0
		END    
       ) AS max,
       count(*) AS count
FROM assessments a
GROUP BY a.experience
ORDER BY a.experience DESC;



-- Delte the assessments table data
delete from assessments;



-- Test case :2
insert into assessments 
values (1, 2, null, null, null),
	   (2, 20, null, null, 20),
       (3, 7, 100, null, 100),
       (4, 3, 100, 50, null),
       (5, 2, 40, 100, 100);
       
-- soln:       
SELECT a.experience, 
	   sum(
		CASE WHEN (a.algo IS NULL OR a.algo = 100) AND 
				  (a.sql IS NULL OR a.sql = 100) AND 
                  (a.bug_fixing IS NULL OR a.bug_fixing = 100) THEN 1
		     ELSE 0
		END    
       ) AS max,
       count(*) AS count
FROM assessments a
GROUP BY a.experience
ORDER BY a.experience DESC;


delete from assessments;
