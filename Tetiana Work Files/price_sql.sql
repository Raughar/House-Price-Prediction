create database house_price_regression;
alter TABLE house_price_data 
    id INT AUTO_INCREMENT PRIMARY KEY,
    date DATE,
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
drop table house_price_data;
RENAME TABLE regression_data TO house_price_data;
select * from house_price_data;
SHOW COLUMNS FROM house_price_data;
ALTER TABLE house_price_data
CHANGE COLUMN `7129300520` id BIGINT,
CHANGE COLUMN `10/13/14` date TEXT,
CHANGE COLUMN `3` bedrooms INT,
CHANGE COLUMN `1` bathrooms DOUBLE,
CHANGE COLUMN `1180` sqft_living INT,
CHANGE COLUMN `5650` sqft_lot INT,
CHANGE COLUMN `1_[0]` floors INT,
CHANGE COLUMN `0` waterfront INT,
CHANGE COLUMN `0_[0]` view INT,
CHANGE COLUMN `3_[0]` `condition` INT,
CHANGE COLUMN `7` grade INT,
CHANGE COLUMN `1180_[0]` sqft_above INT,
CHANGE COLUMN `0_[1]` sqft_basement INT,
CHANGE COLUMN `1955` yr_built INT,
CHANGE COLUMN `0_[2]` yr_renovated INT,
CHANGE COLUMN `98178` zipcode INT,
CHANGE COLUMN `47.5112` lat DOUBLE,
CHANGE COLUMN `-122.257` `long` DOUBLE,
CHANGE COLUMN `1340` sqft_living15 INT,
CHANGE COLUMN `5650_[0]` sqft_lot15 INT,
CHANGE COLUMN `221900` price INT;
ALTER TABLE house_price_data
DROP COLUMN date;
select * from house_price_data
limit 10;
select count(*) from house_price_data;
select distinct bedrooms from house_price_data;
select distinct bathrooms from house_price_data;
select distinct floors from house_price_data;
select distinct `condition` from house_price_data;
select distinct grade from house_price_data;
select id from house_price_data
order by price desc
limit 10;
select avg(price) from house_price_data;
select bedrooms, avg(price) as avg_price
from house_price_data
group by bedrooms;
select bedrooms, avg(sqft_living) as avg_sqft_living
from house_price_data
group by bedrooms;
select waterfront, avg(price) as avg_price
from house_price_data
group by waterfront;
select `condition`, avg(grade) as avg_grade
from house_price_data
group by `condition`
order by avg_grade desc;
select * from house_price_data
where bedrooms in (3, 4)
and bathrooms >3
and floors = 1
and waterfront = 0
and `condition`>=3
and grade >=5
and price < 300000
;
select * from house_price_data
where price > (select 2 * avg(price) from house_price_data);
create view properties as
select * from house_price_data
where price > (select 2 * avg(price) from house_price_data);
with avg_4 as (select avg(price) as avg4 from house_price_data where bedrooms=4),
avg_3 as (select avg(price) as avg3 from house_price_data where bedrooms=3)
select avg4 - avg3
from avg_4, avg_3;
select distinct zipcode from house_price_data;
select *  from house_price_data
where yr_renovated !=0;
select * from house_price_data
order by price desc
limit 1 OFFSET 10 ;



