-- Analyzing factors associated with 30-day hosptical readmission
-- Find the overall rate of 30 daya readmission to determine the quality of service
-- 1.find the overall hosptial encounter 
SELECT 
    COUNT(*) AS total_encounter 
FROM hospital_encounters

-- 2. find the overall hospital encounters associated with less than 30 readmission
SELECT 
    COUNT(*) AS readmitted_30
    FROM hospital_encounters
WHERE readmitted= '<30'

-- 3. find the rate of overall hospital encounters associated with less than 30 readmission
SELECT
    COUNT(*) AS total,
    100.0 * SUM(CASE WHEN readmitted = '<30' THEN 1 ELSE 0 END) / COUNT (*) AS readmitted_30_rate
FROM hospital_encounters

-- 4. Round the rate
SELECT
    COUNT(*) AS total,
    SUM(CASE WHEN readmitted = '<30' THEN 1 ELSE 0 END) AS readmitted_30_rate,
    ROUND (100.0 * SUM(CASE WHEN readmitted = '<30' THEN 1 ELSE 0 END) / COUNT (*),2) AS readmitted_30_rateroundoff
FROM hospital_encounters

-- 5. Formate the rate as rate percentage
SELECT
    COUNT(*) AS total,
    SUM(CASE WHEN readmitted = '<30' THEN 1 ELSE 0 END) AS readmitted_30_rate,
    ROUND (100.0 * SUM(CASE WHEN readmitted = '<30' THEN 1 ELSE 0 END) / COUNT (*),2) AS readmitted_30_rateroundoff,
    FORMAT(ROUND (100.0 * SUM(CASE WHEN readmitted = '<30' THEN 1 ELSE 0 END) / COUNT (*),2), 'N2') + '%' AS readmission30_ratepercent
FROM hospital_encounters

-- "“The overall 30-day readmission rate is approximately 11.16%, indicating that about one in nine hospital encounters result in early readmission.”
-- Factor 1 - age 
-- 1. find of no of readmission less than 30 in each age caetory

SELECT 
    age,
    SUM(CASE WHEN readmitted = '<30' THEN 1 ELSE 0 END) AS readmission_count
FROM hospital_encounters
GROUP BY age
ORDER BY age

-- 2. find the rate of readmission less than 30 in each age caetory
SELECT 
    age,
    SUM(CASE WHEN readmitted = '<30' THEN 1 ELSE 0 END) AS readmission_count,
    100.0 * SUM(CASE WHEN readmitted = '<30' THEN 1 ELSE 0 END)/COUNT(*) AS readmission_rate
FROM hospital_encounters
GROUP BY age
ORDER BY age
-- 3. find the ratepercent of readmission less than 30 in each age caetory
SELECT 
    age,
    SUM(CASE WHEN readmitted = '<30' THEN 1 ELSE 0 END) AS readmission_count,
    100.0 * SUM(CASE WHEN readmitted = '<30' THEN 1 ELSE 0 END)/COUNT(*) AS readmission_rate,
    ROUND(100.0 * SUM(CASE WHEN readmitted = '<30' THEN 1 ELSE 0 END)/COUNT(*),2) AS readmi_rate_roundvalue,
    FORMAT(ROUND(100.0 * SUM(CASE WHEN readmitted = '<30' THEN 1 ELSE 0 END)/COUNT(*),2), 'N2') + '%' AS readmi_rate_perc
FROM hospital_encounters
GROUP BY age
ORDER BY age

-- 4. Find which age group has the highest readmission rate percentage 
SELECT 
    age,
    COUNT(*) AS total_encounters,
    SUM(CASE WHEN readmitted = '<30' THEN 1 ELSE 0 END) AS readmission30_count,
    100.0 * SUM(CASE WHEN readmitted = '<30' THEN 1 ELSE 0 END)/COUNT(*) AS readmission_rate,
    ROUND(100.0 * SUM(CASE WHEN readmitted = '<30' THEN 1 ELSE 0 END)/COUNT(*),2) AS readmi_rate_roundvalue,
    FORMAT(ROUND(100.0 * SUM(CASE WHEN readmitted = '<30' THEN 1 ELSE 0 END)/COUNT(*),2), 'N2') + '%' AS readmi_rate_perc
FROM hospital_encounters
GROUP BY age
ORDER BY readmi_rate_roundvalue DESC 

-- patients aged 20–30 show the highest 30-day readmission rate (14.24%), 
-- older age groups such as 70–90 account for the largest number of readmissions due to significantly higher encounter volumes. 
-- This highlights a distinction between high-risk groups and high-impact groups.

-- Factor 2 - stay duration
-- 1. categorize the each encounter based on the stay duration
-- 2. find the total encounters, no.of. readmissions less than 30 in each stau duration category, readmission rate percentanceg for each category to determine the highest readmission rate.

SELECT
    CASE 
        WHEN time_in_hospital <= 3 THEN 'Short Stay (<=3 days)'
        WHEN time_in_hospital BETWEEN 4 AND 7 THEN 'Medium Stay (4–7 days)'
        ELSE 'Long Stay (>7 days)'
    END AS stay_group,
    COUNT(*) AS total_encounters,
    SUM(CASE WHEN readmitted = '<30' THEN 1 ELSE 0 END) AS readmitted_30_count,
    ROUND(
        100.0 * SUM(CASE WHEN readmitted = '<30' THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS readmission_rate_percent
FROM dbo.hospital_encounters
GROUP BY 
    CASE 
        WHEN time_in_hospital <= 3 THEN 'Short Stay (<=3 days)'
        WHEN time_in_hospital BETWEEN 4 AND 7 THEN 'Medium Stay (4–7 days)'
        ELSE 'Long Stay (>7 days)'
    END
ORDER BY readmission_rate_percent DESC;

-- “Readmission risk increases with length of hospital stay. Patients with stays longer than 7 days show the highest 30-day readmission rate (13.37%), indicating higher clinical complexity and the need for targeted discharge and follow-up interventions.”


-- Factor 3 - Relation between patient's prior inpatient or emergency visit and 30-day readmission risk
SELECT 
CASE 
    WHEN number_inpatient = 0 THEN 'No Prior Inpatient'
    ELSE 'Had Prior Inpatient'
END AS prior_inpatient_group,
COUNT(*) AS total_encounters,
    SUM(CASE WHEN readmitted = '<30' THEN 1 ELSE 0 END) AS readmitted_30_count,
    ROUND(
        100.0 * SUM(CASE WHEN readmitted = '<30' THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS readmission_rate_percent
FROM hospital_encounters
GROUP BY 
    CASE 
        WHEN number_inpatient = 0 THEN 'No Prior Inpatient'
        ELSE 'Had Prior Inpatient'
    END
ORDER BY readmission_rate_percent DESC

-- Patients with a prior inpatient hospitalization are nearly twice as likely to be readmitted within 30 days compared to patients with no prior inpatient history.

SELECT
    CASE 
        WHEN number_emergency = 0 THEN 'No Prior Emergency'
        ELSE 'Had Prior Emergency'
    END AS prior_emergency_group,
    COUNT(*) AS total_encounters,
    SUM(CASE WHEN readmitted = '<30' THEN 1 ELSE 0 END) AS readmitted_30_count,
    ROUND(
        100.0 * SUM(CASE WHEN readmitted = '<30' THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS readmission_rate_percent
FROM hospital_encounters
GROUP BY 
    CASE 
        WHEN number_emergency = 0 THEN 'No Prior Emergency'
        ELSE 'Had Prior Emergency'
    END
ORDER BY readmission_rate_percent DESC

-- Patients with a history of emergency department visits are approximately 1.6 times more likely to be readmitted within 30 days compared to patients with no prior emergency visits.


-- Create an age group table to analyze the readmission risk based on age group level

CREATE TABLE dim_age_group (
    age VARCHAR(10),
    age_group_label VARCHAR(20)
);
-- Insert data into the age group table
INSERT INTO dim_age_group VALUES
('[0-10)', 'Child'),
('[10-20)', 'Teen'),
('[20-30)', 'Young Adult'),
('[30-40)', 'Adult'),
('[40-50)', 'Mid Adult'),
('[50-60)', 'Senior'),
('[60-70)', 'Senior'),
('[70-80)', 'Elderly'),
('[80-90)', 'Elderly'),
('[90-100)', 'Very Elderly');
-- Join the age gorup level to the hospital encounter table to check the relationship
SELECT
    d.age_group_label,
    COUNT(*) AS total_encounters,
    SUM(CASE WHEN h.readmitted = '<30' THEN 1 ELSE 0 END) AS readmitted_30_count,
    ROUND(
        100.0 * SUM(CASE WHEN h.readmitted = '<30' THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS readmission_rate_percent
FROM hospital_encounters h   -- FACT TABLE
JOIN dim_age_group d         -- DIMENSION TABLE
    ON h.age = d.age
GROUP BY d.age_group_label
ORDER BY readmission_rate_percent DESC;
