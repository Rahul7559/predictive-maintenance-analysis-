
-- CREATE OUR PROJECT DATABASE

CREATE DATABASE PredictiveMaintenanceDB;

USE PredictiveMaintenanceDB;


CREATE TABLE MachineData (
    Machine_ID INT,
    Type VARCHAR(10),
    Air_Temperature_K FLOAT,
    Process_Temperature_K FLOAT,
    Rotational_Speed_RPM FLOAT,
    Torque_Nm FLOAT,
    Tool_Wear_Min FLOAT,
    Temperature_Difference_K FLOAT,
    Power_Proxy FLOAT,
    Machine_Failure INT
);

SELECT *
FROM MachineData;

-- CHECKING THE IMPORTED TABLE 

USE PredictiveMaintenanceDB;

SELECT TOP 10 *
FROM MachineData;

-- CHECKING TOTAL NUMBER OF RECORDS

SELECT COUNT(*) AS Total_Records
FROM MachineData;

-- CHECKING MACHINE FAILURE DISTRIBUTION 

SELECT 
    machine_failure,
    COUNT(*) AS Machine_Count
FROM MachineData
GROUP BY machine_failure;

-- CHECK WHETHER SQL SERVER CAN SEE THE TABLE 

USE PredictiveMaintenanceDB;

SELECT 
    TABLE_SCHEMA,
    TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES;


-- CHECKING ai4i2020

SELECT COUNT(*) AS TotalRows
FROM dbo.ai4i2020;

-- PREVIEW THE DATA 

SELECT TOP 10 *
FROM dbo.ai4i2020;

--USE PredictiveMaintenanceDB;

SELECT 
    t.name AS TableName,
    SUM(p.rows) AS [TotalRows]
FROM sys.tables t
INNER JOIN sys.partitions p
    ON t.object_id = p.object_id
WHERE p.index_id IN (0, 1)
GROUP BY t.name
ORDER BY t.name;

-- CREATE AN ANALYSIS VIEW 

USE PredictiveMaintenanceDB;

CREATE VIEW vw_MachineAnalysis AS
SELECT
    UDI,
    Product_ID,
    Type,
    Air_temperature_k,
    Process_temperature_k,
    Rotational_speed_rpm,
    Torque_Nm,
    Tool_wear_min,
    machine_failure,
    TWF,
    HDF,
    PWF,
    OSF,
    RNF,

    -- Feature Engineering
    Process_temperature_k - Air_temperature_k AS Temperature_Difference_K,

    Rotational_speed_rpm * Torque_Nm AS Power_Proxy,

    -- Failure Status
    CASE
        WHEN machine_failure = 1 THEN 'Failure'
        ELSE 'No Failure'
    END AS Failure_Status

FROM dbo.ai4i2020;

-- CHECK THE VIEW 

SELECT TOP 10 *
FROM dbo.vw_MachineAnalysis;

-- OVERALL FAILURE KPIs

SELECT
    COUNT(*) AS Total_Machines,
    SUM(machine_failure) AS Total_Failures,
    COUNT(*) - SUM(machine_failure) AS No_Failure
FROM dbo.vw_MachineAnalysis;

SELECT
    COUNT(*) AS Total_Machines,
    SUM(machine_failure) AS Total_Failures,
    CAST(
        SUM(machine_failure) * 100.0 / COUNT(*)
        AS DECIMAL(10,2)
    ) AS Failure_Rate_Percent
FROM dbo.vw_MachineAnalysis;

-- FAILURE BY MACHINE TYPE 

SELECT
    Type,
    COUNT(*) AS Total_Machines,
    SUM(machine_failure) AS Total_Failures,
    CAST(
        SUM(machine_failure) * 100.0 / COUNT(*)
        AS DECIMAL(10,2)
    ) AS Failure_Rate_Percent
FROM dbo.vw_MachineAnalysis
GROUP BY Type
ORDER BY Failure_Rate_Percent DESC;

-- FAILURE TYPE ANALYSIS

 USE PredictiveMaintenanceDB;

SELECT
    'TWF - Tool Wear Failure' AS Failure_Type,
    SUM(TWF) AS Failure_Count
FROM dbo.vw_MachineAnalysis

UNION ALL

SELECT
    'HDF - Heat Dissipation Failure',
    SUM(HDF)
FROM dbo.vw_MachineAnalysis

UNION ALL

SELECT
    'PWF - Power Failure',
    SUM(PWF)
FROM dbo.vw_MachineAnalysis

UNION ALL

SELECT
    'OSF - Overstrain Failure',
    SUM(OSF)
FROM dbo.vw_MachineAnalysis

UNION ALL

SELECT
    'RNF - Random Failure',
    SUM(RNF)
FROM dbo.vw_MachineAnalysis;

-- TOOL WEAR ANALYSIS 

SELECT
    CASE
        WHEN Tool_Wear_min <= 50 THEN '0-50'
        WHEN Tool_Wear_min <= 100 THEN '51-100'
        WHEN Tool_Wear_min <= 150 THEN '101-150'
        WHEN Tool_Wear_min <= 200 THEN '151-200'
        ELSE '201+'
    END AS Tool_Wear_Band,

    COUNT(*) AS Total_Machines,
    SUM(machine_failure) AS Total_Failures,

    CAST(
        SUM(machine_failure) * 100.0 / COUNT(*)
        AS DECIMAL(10,2)
    ) AS Failure_Rate_Percent

FROM dbo.vw_MachineAnalysis

GROUP BY
    CASE
        WHEN Tool_Wear_min <= 50 THEN '0-50'
        WHEN Tool_Wear_min <= 100 THEN '51-100'
        WHEN Tool_Wear_min <= 150 THEN '101-150'
        WHEN Tool_Wear_min <= 200 THEN '151-200'
        ELSE '201+'
    END

ORDER BY
    MIN(Tool_Wear_min);

-- ROTATIONAL SPEED AND TORQUE 

SELECT
    machine_failure,
    COUNT(*) AS Machine_Count,
    AVG(Rotational_Speed_rpm) AS Avg_Rotational_Speed,
    AVG(Torque_Nm) AS Avg_Torque,
    AVG(Power_Proxy) AS Avg_Power_Proxy
FROM dbo.vw_MachineAnalysis
GROUP BY machine_failure;

-- TEMPERATURE ANALYSIS

SELECT
    machine_failure,
    COUNT(*) AS Machine_Count,
    AVG(Air_Temperature_k) AS Avg_Air_Temperature,
    AVG(Process_Temperature_k) AS Avg_Process_Temperature,
    AVG(Temperature_Difference_K) AS Avg_Temperature_Difference
FROM dbo.vw_MachineAnalysis
GROUP BY machine_failure;

-- POWER PROXY ANALYSIS 

SELECT
    CASE
        WHEN Power_Proxy < 50000 THEN 'Low'
        WHEN Power_Proxy < 100000 THEN 'Medium'
        ELSE 'High'
    END AS Power_Band,

    COUNT(*) AS Total_Machines,
    SUM(machine_failure) AS Total_Failures,

    CAST(
        SUM(machine_failure) * 100.0 / COUNT(*)
        AS DECIMAL(10,2)
    ) AS Failure_Rate_Percent

FROM dbo.vw_MachineAnalysis

GROUP BY
    CASE
        WHEN Power_Proxy < 50000 THEN 'Low'
        WHEN Power_Proxy < 100000 THEN 'Medium'
        ELSE 'High'
    END;

-- CREATING THE FINAL POWER BI VIEW 

USE PredictiveMaintenanceDB;
GO

CREATE VIEW dbo.vw_PowerBI_MachineAnalysis AS
SELECT
    UDI,
    Product_ID,
    Type,

    Air_temperature_k,
    Process_temperature_k,
    Rotational_speed_rpm,
    Torque_Nm,
    Tool_Wear_min,

    machine_failure,
    Failure_Status,

    TWF,
    HDF,
    PWF,
    OSF,
    RNF,

    Temperature_Difference_K,
    Power_Proxy,

    CASE
        WHEN Tool_Wear_min <= 50 THEN '0-50'
        WHEN Tool_Wear_min <= 100 THEN '51-100'
        WHEN Tool_Wear_min <= 150 THEN '101-150'
        WHEN Tool_Wear_min <= 200 THEN '151-200'
        ELSE '201+'
    END AS Tool_Wear_Band,

    CASE
        WHEN Power_Proxy < 50000 THEN 'Low'
        WHEN Power_Proxy < 100000 THEN 'Medium'
        ELSE 'High'
    END AS Power_Band,

    CASE
        WHEN TWF = 1 THEN 'Tool Wear Failure'
        WHEN HDF = 1 THEN 'Heat Dissipation Failure'
        WHEN PWF = 1 THEN 'Power Failure'
        WHEN OSF = 1 THEN 'Overstrain Failure'
        WHEN RNF = 1 THEN 'Random Failure'
        WHEN machine_failure = 1 THEN 'Other Failure'
        ELSE 'No Failure'
    END AS Failure_Type

FROM dbo.vw_MachineAnalysis;

-- VALIDATE THE POWER BI VIEW 

SELECT TOP 10 *
FROM dbo.vw_PowerBI_MachineAnalysis;

-- CHECKING TOTAL ROWS 

SELECT COUNT(*) AS TotalRows
FROM dbo.vw_PowerBI_MachineAnalysis;

SELECT
    Failure_Status,
    COUNT(*) AS Machine_Count
FROM dbo.vw_PowerBI_MachineAnalysis
GROUP BY Failure_Status;

-- CONNECT SQL SERVER TO POWER BI 

