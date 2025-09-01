-- ==============================================
-- Stored Procedures & Triggers
-- Hospital Admissions & Patient Flow Database
-- ==============================================

-- 1. Stored Procedure: Get Patient Readmission Risk
-- Counts how many times a patient has been admitted in the past 12 months.
-- If > 2 admissions, flag as "High Risk", else "Low Risk".
CREATE OR ALTER PROCEDURE healthcare_admissions.GetPatientReadmissionRisk
    @PatientID INT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @AdmissionCount INT;

    SELECT @AdmissionCount = COUNT(*)
    FROM healthcare_admissions.Admissions
    WHERE PatientID = @PatientID
      AND AdmissionDate >= DATEADD(YEAR, -1, GETDATE());

    IF @AdmissionCount > 2
        PRINT 'High Risk of Readmission (' + CAST(@AdmissionCount AS NVARCHAR) + ' admissions in last 12 months)';
    ELSE
        PRINT 'Low Risk of Readmission (' + CAST(@AdmissionCount AS NVARCHAR) + ' admissions in last 12 months)';
END;
GO

-- Example usage:
-- EXEC healthcare_admissions.GetPatientReadmissionRisk @PatientID = 1;


-- 2. Stored Procedure: Get Ward Occupancy
-- Calculates the number of currently admitted patients in a ward vs. capacity.
CREATE OR ALTER PROCEDURE healthcare_admissions.GetWardOccupancy
    @WardID INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT w.WardName,
           w.Capacity,
           COUNT(a.AdmissionID) AS CurrentPatients,
           (COUNT(a.AdmissionID) * 100.0 / w.Capacity) AS OccupancyPercent
    FROM healthcare_admissions.Wards w
    LEFT JOIN healthcare_admissions.Admissions a
        ON w.WardID = a.WardID
       AND a.DischargeDate IS NULL
    WHERE w.WardID = @WardID
    GROUP BY w.WardName, w.Capacity;
END;
GO

-- Example usage:
-- EXEC healthcare_admissions.GetWardOccupancy @WardID = 1;


-- 3. Trigger: Alert if Ward Over Capacity
-- Prevents inserting a new admission if ward occupancy > capacity.
CREATE OR ALTER TRIGGER healthcare_admissions.trg_CheckWardCapacity
ON healthcare_admissions.Admissions
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @WardID INT, @WardCapacity INT, @CurrentOccupancy INT;

    SELECT @WardID = WardID FROM inserted;

    SELECT @WardCapacity = Capacity
    FROM healthcare_admissions.Wards
    WHERE WardID = @WardID;

    SELECT @CurrentOccupancy = COUNT(*)
    FROM healthcare_admissions.Admissions
    WHERE WardID = @WardID
      AND DischargeDate IS NULL;

    IF @CurrentOccupancy > @WardCapacity
    BEGIN
        RAISERROR ('Ward capacity exceeded. Cannot admit more patients.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;
GO

-- Test trigger (try to insert more admissions than ward capacity)
-- INSERT INTO healthcare_admissions.Admissions (PatientID, DoctorID, WardID, MedicalCondition, AdmissionDate, AdmissionType)
-- VALUES (1, 1, 1, 'Test OverCapacity', GETDATE(), 'Emergency');
