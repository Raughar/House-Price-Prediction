-- Creating the database
CREATE DATABASE house_price_regression;
-- Selecting the database
use house_price_regression;
-- Creating the table house_data
CREATE TABLE house_data (
    id BIGINT,
    date DATETIME,
    bedrooms INT,
    bathrooms FLOAT,
    sqft_living INT,
    sqft_lot INT,
    floors FLOAT,
    waterfront INT,
    view INT,
    `condition` INT,
    grade INT,
    sqft_above INT,
    sqft_basement INT,
    yr_built INT,
    yr_renovated INT,
    zipcode INT,
    lat FLOAT,
    `long` FLOAT,
    sqft_living15 INT,
    sqft_lot15 INT,
    price INT
);

-- Loading the data into the table
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.2/Uploads/regression_data.csv'
INTO TABLE house_data
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
(id, @date_variable, bedrooms, bathrooms, sqft_living, sqft_lot, floors, waterfront, view, `condition`, grade, sqft_above, sqft_basement, yr_built, yr_renovated, zipcode, lat, `long`, sqft_living15, sqft_lot15, price)
SET date = STR_TO_DATE(@date_variable, '%m/%d/%y');

-- Checking the data
select * from house_data;

-- Dropping the date column
ALTER TABLE house_data
DROP COLUMN date;

-- Checking the data after dropping the column with only ten results
SELECT *
FROM house_data
LIMIT 10;

-- Checking the number of rows in the table
SELECT COUNT(*) AS Number_Of_Rows
FROM house_data;

-- Checking the number of distinct values in bedrooms, bathrooms, floors, condition, and grade
SELECT DISTINCT bedrooms
FROM house_data;

SELECT DISTINCT bathrooms
FROM house_data;

SELECT DISTINCT floors
FROM house_data;

SELECT DISTINCT `condition`
FROM house_data;

SELECT DISTINCT grade
FROM house_data;

-- Checking the ten most expensive houses
SELECT *
FROM house_data
ORDER BY price DESC
LIMIT 10;

-- Checking the average price of the houses
SELECT AVG(price) AS Average_Price
FROM house_data;

-- Checking the average price of the houses based on the bedrooms
SELECT bedrooms, AVG(price) AS average_price
FROM house_data
GROUP BY bedrooms;

-- Checking the average sqft_living of the houses based on the bedrooms
SELECT bedrooms, AVG(sqft_living) AS average_sqft_living
FROM house_data
GROUP BY bedrooms;

-- Checking the average price of the houses based on the waterfront
SELECT waterfront, AVG(price) AS average_price
FROM house_data
GROUP BY waterfront;

-- Checking the correlation between condition and grade
SELECT `condition`, AVG(grade) AS average_grade
FROM house_data
GROUP BY `condition`;

-- Getting the houses that meet the following criteria of a client:
SELECT *
FROM house_data
WHERE bedrooms IN (3, 4)
  AND bathrooms >= 3
  AND floors = 1
  AND waterfront = 0
  AND `condition` >= 3
  AND grade >= 5
  AND price < 300000;

-- Checking the houses that cost two times more than the average price
SELECT *
FROM house_data
WHERE price > (SELECT 2 * AVG(price) FROM house_data);

-- Creating a view for the expensive properties
CREATE VIEW expensive_properties_view AS
SELECT *
FROM house_data
WHERE price > (SELECT 2 * AVG(price) FROM house_data);

SELECT * FROM expensive_properties_view;

-- Checking the avergae price of the houses with 3 and 4 bedrooms and the difference between the two
SELECT
    AVG(CASE WHEN bedrooms = 3 THEN price END) AS avg_price_3_bedrooms,
    AVG(CASE WHEN bedrooms = 4 THEN price END) AS avg_price_4_bedrooms,
    ABS(AVG(CASE WHEN bedrooms = 3 THEN price END) - AVG(CASE WHEN bedrooms = 4 THEN price END)) AS price_difference
FROM
    house_data
WHERE
    bedrooms IN (3, 4);

-- Getting the different zipcodes
SELECT DISTINCT zipcode
FROM house_data;

-- Checking the houses that have been renovated
SELECT *
FROM house_data
WHERE yr_renovated > 0;

-- Checking the eleventh most expensive house
SELECT *
FROM house_data
ORDER BY price DESC
LIMIT 1 OFFSET 10;




