SELECT
	*
FROM insurance_claims


--Total number of insurance claims
SELECT 
	COUNT(*) AS total_claims
FROM insurance_claims;




--Count of fraudulent vs non-fraudulent claims

SELECT 
	"fraud_reported",
	COUNT(*) AS count
FROM insurance_claims
GROUP BY 1;


--Average total claim amount for fraudulent and non-fraudulent claims

SELECT 
	"fraud_reported",
	AVG("total_claim_amount") AS avg_claim_amount
FROM insurance_claims
GROUP BY 1;


--Total claim amount by vehicle make (top 10)

SELECT 
	"auto_make",
	SUM("total_claim_amount") AS total_claims_amount
FROM insurance_claims
GROUP BY 1
ORDER BY total_claims_amount DESC
LIMIT 10;



--Count of claims by incident type
SELECT 
	"incident_type",
	COUNT(*) AS claim_count
FROM insurance_claims
GROUP BY 1
ORDER BY claim_count DESC;


--Percentage of claims with refunds requested by policy state
SELECT 
	"policy_state",
     100.0 * SUM(CASE WHEN fraud_reported = 'Y' THEN 1 ELSE 0 END) / COUNT(*) AS percent_fraudulent
FROM insurance_claims
GROUP BY 1
ORDER BY percent_fraudulent DESC;


--Average service rating by policy deductible (if exists)

SELECT 
	"policy_deductable",
	AVG("total_claim_amount") AS avg_claim_amount
FROM insurance_claims
GROUP BY 1
ORDER BY 1;


--Customers with multiple claims (more than 1)
SELECT *
FROM insurance_claims
WHERE "insured_zip" IN (
    SELECT "insured_zip"
    FROM insurance_claims
    GROUP BY "insured_zip"
    HAVING COUNT(*) > 1
)
ORDER BY "insured_zip", "incident_date";


--Number of claims per incident city sorted descendin
SELECT 
	"incident_city",
	COUNT(*) AS claim_count
FROM insurance_claims
GROUP BY "incident_city"
ORDER BY claim_count DESC;

--Total claim amount and average claim amount by insured education level
SELECT 
	"insured_education_level", 
     SUM(total_claim_amount) AS total_claim_amount, 
     AVG(total_claim_amount) AS avg_claim_amount
FROM insurance_claims
GROUP BY "insured_education_level"
ORDER BY total_claim_amount DESC;


--Top 5 incident types with the highest average total claim amount
SELECT 
	"incident_type",
	AVG(total_claim_amount) AS avg_claim_amount
FROM insurance_claims
GROUP BY 1
ORDER BY avg_claim_amount DESC
LIMIT 5;



--Count of claims by insured sex and fraud reported
SELECT 
	"insured_sex",
	"fraud_reported", 
	COUNT(*) AS claim_count
FROM insurance_claims
GROUP BY 1, 2
ORDER BY 1, 2;


--Average total claim amount by policy state and fraud reported

SELECT 
	"policy_state",
	"fraud_reported",
	AVG(total_claim_amount) AS avg_claim_amount
FROM insurance_claims
GROUP BY 1, 2
ORDER BY 1;


--Number of claims with injury claim amount greater than 0

SELECT 
	COUNT(*) AS injury_claims_count
FROM insurance_claims
WHERE injury_claim > 0;




--Total and average claim amount by auto_make for claims reported as fraud
SELECT 
	auto_make, 
    SUM(total_claim_amount) AS total_fraud_claims, 
    AVG(total_claim_amount) AS avg_fraud_claim
FROM insurance_claims
WHERE fraud_reported = 'Y'
GROUP BY auto_make
ORDER BY total_fraud_claims DESC;


