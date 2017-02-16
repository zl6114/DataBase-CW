-- Q1 returns (name,dod)
SELECT person_b.name,
       person_a.dod
FROM person AS person_a,
     person AS person_b
WHERE person_a.name = person_b.mother
AND person_a.dod IS NOT NULL
ORDER BY person_b.name ASC
;

-- Q2 returns (name)
-- Write an SQL query returning the scheme (name) ordered by name that lists men not known
-- to be fathers.
SELECT name
FROM person
WHERE gender = 'M'
AND name IS NOT NULL
AND name NOT IN (SELECT father
                 FROM person
                 WHERE father IS NOT NULL)
ORDER BY name ASC
;
-- Q3 returns (name)
-- Write an SQL query that returns the scheme (name) ordered by name containing the name
-- of mothers who have had every gender of baby that appears in the database. You must not
-- write the query to assume that gender is limited to ’M’ and ’F’.
--SELECT p_mom.name
--FROM person AS p_mom,
--WHERE p_mom.name = (SELECT mother
--                    FROM person JOIN  person
--                    WHERE p_maleChild.gender = 'M')

;

-- Q4 returns (name,father,mother)

;

-- Q5 returns (name,popularity)

;

-- Q6 returns (name,forties,fifties,sixties)

;


-- Q7 returns (father,mother,child,born)
-- Write an SQL query returning the scheme (father,mother,child,born) that lists known fathers
-- and mothers of children, with born being the number of the child of the parents (i.e. re-
-- turning 1 for the first born, 2 for the second born, etc). The result should be ordered by
-- father,mother,born
SELECT father,
       mother,
       name AS child,
       RANK() OVER(PARTITION BY mother ORDER BY dob DESC) AS born
FROM person
WHERE father IS NOT NULL
AND mother IS NOT NULL
ORDER BY father,
         mother,
         born
;

-- Q8 returns (father,mother,male)
-- Write an SQL query that returns the scheme (father,mother,male) ordered by father,mother
-- that lists all pairs of known parents with the percentage (as a whole number) of their children
-- that are male.
SELECT father,
       mother,
       100*
       COUNT(CASE gender WHEN 'M' THEN name ELSE NULL END)
       /
       COUNT(name)
       OVER (PARTITION BY mother) AS male
FROM person
WHERE father IS NOT NULL
AND mother IS NOT NULL
GROUP BY father,
         mother,
         name
ORDER BY father,
         mother
;
