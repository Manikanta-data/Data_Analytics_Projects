SELECT
	*
FROM Telco_Customer_Churn_Data



--Total number of customers and churn count

SELECT 
    COUNT(*) AS total_customers,
    SUM(CASE WHEN "Churn" = 'Yes' THEN 1 ELSE 0 END) AS churned_customers
FROM Telco_Customer_Churn_Data;



--Churn rate by contract type

SELECT 
    "Contract",
    COUNT(*) AS total_customers,
    SUM(CASE WHEN "Churn" = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(100.0 * SUM(CASE WHEN "Churn" = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS churn_rate_percent
FROM Telco_Customer_Churn_Data
GROUP BY "Contract"
ORDER BY churn_rate_percent DESC;


--Average MonthlyCharges and TotalCharges by churn status

SELECT 
    "Churn",
    AVG("MonthlyCharges") AS avg_monthly_charges,
    AVG("TotalCharges") AS avg_total_charges
FROM Telco_Customer_Churn_Data
GROUP BY "Churn";

--Count of customers by tenure groups

SELECT 
    "TenureGroup",
    COUNT(*) AS customer_count
FROM Telco_Customer_Churn_Data
GROUP BY "TenureGroup"
ORDER BY "TenureGroup";


--Percentage of churn by InternetService type
SELECT 
    "InternetService",
    COUNT(*) AS total_customers,
    SUM(CASE WHEN "Churn" = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(100.0 * SUM(CASE WHEN "Churn" = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS churn_rate_percent
FROM Telco_Customer_Churn_Data
GROUP BY "InternetService"


--Count of customers by PaymentMethod and churn status
SELECT 
    "PaymentMethod",
    "Churn",
    COUNT(*) AS count
FROM Telco_Customer_Churn_Data
GROUP BY "PaymentMethod", "Churn"
ORDER BY "PaymentMethod";
ORDER BY churn_rate_percent DESC;

--Average tenure by churn status
SELECT 
    "Churn",
    AVG("tenure") AS avg_tenure
FROM Telco_Customer_Churn_Data
GROUP BY "Churn";

--Customers with high monthly charges but no churn

SELECT *
FROM Telco_Customer_Churn_Data
WHERE "MonthlyCharges" > 100 AND "Churn" = 'No'
ORDER BY "MonthlyCharges" DESC;


--Top 5 cities/customers by count (if there is a city column; replace with actual if present)
-- Replace "City" with the relevant column name if available
SELECT "City", COUNT(*) AS customer_count
FROM Telco_Customer_Churn_Data
GROUP BY "City"
ORDER BY customer_count DESC
LIMIT 5;



--Distribution of contract lengths

SELECT "Contract", COUNT(*) AS count
FROM Telco_Customer_Churn_Data
GROUP BY "Contract"
ORDER BY count DESC;



--Average TotalCharges for customers with Fiber optic internet service

SELECT AVG("TotalCharges") AS avg_total_charges
FROM Telco_Customer_Churn_Data
WHERE "InternetService" = 'Fiber optic';



--Number of customers with multiple services (e.g., PhoneService AND InternetService)

SELECT COUNT(*) AS count_multiple_services
FROM Telco_Customer_Churn_Data
WHERE "PhoneService" = 'Yes' AND "InternetService" != 'No';



--Churn rate by gender

SELECT 
    "gender",
    COUNT(*) AS total_customers,
    SUM(CASE WHEN "Churn" = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(100.0 * SUM(CASE WHEN "Churn" = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS churn_rate_percent
FROM Telco_Customer_Churn_Data
GROUP BY "gender"
ORDER BY churn_rate_percent DESC;



--Average MonthlyCharges by PaymentMethod

SELECT 
    "PaymentMethod",
    AVG("MonthlyCharges") AS avg_monthly_charges
FROM Telco_Customer_Churn_Data
GROUP BY "PaymentMethod"
ORDER BY avg_monthly_charges DESC;


--Count of customers by InternetSecurity status and churn

SELECT 
    "InternetSecurity",
    "Churn",
    COUNT(*) AS count
FROM Telco_Customer_Churn_Data
GROUP BY "InternetSecurity", "Churn"
ORDER BY "InternetSecurity"