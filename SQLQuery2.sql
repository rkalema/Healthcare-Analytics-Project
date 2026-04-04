USE HealthcareAnalytics;
GO

IF OBJECT_ID('Dim_NursingDemographics', 'U') IS NOT NULL
    DROP TABLE Dim_NursingDemographics;
GO

CREATE TABLE Dim_NursingDemographics (
    License_Type NVARCHAR(100),
    Region NVARCHAR(100),
    Age_Group NVARCHAR(50),
    Sex NVARCHAR(50),
    Weighted_Value FLOAT,
    Survey_Count INT
);
GO

INSERT INTO Dim_NursingDemographics (License_Type, Region, Age_Group, Sex, Weighted_Value, Survey_Count)
SELECT 
    TRIM(License_Type), 
    TRIM(Region), 
    TRIM(Age), 
    TRIM(Sex),
    TRY_PARSE(REPLACE(Weighted_Value, ',', '') AS FLOAT), 
    TRY_PARSE(REPLACE(N_Count, ',', '') AS INT) 
FROM Nursing_Workforce 
WHERE License_Type NOT LIKE 'License Type%' 
  AND License_Type NOT LIKE '2022 Demographics%';
GO

SELECT TOP 10 * FROM Dim_NursingDemographics;