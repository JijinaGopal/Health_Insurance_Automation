
use Health_Insurance

Go

TRUNCATE TABLE [dbo].[health_insurance_dataset];


------------------------------------------------------ DATA LOAD ------------------------
BULK INSERT [dbo].[health_insurance_dataset]
FROM 'C:\Users\Administrator\Desktop\Internship\Insurance_Operations\Health Insurance Claims\Automation\health_insurance_dataset.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    CODEPAGE = '65001',
    TABLOCK
);



---Duplicate Check
;WITH CTE AS(
SELECT *,ROW_NUMBER() OVER (PARTITION BY ClaimID ORDER BY ClaimDate) AS rn
FROM [dbo].[health_insurance_dataset]
)
SELECT * FROM CTE
WHERE rn>1

;WITH CTE AS (
SELECT *,ROW_NUMBER() OVER (PARTITION BY ClaimID ORDER BY ClaimDate) AS rn
FROM [dbo].[health_insurance_dataset])
DELETE FROM [dbo].[health_insurance_dataset]
WHERE ClaimID IN (
    SELECT ClaimID FROM CTE WHERE rn > 1
)
AND ClaimDate IN (
    SELECT ClaimDate FROM CTE WHERE rn > 1
)


---Missing values
SELECT *
FROM [dbo].[health_insurance_dataset]
WHERE ClaimID IS NULL
OR PatientID IS NULL
OR ProviderID IS NULL
OR ClaimAmount IS NULL
OR ClaimStatus IS NULL
OR ClaimType IS NULL
OR ClaimDate IS NULL


SELECT 
ISNULL(ClaimID, 'Unknown') AS ClaimID,
ISNULL(PatientID, 'Unknown') AS PatientID,
ISNULL(ProviderID, 'Unknown') AS ProviderID,
ISNULL (CAST(ClaimAmount AS VARCHAR), 'Unknown') AS ClaimAmount,
ISNULL(ClaimStatus, 'Unknown') AS ClaimStatus,
ISNULL(ClaimType, 'Unknown') AS ClaimType,
ISNULL(CONVERT(VARCHAR, ClaimDate, 23), 'Unknown') AS ClaimDate
FROM [dbo].[health_insurance_dataset]
WHERE ClaimID IS NULL
OR PatientID IS NULL
OR ProviderID IS NULL
OR ClaimAmount IS NULL
OR ClaimStatus IS NULL
OR ClaimType IS NULL
OR ClaimDate IS NULL


---Check Claim id is unique
SELECT ClaimID, COUNT(*) AS CountDuplicate
FROM [dbo].[health_insurance_dataset]
GROUP BY ClaimID
HAVING COUNT(*) > 1


---No claim id is mapped to multiple patients
SELECT ClaimID, COUNT(DISTINCT PatientID) AS DistinctPatients
FROM [dbo].[health_insurance_dataset]
GROUP BY ClaimID
HAVING COUNT(DISTINCT PatientID) > 1

---Age between 0 and 120
SELECT PatientID, patientage
FROM [dbo].[health_insurance_dataset]
WHERE patientage < 0 OR patientage > 120

UPDATE [dbo].[health_insurance_dataset]
SET patientage = CASE 
    WHEN patientage < 0 THEN 0
    WHEN patientage > 120 THEN 120
    ELSE patientage
END
WHERE patientage < 0 OR patientage > 120


---claim status must be valid
SELECT DISTINCT ClaimStatus
FROM [dbo].[health_insurance_dataset]
WHERE ClaimStatus NOT IN ('Approved', 'Denied', 'Pending')

SELECT DISTINCT 
    CASE 
        WHEN ClaimStatus NOT IN ('Approved', 'Denied', 'Pending') OR ClaimStatus IS NULL THEN 'Unknown'
        ELSE ClaimStatus
    END AS ClaimStatus
FROM [dbo].[health_insurance_dataset]


---valid gender
SELECT DISTINCT PatientGender
FROM [dbo].[health_insurance_dataset]
WHERE PatientGender NOT IN ('M', 'F')

SELECT DISTINCT 
    CASE 
        WHEN PatientGender NOT IN ('F', 'M') OR PatientGender IS NULL THEN 'Unknown'
        ELSE PatientGender
    END AS PatientGender
FROM [dbo].[health_insurance_dataset]


---valid salary range
SELECT PatientID, PATIENTINCOME
FROM [dbo].[health_insurance_dataset]
WHERE PATIENTINCOME <= 0 

UPDATE [dbo].[health_insurance_dataset]
SET PATIENTINCOME = CASE 
    WHEN patientage < 0 THEN 0
    ELSE patientage
END
WHERE PATIENTINCOME < 0 

