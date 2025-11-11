# 🛒 Zepto Product Data Analysis (SQL Project)

## 📄 Project Overview
This project focuses on cleaning, transforming, and analyzing product data from **Zepto**, a quick-commerce platform.  
The analysis was performed using **PostgreSQL** to explore product information, identify inconsistencies, and derive valuable business insights.

The main goal was to perform **data exploration, cleaning, and insight extraction** using SQL queries.

---

## 🧱 Database Design

**Table Name:** `zepto`

| Column Name | Data Type | Description |
|--------------|------------|--------------|
| sku_id | SERIAL PRIMARY KEY | Unique product identifier |
| category | VARCHAR(150) | Product category |
| name | VARCHAR(150) | Product name |
| mrp | NUMERIC(8,2) | Maximum Retail Price |
| discountPercent | NUMERIC(8,2) | Discount percentage applied |
| availableQuantity | INTEGER | Quantity available in stock |
| discountSellingPrice | NUMERIC(8,2) | Discounted price |
| weightInGms | INTEGER | Product weight in grams |
| outOfStock | BOOLEAN | Product availability |
| quantity | INTEGER | Quantity sold |

---

## 🧹 Data Cleaning Steps

1. **Removed rows** with `mrp = 0` or `discountSellingPrice = 0`  
2. **Converted prices** from paise to rupees using:
   ```sql
   UPDATE zepto
   SET mrp = mrp/100.0, 
       discountsellingprice = discountsellingprice/100.0; ```
## Checked for nulls and duplicates across key columns.

## Validated product names that appeared multiple times.

## Confirmed consistent data types for all numeric and text columns.
