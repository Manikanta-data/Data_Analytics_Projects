SELECT * FROM unclean_smartwatch_health_data;


-- Preview the first 10 rows 
SELECT * FROM unclean_smartwatch_health_data LIMIT 10;

--Count total rows 
SELECT COUNT(*) AS total_records FROM unclean_smartwatch_health_data;

--Count distinct users 
SELECT COUNT(DISTINCT "User ID") AS unique_users FROM unclean_smartwatch_health_data;

-- Average step count per user 
SELECT "User ID", AVG("Step Count") AS avg_steps
FROM unclean_smartwatch_health_data
GROUP BY "User ID"
ORDER BY avg_steps DESC;





--Average stress level per activity level 
SELECT "Activity Level", AVG("Stress Level") AS avg_stress
FROM unclean_smartwatch_health_data
GROUP BY "Activity Level";

--Users with average step count below 5,000 
SELECT "User ID", AVG("Step Count") AS avg_steps
FROM unclean_smartwatch_health_data
GROUP BY "User ID"
HAVING AVG("Step Count") < 5000;





--Distribution of activity levels 
SELECT "Activity Level", COUNT(*) AS count_activity
FROM unclean_smartwatch_health_data
GROUP BY "Activity Level";





-- Summary statistics for key numeric columns
SELECT
    MIN("Step Count") AS min_steps,
    MAX("Step Count") AS max_steps,
    AVG("Step Count") AS avg_steps,
    STDDEV_POP("Step Count") AS std_steps,
    MIN("Sleep Duration (hours)") AS min_sleep,
    MAX("Sleep Duration (hours)") AS max_sleep,
    AVG("Sleep Duration (hours)") AS avg_sleep,
    STDDEV_POP("Sleep Duration (hours)") AS std_sleep,
    MIN("Stress Level") AS min_stress,
    MAX("Stress Level") AS max_stress,
    AVG("Stress Level") AS avg_stress,
    STDDEV_POP("Stress Level") AS std_stress
FROM unclean_smartwatch_health_data;

-- Average sleep duration grouped by activity level
SELECT
    "Activity Level",
    AVG("Sleep Duration (hours)") AS avg_sleep_duration
FROM unclean_smartwatch_health_data
GROUP BY "Activity Level"
ORDER BY avg_sleep_duration DESC;

-- Counts of records by activity level
SELECT
    "Activity Level",
    COUNT(*) AS record_count
FROM unclean_smartwatch_health_data
GROUP BY "Activity Level"
ORDER BY record_count DESC;

-- Step count bins and average stress level per bin
SELECT
    width_bucket("Step Count", 0, 30000, 15) AS step_count_bin,
    AVG("Stress Level") AS avg_stress_level,
    COUNT(*) AS records_in_bin
FROM unclean_smartwatch_health_data
GROUP BY step_count_bin
ORDER BY step_count_bin;

-- Correlation between step count and sleep duration
SELECT corr("Step Count", "Sleep Duration (hours)") AS step_sleep_correlation
FROM unclean_smartwatch_health_data;

-- Records with missing critical data
SELECT *
FROM unclean_smartwatch_health_data
WHERE "Step Count" IS NULL
   OR "Sleep Duration (hours)" IS NULL
   OR "Activity Level" IS NULL;

-- Contingency table for activity level vs stress category
SELECT "Activity Level",
       CASE 
           WHEN "Stress Level" < 3 THEN 'Low'
           WHEN "Stress Level" BETWEEN 3 AND 6 THEN 'Medium'
           ELSE 'High'
       END AS stress_category,
       COUNT(*) AS count
FROM unclean_smartwatch_health_data
GROUP BY "Activity Level", stress_category
ORDER BY "Activity Level", stress_category;
