-- ================================
-- Sample Data for Hospital Admissions & Patient Flow Database
-- ================================

-- Insert Patients
INSERT INTO healthcare_admissions.Patients (FirstName, LastName, DateOfBirth, Gender, PhoneNumber, Address)
VALUES
('John', 'Smith', '1985-03-12', 'M', '07123456789', '12 King St, Liverpool'),
('Mary', 'Johnson', '1990-07-25', 'F', '07234567890', '34 Queen Rd, Manchester'),
('James', 'Williams', '1975-11-04', 'M', '07345678901', '56 High St, London'),
('Patricia', 'Brown', '1982-02-17', 'F', '07456789012', '78 Park Ave, Birmingham'),
('Robert', 'Taylor', '1968-09-30', 'M', '07567890123', '90 Church Ln, Leeds'),
('Linda', 'Davis', '2000-05-21', 'F', '07678901234', '22 College St, Liverpool'),
('Michael', 'Miller', '1995-12-10', 'M', '07789012345', '14 Bridge Rd, Manchester'),
('Barbara', 'Wilson', '1988-08-18', 'F', '07890123456', '65 Hill St, Newcastle'),
('William', 'Moore', '1972-04-09', 'M', '07901234567', '32 Oak Rd, Sheffield'),
('Elizabeth', 'Anderson', '1999-06-14', 'F', '07012345678', '47 Grove St, Bristol');

-- Insert Doctors
INSERT INTO healthcare_admissions.Doctors (FirstName, LastName, Specialty, PhoneNumber)
VALUES
('Alice', 'Evans', 'Cardiology', '07111222333'),
('Brian', 'Thomas', 'General Surgery', '07222333444'),
('Clara', 'Roberts', 'Neurology', '07333444555'),
('David', 'Walker', 'Pediatrics', '07444555666'),
('Emily', 'Hall', 'Internal Medicine', '07555666777');

-- Insert Wards
INSERT INTO healthcare_admissions.Wards (WardName, Capacity)
VALUES
('Cardiology Ward', 30),
('General Surgery Ward', 40),
('Neurology Ward', 25);

-- Insert Admissions
INSERT INTO healthcare_admissions.Admissions (PatientID, DoctorID, WardID, MedicalCondition, AdmissionDate, DischargeDate, AdmissionType)
VALUES
(1, 1, 1, 'Hypertension', '2023-01-10', '2023-01-15', 'Elective'),
(2, 2, 2, 'Appendicitis', '2023-02-05', '2023-02-12', 'Emergency'),
(3, 3, 3, 'Epilepsy', '2023-03-18', NULL, 'Elective'),
(4, 4, 2, 'Asthma', '2023-04-01', '2023-04-07', 'Emergency'),
(5, 5, 1, 'Diabetes', '2023-05-11', '2023-05-18', 'Elective'),
(6, 1, 1, 'Coronary Artery Disease', '2023-06-03', NULL, 'Emergency'),
(7, 2, 2, 'Gallstones', '2023-07-21', '2023-07-27', 'Elective'),
(8, 3, 3, 'Brain Tumor', '2023-08-15', NULL, 'Emergency'),
(9, 4, 2, 'Pneumonia', '2023-09-09', '2023-09-16', 'Emergency'),
(10, 5, 1, 'Chronic Kidney Disease', '2023-10-22', NULL, 'Elective');

-- Insert Medications
INSERT INTO healthcare_admissions.Medications (AdmissionID, MedicationName, Dosage, Frequency, StartDate, EndDate)
VALUES
(1, 'Lisinopril', '10mg', 'Once daily', '2023-01-10', '2023-01-15'),
(2, 'Amoxicillin', '500mg', 'Three times daily', '2023-02-05', '2023-02-12'),
(3, 'Valproate', '500mg', 'Twice daily', '2023-03-18', NULL),
(4, 'Salbutamol', '2 puffs', 'As needed', '2023-04-01', '2023-04-07'),
(5, 'Metformin', '500mg', 'Twice daily', '2023-05-11', NULL),
(6, 'Aspirin', '75mg', 'Once daily', '2023-06-03', NULL),
(7, 'Ursodiol', '300mg', 'Twice daily', '2023-07-21', '2023-07-27'),
(8, 'Dexamethasone', '4mg', 'Once daily', '2023-08-15', NULL),
(9, 'Azithromycin', '250mg', 'Once daily', '2023-09-09', '2023-09-16'),
(10, 'Furosemide', '40mg', 'Once daily', '2023-10-22', NULL);

-- Insert Test Results
INSERT INTO healthcare_admissions.TestResults (AdmissionID, TestName, Result, TestDate)
VALUES
(1, 'Blood Pressure Test', '160/100 mmHg', '2023-01-11'),
(2, 'CT Scan', 'Appendix inflamed', '2023-02-06'),
(3, 'EEG', 'Abnormal spikes detected', '2023-03-19'),
(4, 'Lung Function Test', 'Reduced FEV1', '2023-04-02'),
(5, 'HbA1c', '8.5%', '2023-05-12'),
(6, 'ECG', 'ST depression observed', '2023-06-04'),
(7, 'Ultrasound', 'Gallstones visible', '2023-07-22'),
(8, 'MRI Brain', 'Large mass detected', '2023-08-16'),
(9, 'Chest X-ray', 'Right lung infiltrate', '2023-09-10'),
(10, 'Serum Creatinine', '2.3 mg/dL', '2023-10-23');
