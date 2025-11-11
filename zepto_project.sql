drop table if exists zepto;

create table zepto(
sku_id SERIAL PRIMARY KEY,
category VARCHAR(150),
name VARCHAR(150) NOT NULL,
mrp NUMERIC(8,2),
discountPercent NUMERIC(3,2),
availableQuantity INTEGER,
discountSellingPrice NUMERIC(3,2),
weightInGms INTEGER,
outOfStock BOOLEAN,
quantity INTEGER
);

ALTER TABLE zepto
ALTER COLUMN discountPercent TYPE NUMERIC(8,2);

ALTER TABLE zepto
ALTER COLUMN discountSellingPrice TYPE NUMERIC(8,2);

ALTER TABLE zepto
ALTER COLUMN category TYPE VARCHAR(150);

ALTER TABLE zepto
ALTER COLUMN name TYPE VARCHAR(150);


--data exploration

--count of rows
SELECT COUNT(*) AS TOTAL FROM zepto;

-- sample data
SELECT * FROM zepto
LIMIT 10;

--checking null values
SELECT * FROM zepto
WHERE name is NULL
OR
category is NULL
OR
mrp is NULL
OR
discountPercent is NULL
OR
discountsellingprice is NULL
OR
weightingms is NULL
OR
availablequantity is NULL
OR
outofstock is NULL
OR
quantity is NULL;

--different product categories
SELECT DISTINCT category 
FROM zepto
ORDER BY category;

--product in stock vs out of stock
SELECT outofstock, COUNT(sku_id)
FROM zepto
GROUP by outofstock;

--product names present multiple times
SELECT name, COUNT(sku_id) AS num_of_skus
FROM zepto
GROUP BY name
HAVING COUNT(sku_id) > 1
ORDER BY COUNT(sku_id) DESC;

--DATA CLEANING

--products with price = 0
SELECT * FROM zepto
WHERE mrp = 0 OR discountsellingprice = 0;

--delete products with price = 0 and discountsellingprice = 0
DELETE FROM zepto
WHERE mrp = 0 OR discountsellingprice = 0;

--convert paise to rupees as we can see our price in data is in paise
UPDATE zepto
SET mrp = mrp/100.0, 
discountsellingprice = discountsellingprice/100.0;

--let's check
SELECT mrp, discountsellingprice FROM zepto;

--BUSSINESS QUESTIONS TO GET INSIGHTS FROM OUR DATA

--Q1.Find the top 10 best-value products based on the discount percentage.
SELECT DISTINCT name, mrp, discountpercent
FROM zepto
ORDER BY discountpercent DESC
LIMIT 10;

--Q2.What are the Products with High MRP but Out of Stock.
SELECT DISTINCT name, mrp
FROM zepto 
WHERE mrp > 300 AND outofstock = 'True'
ORDER BY mrp DESC;


--Q3.Calculate Estimated Revenue for each category.
SELECT category, ROUND(SUM(discountsellingprice * quantity),3) AS total_revenue
FROM zepto
GROUP BY category;

--Q4. Find all products where MRP is greater than ₹500 and discount is less than 10%.
SELECT DISTINCT name, mrp, discountpercent
FROM zepto
WHERE mrp > 500 AND discountpercent < 10
ORDER BY mrp DESC;


--Q5. Identify the top 5 categories offering the highest average discount percentage.
SELECT category, ROUND(AVG(discountpercent),2) AS avg_discpercent
FROM zepto
GROUP BY category
ORDER BY avg_discpercent DESC
LIMIT 5;

--Q6. Find the price per gram for products above 100g and sort by best value.
SELECT DISTINCT name, discountsellingprice, weightingms, ROUND(discountsellingprice/weightingms,2) AS price_per_gm
FROM zepto
WHERE weightingms > 100
ORDER BY price_per_gm DESC;

--Q7.Group the products into categories like Low, Medium, Bulk.
SELECT DISTINCT name, weightingms,
CASE 
	WHEN weightingms < 1000 THEN 'LOW'
	WHEN weightingms < 5000 THEN 'Medium'
	ELSE 'Bulk'
	END AS weightcategory
FROM zepto;


--Q8.What is the Total Inventory Weight Per Category
SELECT category, SUM(weightingms* availablequantity) AS total_inventory_weight
FROM zepto
GROUP BY category
ORDER BY total_inventory_weight;


SELECT SUM(MRP) FROM zepto;






































