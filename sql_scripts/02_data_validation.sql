-- Validating the insertion of data into the hosptial_encounters table

SELECT * FROM hospital_encounters;
-- row count validation
SELECT COUNT(*) FROM hospital_encounters;
-- outcome value validation
SELECT readmitted,
    count(*) AS cnt
FROM hospital_encounters
GROUP BY readmitted;
-- Categorical domain check
SELECT DISTINCT gender
FROM hospital_encounters;

SELECT DISTINCT race
FROM hospital_encounters;

-- mising value assessment 
SELECT
    SUM(CASE WHEN race = '?' OR  race IS NULL THEN 1 ELSE 0 END) AS missing_race,
    SUM(CASE WHEN diag_1 = '?' OR  diag_1 IS NULL THEN 1 ELSE 0 END) AS missing_diag1,
    SUM(CASE WHEN diag_2 = '?' OR  diag_2 IS NULL THEN 1 ELSE 0 END) AS missing_diag2,
    SUM(CASE WHEN diag_3 = '?' OR  diag_3 IS NULL THEN 1 ELSE 0 END) AS missing_diag3
FROM hospital_encounters;
-- range check for numeric fields
SELECT
    MIN(time_in_hospital) AS min_stay,
    MAX(time_in_hospital) AS max_stay
FROM hospital_encounters;

