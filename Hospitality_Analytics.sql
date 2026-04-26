create database Hospitality_Analtytics;
use Hospitality_Analtytics;
select * from hospitality_cleaned_data;
RENAME TABLE hospitality_cleaned_data TO hospitality;
##KPIs

##1.)Total Revenue
SELECT SUM(revenue_generated) AS Total_Revenue FROM hospitality;

##2.)Occupancy Rate
SELECT 
ROUND(
(SUM(CASE WHEN booking_status = 'Checked Out' THEN 1 ELSE 0 END) 
/ COUNT(booking_id)) * 100
,2) AS Occupancy_Rate_Percent
FROM hospitality;


##3.)Cancellation Rate
SELECT 
ROUND((SUM(CASE WHEN booking_status='Cancelled' THEN 1 ELSE 0 END)
/COUNT(booking_id))*100,2) AS Cancellation_Rate_Percent
FROM hospitality;

##4.)Total Bookings
SELECT 
COUNT(booking_id) AS Total_Bookings
FROM hospitality;

##5.)Utilized Capacity


SELECT 
SUM(IFNULL(no_guests,0)) AS Utilized_Capacity
FROM hospitality
WHERE booking_status = 'Checked Out';

##6.)Trend Analysis (Revenue Trend by Month);
SELECT 
MONTH(booking_date) AS Month,
SUM(revenue_generated) AS Monthly_Revenue
FROM hospitality
GROUP BY Month
ORDER BY Month;

##7.)Weekday vs Weekend Revenue & Bookings---;

SELECT 
day_type,
COUNT(booking_id) AS Total_Bookings,
SUM(revenue_generated) AS Total_Revenue
FROM hospitality
GROUP BY day_type;

##8.)Revenue by State / City and Hotel---;
SELECT 
City,
hotel_name,
SUM(revenue_generated) AS Revenue
FROM hospitality
GROUP BY City, hotel_name
ORDER BY Revenue DESC;

##9.)Class-wise Revenue
SELECT 
room_class,
SUM(revenue_generated) AS Revenue
FROM hospitality
GROUP BY room_class
ORDER BY Revenue DESC;

##10.)Booking Status Distribution

SELECT 
booking_status,
COUNT(*) AS Total_Bookings,
ROUND((COUNT(*)/ (SELECT COUNT(*) FROM hospitality))*100,2) AS Percentage
FROM hospitality
GROUP BY booking_status;

##11.)Weekly Trends for Key Metrics

SELECT 
week_number,
COUNT(booking_id) AS Total_Bookings,
SUM(revenue_generated) AS Revenue,
ROUND((SUM(CASE WHEN booking_status='Checked-out' THEN 1 ELSE 0 END)
/COUNT(booking_id))*100,2) AS Occupancy_Rate
FROM hospitality
GROUP BY week_number
ORDER BY week_number;

