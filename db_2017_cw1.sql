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
AND name NOT IN (SELECT father
                 FROM person)
;

-- Q3 returns (name)
SELECT *
FROM person
;

-- Q4 returns (name,father,mother)

;

-- Q5 returns (name,popularity)

;

-- Q6 returns (name,forties,fifties,sixties)

;


-- Q7 returns (father,mother,child,born)

;

-- Q8 returns (father,mother,male)
;
