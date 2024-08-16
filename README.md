# Retail Sales Analysis SQL Project
## Project Overview

**Project Title**: Retail Sales Analysis<br/>
**Level**: Beginner<br/>
**Database**: `Retail_Sales_Analysis`<br/> 

This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean and analyse retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries. This project is ideal for those who are starting their journey in data analysis and want to build a solid foundation in SQL.

## Objectives

1. **Set up a retail sales database**: Create and populate a retail sales database with the provided sales data.
2. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Expolatory Data Analysis**: Perform basic expolatory data analysis to understand the dataset.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.

## Project Structure

### 1. Database Setup

- **Database Creation**: The project starts by creating a database named `Retail_Sales_Analysis`.
- **Table Creation**: A table named 'retail_sale' is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS) and total sales amount.

```sql
CREATE DATABASE Retail_Sales_Analysis;

CREATE TABLE retail_sale(
	transactions_id int,
	sale_date date,
	sale_time time,
	customer_id int,
	gender varchar(10),
	age int,
	category varchar(30),
	quantiy int,
	price_per_unit float,
	cogs float,
	total_sale float
);
```

### 2. Data Exploration & Cleaning

- **Record Count**: Determine the total number of records in the dataset.
- **Customer Count**: Find out how many unique customers are in the dataset.
- **Category Count**: Identify all unique product categories in the dataset.
- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.

```sql
  
SELECT * FROM retail_sale LIMIT 10;

SELECT COUNT(*) FROM retail_sale;

SELECT COUNT(DISTINCT customer_id) FROM retail_sale;

SELECT * FROM retail_sale
WHERE 
sale_date IS NULL
OR sale_time IS NULL
OR customer_id IS NULL
OR age IS NULL
OR transactions_id IS NULL
OR gender IS NULL
OR category IS NULL
OR quantiy IS NULL
OR price_per_unit IS NULL
OR cogs IS NULL
OR total_sale IS NULL;

DELETE FROM retail_sale
WHERE 
sale_date IS NULL
OR sale_time IS NULL
OR customer_id IS NULL
OR age IS NULL
OR transactions_id IS NULL
OR gender IS NULL
OR category IS NULL
OR quantiy IS NULL
OR price_per_unit IS NULL
OR cogs IS NULL
OR total_sale IS NULL;

```

### Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:

1. **Write a SQL query to retrieve all columns for sales made on '2022-11-05'**
```sql
select * from retail_sale where sale_date = '2022-11-05';
```

2. **Write a SQL query to retreive all transactions where the category is 'Clothing' and the quamtity sold is more than 4 in the month of Nov 2022.**
```sql
select * from retail_sale
where category = 'Clothing' and quantiy > 3 and (sale_date between '2022-11-01' and '2022-11-30')
order by sale_date asc;
```

3. **Write a SQL query to calculate the total sales for each category.**
```sql
select category, sum(total_sale) as total_sales
from retail_sale
group by category;
```

4. **Write a SQL query to find the average age of customers who purchased the items from the beauty category.**
```sql
select round(avg(age)::numeric,2) as avg_age
from retail_sale
where category = 'Beauty';
```

5. **Write a SQL query to find all the transactions where the total_sale is greater than 1000.**
```sql
select * from retail_sale
where total_sale> 1000;
```

6. **Write a SQL query to find the cost of transactions made by each gender in each category.**
```sql
select gender, category, count(transactions_id) as total_transactions
from retail_sale
group by gender, category
order by gender, category;
```

7. **Write a SQL query to calculate the average sale for each month. Find out best selling month in each year.**
```sql
select Year,Month, avg_sale
from(	
select extract(year from sale_date) as Year,to_char(sale_date,'Mon') as Month, round(avg(total_sale)::numeric,2) as avg_sale, 
rank() over(partition by extract(year from sale_date) order by avg(total_sale) desc )	as rk
from retail_sale
group by 1,2)
where rk = 1;
```

8. **Write a SQL query to find the top 5 customers based on the highest total sales.**
```sql
select customer_id, sum(total_sale) as total_sales
from retail_sale
group by customer_id	
order by total_sales desc
limit 5;
```

9. **Write a SQL query to find the number of unique customers who purchased items from each category.**
```sql
select category, count(distinct customer_id) as no_of_customers
from retail_sale
group by category;
```

10. **Write a SQL query to create each shift and number of orders (Example Morning<=12, Afternoon Between 12 & 17, Evening>17).**
```sql
select shift, count(transactions_id) as total_orders
from
	(	
select *, case
when extract(hour from sale_time) <12 then 'Morning' 
when extract(hour from sale_time) between 12 and 17 then 'Afternoon'
else 'Evening'
end as Shift
from retail_sale
	)
group by shift
order by total_orders desc;
```

## Findings

- **Customer Demographics**: The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty.
- **High-Value Transactions**: Several transactions had a total sale amount greater than 1000, indicationg premium purchases.
- **Sales Trends**: Monthly analysis shows variations in sales, helping identify peak seasons.
- **Customer Insights**: Reports on top customers and unique customer counts per category.

## Conclusion

This project serves as a comprehensive introduction to SQL for data analysts, covering database setup, data cleaning, exploratory data analysis, and business-driven SQL queries. The findings from this project can help drive business decisions by understanding sales patterns, customer behaviour and product performance.

