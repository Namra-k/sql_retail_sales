------ Retail sales project


----create Table 
Create Table retail_sales(
		transactions_id int primary key,
		sale_date date,
		sale_time time,
		customer_id int,	
		gender varchar(15),
		age	int,
		category varchar(15),
		quantiy	int,
		price_per_unit float,
		cogs float,
		total_sale float
);

select * from retail_sales

-----verify if data import is correct 
select count(*)
from retail_sales

----data cleaning------
----- find if we have any null value 
select * from retail_sales
where transactions_id is null

select * from retail_sales
where sale_date is null

-------or for all

select * from retail_sales
where transactions_id is null
or
sale_date is null
or 
sale_time is null
or 
gender is null
or
category is null
or
quantiy is null
or 
cogs is null
or 
total_sale is null

--- Delete null value data

delete from retail_sales 
where 
transactions_id is null
or
sale_date is null
or 
sale_time is null
or 
gender is null
or
category is null
or
quantiy is null
or 
cogs is null
or 
total_sale is null

----data exploration-----

--- how many sales we have?

select count(*) as total_sales
from retail_sales

----how many unique customers we have 

select count(Distinct customer_id) as total_sales
from retail_sales

-----total no of category

select Distinct category
from retail_sales

-----business key problems----

---write a query to retrieve all columns for sales made on 2022-11-05

select * from retail_sales
where 
sale_date = '2022-11-05'

----write a query to retrieve all transactions where the category is clothing and the quantity sold is more than 4 in month of nov-2022

select *
from retail_sales
where 
category = 'clothing' 
and 
to_char(sale_date, 'yyyy-mm') ='2022-11'
and
quantiy>= 4


----write a query to calculate total_sales for each category

select category, sum(total_sale) as net_sale
from retail_sales
group by 1

----write a query to find average age of customer who purchased items from the beauty category

select Round(AVG(age),2) as avg_age
from retail_sales
where category= 'Beauty'

----write a query to find all transactions where total_sale is greater than 1000

select * from retail_sales
where 
total_sale > 1000

----write a query to find total no of transactions(transaction_id) made by each gender in each category 

select 
category,
gender,
count(*) as total_trans
from retail_sales

group by 
category,
gender
order by 1

-----Write a query to calculate avg sales for each month. find out best selling month of each year

select 
 year,
  month,
  avg_sale
from
(
select 
	 Extract(year from sale_date) as year,
	 Extract(month from sale_date) as month,
	 avg(total_sale) as avg_sale,
	 Rank() over(partition by extract(year from sale_date) order by avg(total_sale) Desc) as rank
	from retail_sales
	Group by 1,2
) as t1
where rank =1 

-----Write a query to find top 5 customers based on highest total sales

select 
	customer_id, 
	sum(total_sale) as sale  
from retail_sales
group by 1
order by 2 desc
limit 5

-----Write a query to find no of unique customer who purchased items from each category

select 
    category,
	count(distinct customer_id) as count_unique_cs
from retail_sales
group by category

-----Write a query to create each shift and no of orders(ex morning <=12, afternoon between 12 & 17, evening > 17)

with hourly_sales
As
(
select *,
 case
     when extract(hour from sale_time) < 12 then 'Morning'
	 when extract(hour from sale_time) between 12 and 17 then 'Afternoon'
	 else 'Evening'
	End as shift 
From retail_sales
)
select
    shift,
	count(*) as total_orders
From hourly_sales
Group by shift 

------End of project------