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
--SELECT DISTINCT p_mom.name
--FROM person AS p_mom
--WHERE p_mom.name IN
SELECT DISTINCT name
FROM person
WHERE NOT EXISTS
   (SELECT person_a.gender
    FROM person AS person_a
    WHERE person_a.gender NOT IN
        (SELECT person_b.gender
         FROM person AS person_b
         WHERE person_b.mother = person.name)
    )
ORDER BY name
;

-- Q4 returns (name,father,mother)
--Write a query that returns the scheme (name,father,mother) ordered by name that lists the
--name of people who are the first born of their known full siblings. A full sibling is defined
--as a person sharing the same father and mother. Maximum marks will be given only to
--answers that use ALL or SOME to answer the question.
SELECT DISTINCT person_main.name,person_main.father,person_main.mother
FROM person AS person_main,
     person AS person_a
WHERE person_a.father = person_main.father
AND person_a.mother = person_main.mother
AND person_main.dob <= ALL(SELECT person_b.dob
                           FROM person AS person_b
                           WHERE person_b.father = person_main.father
                           AND person_b.mother = person_main.mother
                          )
ORDER BY person_main.name ASC
;

-- Q5 returns (name,popularity)
--Write an SQL query that returns the scheme (name,popularity) ordered by popularity,name
--listing first names and the number of occurances of first names. A first name is taken to
--mean the first word appearing the name column. The most popular first name must be listed
--first, and the list must exclude any first name that appears only once.
SELECT SUBSTRING(name FROM '[A-Za-z]+') AS first_name,
       COUNT(SUBSTRING(name FROM '[A-Za-z]+')) AS popularity
FROM person
GROUP BY first_name
HAVING COUNT(SUBSTRING(name FROM '[A-Za-z]+')) > 1
ORDER BY popularity, fname DESC
;

-- Q6 returns (name,forties,fifties,sixties)
--Write an SQL query that returns the scheme (name,forties,fifties,sixties) ordered by name
--listing one row for each person in the database whom has had at least two children, and for
--each such person, gives three columns forties, fifties and sixties containing the number of that
--person’s children born in those 20th century decades.
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
SELECT DISTINCT father,
       mother,
       ROUND (100*
              COUNT(CASE WHEN gender = 'M' THEN name ELSE NULL END)	OVER (PARTITION BY father)
              /(COUNT(CASE WHEN gender = 'M' THEN name ELSE NULL END)	OVER (PARTITION BY father) +
       		  COUNT(CASE WHEN gender = 'F' THEN name ELSE NULL END)	OVER (PARTITION BY father)),0)
              AS male
FROM person
WHERE father IS NOT NULL
AND mother IS NOT NULL
GROUP BY father,
         mother,
         name
ORDER BY father,
         mother
;
