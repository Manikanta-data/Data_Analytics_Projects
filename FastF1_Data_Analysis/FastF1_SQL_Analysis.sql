select *
from fastf1_data


-- 1. Count number of laps per driver
SELECT 
	"Driver",
	COUNT(*) AS lap_count
FROM fastf1_data
GROUP BY "Driver"
ORDER BY lap_count DESC;


-- 2. Find the fastest lap time (min LapTime) for each driver (in seconds)
SELECT 
	"Driver",
	MIN(EXTRACT(EPOCH FROM "LapTime"::interval)) AS fastest_lap_seconds
FROM fastf1_data
GROUP BY "Driver"
ORDER BY fastest_lap_seconds ASC;


-- 3. Average lap time per driver (in seconds)
SELECT
	"Driver",
	AVG(EXTRACT(EPOCH FROM "LapTime"::interval)) AS avg_laptime_seconds
FROM fastf1_data
GROUP BY "Driver"
ORDER BY avg_laptime_seconds ASC;

-- 4. Count laps by tyre compound
SELECT
	"Compound",
	COUNT(*) AS lap_count
FROM fastf1_data
GROUP BY "Compound"
ORDER BY lap_count DESC;


-- 5. Average tyre life (TyreLife) by compound
SELECT
	"Compound",
	AVG("TyreLife") AS avg_tyre_life
FROM fastf1_data
GROUP BY "Compound"
ORDER BY avg_tyre_life DESC;


-- 6. Percentage of null values per column (example for selected columns)
SELECT
  100.0 * SUM(CASE WHEN "PitInTime" IS NULL THEN 1 ELSE 0 END) / COUNT(*) AS pct_null_pitintime,
  100.0 * SUM(CASE WHEN "LapTime" IS NULL THEN 1 ELSE 0 END) / COUNT(*) AS pct_null_laptime,
  100.0 * SUM(CASE WHEN "Compound" IS NULL THEN 1 ELSE 0 END) / COUNT(*) AS pct_null_compound
FROM fastf1_data;

-- 7. Number of pit stops per driver (count of non-null PitInTime)
SELECT 
	"Driver",
	COUNT("PitInTime") AS pit_stop_count
FROM fastf1_data
WHERE "PitInTime" IS NOT NULL
GROUP BY "Driver"
ORDER BY pit_stop_count DESC;



-- 8. Number of laps per driver per stint
SELECT 
	"Driver",
	"Stint",
	COUNT("LapNumber") AS laps_in_stint
FROM fastf1_data
GROUP BY 1,2
ORDER BY 1,2


-- 9. Fastest sector times per driver (in seconds)
SELECT "Driver",
       MIN(EXTRACT(EPOCH FROM "Sector1Time"::interval)) AS sec1_fastest,
       MIN(EXTRACT(EPOCH FROM "Sector2Time"::interval)) AS sec2_fastest,
       MIN(EXTRACT(EPOCH FROM "Sector3Time"::interval)) AS sec3_fastest
FROM fastf1_data
GROUP BY "Driver"
ORDER BY sec1_fastest ASC;


-- 10. Position changes of drivers over laps - lap-wise last position per driver
SELECT 
	"LapNumber",
	"Driver",
	MIN("Position") AS position
FROM fastf1_data
WHERE "Position" IS NOT NULL
GROUP BY "LapNumber", "Driver"
ORDER BY "LapNumber", position;

--11. Lap Consistency: Lap Time Standard Deviation by Driver
SELECT 
  "Driver", 
  AVG(EXTRACT(EPOCH FROM "LapTime"::interval)) AS avg_laptime_sec,
  STDDEV(EXTRACT(EPOCH FROM "LapTime"::interval)) AS stddev_laptime_sec,
  COUNT(*) AS lap_count
FROM fastf1_data
WHERE "LapTime" IS NOT NULL
GROUP BY "Driver"
ORDER BY stddev_laptime_sec ASC;


--12 Identifying Anomalous or Slow Laps Indicating Reliability Issues
WITH driver_avg AS (
  SELECT 
    "Driver", 
    AVG(EXTRACT(EPOCH FROM "LapTime"::interval)) AS avg_laptime_sec,
    STDDEV(EXTRACT(EPOCH FROM "LapTime"::interval)) AS stddev_laptime_sec
  FROM fastf1_data
  WHERE "LapTime" IS NOT NULL
  GROUP BY "Driver"
)
SELECT 
  f."Driver",
  f."LapNumber",
  f."LapTime",
  EXTRACT(EPOCH FROM "LapTime"::interval) AS lap_sec,
  da.avg_laptime_sec,
  da.stddev_laptime_sec,
  (EXTRACT(EPOCH FROM "LapTime"::interval) - da.avg_laptime_sec) / da.stddev_laptime_sec AS z_score
FROM fastf1_data f
JOIN driver_avg da ON f."Driver" = da."Driver"
WHERE "LapTime" IS NOT NULL
ORDER BY 7 DESC



