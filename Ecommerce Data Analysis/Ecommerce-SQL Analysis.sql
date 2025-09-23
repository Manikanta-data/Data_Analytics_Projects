SELECT *
FROM Ecommerce_Delivery_Analytics_New;

-- Count orders for each platform and order by descending count
SELECT
	"Platform",
	COUNT(*) AS Order_Count
FROM Ecommerce_Delivery_Analytics_New
GROUP BY "Platform"
ORDER BY Order_Count DESC;

-- Calculate the average delivery time and average service rating for each platform
SELECT 
	"Platform",
    AVG("Delivery Time (Minutes)") AS Avg_Delivery_Time,
    AVG("Service Rating") AS Avg_Service_Rating
FROM Ecommerce_Delivery_Analytics_New
GROUP BY "Platform"
ORDER BY Avg_Delivery_Time;

--Percentage of deliveries delayed by product category
SELECT 
	"Product Category",
     100.0 * SUM(CASE WHEN "Delivery Delay" = 'Yes' THEN 1 ELSE 0 END) / COUNT(*) AS Percent_Delayed
FROM Ecommerce_Delivery_Analytics_New
GROUP BY "Product Category"
ORDER BY 1 DESC;



--Count of refund requests by platform

SELECT "Platform",
       COUNT(*) FILTER (WHERE "Refund Requested" = 'Yes') AS Refund_Requests,
       COUNT(*) AS Total_Orders
FROM Ecommerce_Delivery_Analytics_New
GROUP BY "Platform";


--Customers with their minimum delivery time

SELECT 
	"Customer ID", 
	MIN("Delivery Time (Minutes)") AS Min_Delivery_Time
FROM Ecommerce_Delivery_Analytics_New
GROUP BY "Customer ID"
ORDER BY Min_Delivery_Time ASC;




--Orders with service rating below 3

SELECT *
FROM Ecommerce_Delivery_Analytics_New
WHERE "Service Rating" < 3;



--Total order value by platform

SELECT 
	"Platform", 
     SUM("Order Value (INR)") AS Total_Order_Value
FROM Ecommerce_Delivery_Analytics_New
GROUP BY "Platform"
ORDER BY Total_Order_Value DESC;


--Average delivery time for delayed vs non-delayed deliveries
SELECT 
	"Delivery Delay",
     AVG("Delivery Time (Minutes)") AS Avg_Delivery_Time
FROM Ecommerce_Delivery_Analytics_New
GROUP BY "Delivery Delay";


--Distribution of orders by service rating

SELECT 
	"Service Rating", 
     COUNT(*) AS Count_Orders
FROM Ecommerce_Delivery_Analytics_New
GROUP BY "Service Rating"
ORDER BY "Service Rating";


--Recent 10 orders with highest order value

SELECT *
FROM Ecommerce_Delivery_Analytics_New
ORDER BY "Order Value (INR)" DESC
LIMIT 10;