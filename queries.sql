-- ==============================================
-- Advanced SQL Queries for Hospital Admissions DB
-- ==============================================

-- 1. List all patients with their most recent admission (window function)
SELECT FirstName, LastName, MedicalCondition, AdmissionDate, DischargeDate
FROM (
    SELECT p.FirstName, p.LastName, a.MedicalCondition, a.AdmissionDate, a.DischargeDate,
           ROW_NUMBER() OVER (PARTITION BY p.PatientID ORDER BY a.AdmissionDate DESC) AS rn
    FROM healthcare_admissions.Patients p
    JOIN healthcare_admissions.Admissions a ON p.PatientID = a.PatientID
) t
WHERE rn = 1
ORDER BY AdmissionDate DESC;

-- 2. Count admissions per ward
SELECT w.WardName, COUNT(a.AdmissionID) AS TotalAdmissions
FROM healthcare_admissions.Wards w
LEFT JOIN healthcare_admissions.Admissions a ON w.WardID = a.WardID
GROUP BY w.WardName
ORDER BY TotalAdmissions DESC;

-- 3. Average length of stay (LOS) per ward (CTE)
WITH LOS_CTE AS (
    SELECT w.WardName,
           DATEDIFF(DAY, a.AdmissionDate, ISNULL(a.DischargeDate, GETDATE())) AS LengthOfStay
    FROM healthcare_admissions.Wards w
    JOIN healthcare_admissions.Admissions a 
        ON w.WardID = a.WardID
)
SELECT WardName,
       AVG(LengthOfStay) AS AvgLengthOfStay
FROM LOS_CTE
GROUP BY WardName
ORDER BY AvgLengthOfStay DESC;

-- 4. Most common medical conditions
SELECT TOP 5 a.MedicalCondition, COUNT(*) AS CaseCount
FROM healthcare_admissions.Admissions a
GROUP BY a.MedicalCondition
ORDER BY CaseCount DESC;

-- 5. Patients with more than 1 admission (potential readmissions)
SELECT p.PatientID, p.FirstName, p.LastName, COUNT(a.AdmissionID) AS AdmissionCount
FROM healthcare_admissions.Patients p
JOIN healthcare_admissions.Admissions a ON p.PatientID = a.PatientID
GROUP BY p.PatientID, p.FirstName, p.LastName
HAVING COUNT(a.AdmissionID) > 1;

-- 6. Top 3 busiest doctors (by admissions handled)
SELECT TOP 3 d.FirstName, d.LastName, COUNT(a.AdmissionID) AS TotalAdmissions
FROM healthcare_admissions.Doctors d
JOIN healthcare_admissions.Admissions a ON d.DoctorID = a.DoctorID
GROUP BY d.FirstName, d.LastName
ORDER BY TotalAdmissions DESC;

-- 7. Rolling admissions trend (window function)
SELECT a.AdmissionDate,
       COUNT(*) OVER (ORDER BY a.AdmissionDate ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS Rolling7DayAdmissions
FROM healthcare_admissions.Admissions a
ORDER BY a.AdmissionDate;

-- 8. Rank patients by length of stay (window function)
SELECT p.FirstName, p.LastName,
       DATEDIFF(DAY, a.AdmissionDate, ISNULL(a.DischargeDate, GETDATE())) AS LengthOfStay,
       RANK() OVER (ORDER BY DATEDIFF(DAY, a.AdmissionDate, ISNULL(a.DischargeDate, GETDATE())) DESC) AS StayRank
FROM healthcare_admissions.Patients p
JOIN healthcare_admissions.Admissions a ON p.PatientID = a.PatientID;

-- 9. CTE: Find patients with overlapping admissions (possible double-booking)
WITH OrderedAdmissions AS (
    SELECT PatientID, AdmissionDate,
           ISNULL(DischargeDate, GETDATE()) AS DischargeDate,
           LEAD(AdmissionDate) OVER (PARTITION BY PatientID ORDER BY AdmissionDate) AS NextAdmissionDate
    FROM healthcare_admissions.Admissions
)
SELECT PatientID, AdmissionDate, DischargeDate, NextAdmissionDate
FROM OrderedAdmissions
WHERE NextAdmissionDate < DischargeDate;


-- 10. Join admissions with medications and test results for a full patient summary
SELECT p.FirstName + ' ' + p.LastName AS PatientName,
       a.MedicalCondition, a.AdmissionDate, a.DischargeDate,
       m.MedicationName, t.TestName, t.Result
FROM healthcare_admissions.Patients p
JOIN healthcare_admissions.Admissions a ON p.PatientID = a.PatientID
LEFT JOIN healthcare_admissions.Medications m ON a.AdmissionID = m.AdmissionID
LEFT JOIN healthcare_admissions.TestResults t ON a.AdmissionID = t.AdmissionID
ORDER BY a.AdmissionDate DESC;
