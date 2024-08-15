--Create Table
DROP TABLE IF EXISTS retail_sale;
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

--Data Exploration

--How many sales do we have?

select count(transactions_id) as total_sales
from retail_sale;

--How many unique customers do we have?

select  count(distinct customer_id) as total_customers
from retail_sale;

--How many categories do we have?

select count(distinct category) as total_categories
from retail_sale;

--Types of categories

select distinct category
from retail_sale;

-- Questions:
-- Q1. Write a SQL query to retrieve all columns for sales made on '2022-11-05'

SELECT * FROM retail_sale
WHERE sale_date = '2022-11-05';

--Q2. Write a SQL query to retreive all transactions where the category is 'Clothing' and the quamtity sold is 
--more than 4 in the month of Nov 2022.

select * from retail_sale
where category = 'Clothing'and quantiy > 3 and (sale_date between '2022-11-01' and '2022-11-30')
order by sale_date asc	;

--Q3. Write a SQL query to calculate the total sales for each category.

select category, sum(total_sale) as total_sales
from retail_sale
group by 1;

--Q4. Write a SQL query to find the average age of customers who purchased the items from the beauty category.A

select round(avg(age)::numeric,2) as avg_age
from retail_sale
where category = 'Beauty';

--Q5. Write a SQL query to find all the transactions where the total_sale is greater than 1000

select * from retail_sale
where total_sale> 1000;

--Q6. Write a SQL query to find the cost of transactions made by each gender in each category

select gender, category, count(transactions_id) as total_transactions
from retail_sale
group by 1,2
order by 1, 2

--Q7. Write a SQL query to calculate the average sale for each month. Find out best selling month in each year.
	
select Year,Month, avg_sale
from(	
select extract(year from sale_date) as Year,to_char(sale_date,'Mon') as Month, round(avg(total_sale)::numeric,2) as avg_sale, 
rank() over(partition by extract(year from sale_date) order by avg(total_sale) desc )	as rk
from retail_sale
group by 1,2)
where rk = 1

--Q8. Write a SQL query to find the top 5 customers based on the highest total sales.

select customer_id, sum(total_sale) as total_sales
from retail_sale
group by 1	
order by total_sales desc
limit 5;

--Q9. Write a SQL query to find the number of unique customers who purchased items from each category.

select category, count(distinct customer_id) as no_of_customers
from retail_sale
group by 1;

--Q10. Write a SQL query to create each shift and number of orders (Example Morning<=12, Afternoon Between 12 & 17, Evening>17)

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
group by 1
order by 2 desc;

--End of project
