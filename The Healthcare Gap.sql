USE HealthcareAnalytics;
GO

WITH RegionalWorkforce AS (
    SELECT 
        Region,
        SUM(Weighted_Value) as TotalNurses,
        SUM(CASE WHEN Age_Group IN ('55-59', '60-64', '65 or older') THEN Weighted_Value ELSE 0 END) as AgingNurses
    FROM Dim_NursingDemographics
    WHERE License_Type = 'All RNs'
    GROUP BY Region
)
SELECT 
    Region,
    CAST(TotalNurses AS INT) as Total_RN_Supply,
    CAST((AgingNurses / TotalNurses) * 100 AS DECIMAL(10,2)) as Percent_Aging_Risk
FROM RegionalWorkforce
WHERE TotalNurses > 0
ORDER BY Percent_Aging_Risk DESC; 