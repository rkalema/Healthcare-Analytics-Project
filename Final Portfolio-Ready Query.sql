USE HealthcareAnalytics;
GO


SELECT 
    d.Region,
    d.Percent_Aging_Risk,
    COUNT(p.PatientID) AS Total_Patients,
    AVG(p.RiskScore) AS Avg_Patient_Risk
FROM (
    
    SELECT Region, (SUM(CASE WHEN Age_Group IN ('55-59', '60-64', '65 or older') THEN Weighted_Value ELSE 0 END) / SUM(Weighted_Value)) * 100 as Percent_Aging_Risk
    FROM Dim_NursingDemographics
    WHERE License_Type = 'All RNs'
    GROUP BY Region
) d
LEFT JOIN Patients_dim p ON p.InsuranceType = 'Private' 
GROUP BY d.Region, d.Percent_Aging_Risk
ORDER BY d.Percent_Aging_Risk DESC;