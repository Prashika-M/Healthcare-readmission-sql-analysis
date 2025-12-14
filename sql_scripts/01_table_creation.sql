-- Create a database for healthcare data analytics project
CREATE DATABASE HealthcareAnalytics;
-- Use the healthcare database
Use HealthcareAnalytics;
-- Create table hospital_encounters
CREATE TABLE hospital_encounters (
    encounter_id INT,
    patient_nbr BIGINT,
    race VARCHAR(50),
    gender VARCHAR(10),
    age VARCHAR(10),
    admission_type_id INT,
    discharge_disposition_id INT,
    admission_source_id INT,
    time_in_hospital INT,
    num_lab_procedures INT,
    num_procedures INT,
    num_medications INT,
    number_outpatient INT,
    number_emergency INT,
    number_inpatient INT,
    diag_1 VARCHAR(10),
    diag_2 VARCHAR(10),
    diag_3 VARCHAR(10),
    readmitted VARCHAR(10)
);
-- Altering hosptical_encouters table to rectify the column size error
ALTER TABLE hospital_encounters
ALTER COLUMN gender VARCHAR(50);
-- Insert data
INSERT INTO hospital_encounters (
    encounter_id,
    patient_nbr,
    race,
    gender,
    age,
    admission_type_id,
    discharge_disposition_id,
    admission_source_id,
    time_in_hospital,
    num_lab_procedures,
    num_procedures,
    num_medications,
    number_outpatient,
    number_emergency,
    number_inpatient,
    diag_1,
    diag_2,
    diag_3,
    readmitted
)
SELECT
    encounter_id,
    patient_nbr,
    race,
    gender,
    age,
    admission_type_id,
    discharge_disposition_id,
    admission_source_id,
    time_in_hospital,
    num_lab_procedures,
    num_procedures,
    num_medications,
    number_outpatient,
    number_emergency,
    number_inpatient,
    diag_1,
    diag_2,
    diag_3,
    readmitted
FROM diabetic_data;
