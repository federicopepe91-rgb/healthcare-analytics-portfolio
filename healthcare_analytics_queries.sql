-- =========================================================================
-- Progetto: Healthcare Analytics - Data Warehouse Queries
-- Database: HealthcareDW
-- Descrizione: Script SQL per l'interogazione e l'aggregazione delle metriche 
--             chiave (Fatturato, Ospedali, Patologie e Tipologie di Ricovero)
-- =========================================================================

use HealthcareDW;
GO

-- -------------------------------------------------------------------------
-- 1. TOP OSPEDALI PER FATTURATO (Utilizzato per il grafico a barre in Power BI)
-- -------------------------------------------------------------------------
SELECT 
    h.Hospital,
    COUNT(f.VisitKey) AS Totale_Ricoveri,
    SUM(f.Billing_Amount) AS Fatturato_Totale
FROM dbo.FactHospitalVisits_pulita f
JOIN dbo.DimHospitals_pulita h ON f.HospitalKey = h.HospitalKey -- (o la chiave di join corretta)
GROUP BY h.Hospital
ORDER BY Fatturato_Totale DESC;


-- -------------------------------------------------------------------------
-- 2. ANALISI ECONOMICA PER PATOLOGIA E TIPOLOGIA DI RICOVERO 
--    (Utilizzato per la matrice di dettaglio)
-- -------------------------------------------------------------------------
SELECT 
    f.Medical_Condition,
    SUM(CASE WHEN f.Admission_Type = 'Elective' THEN f.Billing_Amount ELSE 0 END) AS Elettivo,
    SUM(CASE WHEN f.Admission_Type = 'Emergency' THEN f.Billing_Amount ELSE 0 END) AS Emergenza,
    SUM(CASE WHEN f.Admission_Type = 'Urgent' THEN f.Billing_Amount ELSE 0 END) AS Urgente,
    SUM(f.Billing_Amount) AS Total_Billing
FROM dbo.FactHospitalVisits_pulita f
GROUP BY f.Medical_Condition
ORDER BY Total_Billing DESC;


-- -------------------------------------------------------------------------
-- 3. KPI GENERALI: Pazienti unici e degenza media complessiva
-- -------------------------------------------------------------------------
SELECT 
    COUNT(DISTINCT f.Name) AS Pazienti_Unici,
    ROUND(AVG(CAST(DATEDIFF(day, f.Date_of_Admission, f.Discharge_Date) AS FLOAT)), 2) AS Media_Giorni_Degenza,
    SUM(f.Billing_Amount) AS Fatturato_Complessivo
FROM dbo.FactHospitalVisits_pulita f;