create database Health_Insurance

use Health_Insurance

select * from [dbo].[health_insurance_dataset]

---Duplicate Check
;WITH CTE AS(
SELECT *,ROW_NUMBER() OVER (PARTITION BY ClaimID ORDER BY ClaimDate) AS rn
FROM [dbo].[health_insurance_dataset]
)
SELECT * FROM CTE
WHERE rn>1


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


---claim status must be valid
SELECT DISTINCT ClaimStatus
FROM [dbo].[health_insurance_dataset]
WHERE ClaimStatus NOT IN ('Approved', 'Denied', 'Pending')

---valid gender
SELECT DISTINCT PatientGender
FROM [dbo].[health_insurance_dataset]
WHERE PatientGender NOT IN ('M', 'F')

---valid salary range
SELECT PatientID, PATIENTINCOME
FROM [dbo].[health_insurance_dataset]
WHERE PATIENTINCOME <= 0 OR PATIENTINCOME > 1000000