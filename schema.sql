-- ================================
-- Hospital Admissions & Patient Flow Database
-- Schema: healthcare_admissions
-- ================================

-- Create schema (optional)
CREATE SCHEMA healthcare_admissions;
GO

-- Patients table
CREATE TABLE healthcare_admissions.Patients (
    PatientID INT IDENTITY(1,1) PRIMARY KEY,
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    DateOfBirth DATE NOT NULL,
    Gender CHAR(1) CHECK (Gender IN ('M','F')),
    PhoneNumber NVARCHAR(20),
    Address NVARCHAR(200)
);

-- Doctors table
CREATE TABLE healthcare_admissions.Doctors (
    DoctorID INT IDENTITY(1,1) PRIMARY KEY,
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    Specialty NVARCHAR(100),
    PhoneNumber NVARCHAR(20)
);

-- Wards table
CREATE TABLE healthcare_admissions.Wards (
    WardID INT IDENTITY(1,1) PRIMARY KEY,
    WardName NVARCHAR(100) NOT NULL,
    Capacity INT NOT NULL CHECK (Capacity > 0)
);

-- Admissions table
CREATE TABLE healthcare_admissions.Admissions (
    AdmissionID INT IDENTITY(1,1) PRIMARY KEY,
    PatientID INT NOT NULL,
    DoctorID INT NOT NULL,
    WardID INT NOT NULL,
    MedicalCondition NVARCHAR(200) NOT NULL,
    AdmissionDate DATE NOT NULL,
    DischargeDate DATE NULL,
    AdmissionType NVARCHAR(50) CHECK (AdmissionType IN ('Emergency','Elective')),
    CONSTRAINT FK_Admissions_Patient FOREIGN KEY (PatientID) REFERENCES healthcare_admissions.Patients(PatientID),
    CONSTRAINT FK_Admissions_Doctor FOREIGN KEY (DoctorID) REFERENCES healthcare_admissions.Doctors(DoctorID),
    CONSTRAINT FK_Admissions_Ward FOREIGN KEY (WardID) REFERENCES healthcare_admissions.Wards(WardID)
);

-- Medications table
CREATE TABLE healthcare_admissions.Medications (
    MedicationID INT IDENTITY(1,1) PRIMARY KEY,
    AdmissionID INT NOT NULL,
    MedicationName NVARCHAR(100) NOT NULL,
    Dosage NVARCHAR(50),
    Frequency NVARCHAR(50),
    StartDate DATE,
    EndDate DATE,
    CONSTRAINT FK_Medications_Admission FOREIGN KEY (AdmissionID) REFERENCES healthcare_admissions.Admissions(AdmissionID)
);

-- Test Results table
CREATE TABLE healthcare_admissions.TestResults (
    TestID INT IDENTITY(1,1) PRIMARY KEY,
    AdmissionID INT NOT NULL,
    TestName NVARCHAR(100) NOT NULL,
    Result NVARCHAR(200),
    TestDate DATE NOT NULL,
    CONSTRAINT FK_TestResults_Admission FOREIGN KEY (AdmissionID) REFERENCES healthcare_admissions.Admissions(AdmissionID)
);
