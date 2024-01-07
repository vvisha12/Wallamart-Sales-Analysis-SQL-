SELECT * FROM wallmart.sales;
use wallmart;
select * from sales;
desc sales;
alter table sales modify `Rating` decimal (2,1);
UPDATE sales
SET Rating = ROUND(Rating, 1);
ALTER TABLE sales MODIFY `Rating` DECIMAL(3,1);
desc sales;
select * from sales;

alter table sales modify Time time; 
/*--Time_of_day--*/
select *	 ,
case when Time between "00:00:00" and "12:00:00" then "Morning"
when Time between "12:01:00" and "16:00:00" then  "Afternoon"
else "Evening"
end as time_to_day from sales order by Time;

alter table sales add column time_of_day varchar (40);
/*inserted a new column of time_of_day*/
update sales
set time_of_day=(case when Time between "00:00:00" and "12:00:00" then "Morning"
when Time between "12:01:00" and "16:00:00" then  "Afternoon"
else "Evening"
end);

select * from sales;

/*Day_name*/
select Date,
dayname(Date) as day_name from sales;
/*Inserting*/
alter table sales add column day_name varchar(40);
update  sales set day_name=dayname(Date);
select * from sales;
/* Adding and inserting monthname*/
select date,monthname(Date)  from sales;
alter table sales add column month_name varchar(40);
update sales set month_name=monthname(Date);
select * from sales;
/*How many unique cities does  the data have*/
select distinct(City) from sales;
/*In which city is each branch*/
select distinct(City),Branch from sales;
/* How many unique products lines does the data have*/
select count(distinct(`Product line`)) as product_line  from sales;
/*What is the most common payment method*/
select  payment_method,count(payment_method) as total from sales group by payment_method order by total desc;
/* What is the most selling product line*/
select `Product line` , count(`Product line`) as total from sales group by `Product line` order by total desc;
/* What is the total Revenue by month*/
select month_name as month,sum(Total) as Revenue from sales  group by month_name order by Revenue desc;
/* What month had the largest COGS*/
select month_name as month,sum(cogs) as cogs from sales group by month_name order by cogs desc;
/* What product line had the largest revenue*/
select `Product Line`,sum(Total) as Revenue from sales group by `Product line` order by Revenue desc;
/* WHat is the city with largest revenue*/
select City, sum(Total) as revenue from sales group by City order by revenue desc;
/*What product line had the largest VAT*/
select `Product line`,avg(`Tax 5%`) as tax from sales group by `Product line` order by tax desc;
/* Fetch each product line and add a column to those product line showing "Good","Bad". Good if its greater than
average sales*/
select `Product line`,Total ,
case when Total>(select avg(Total) from sales) then "Good"
else "Bad"
end as Sale_Status from sales order by Total desc;
alter table sales add column sale_status varchar(40);

select * from sales;

/* WHich branch sold more product than average product sold*/
select Branch,sum(Quantity) as TT_QTY from sales group by Branch having sum(Quantity)>(select avg(Quantity) from sales) order 
by TT_QTY desc;

/* What is the most common product line by gender*/
select Gender, `Product line`, count(Gender) as count from sales group by `Product line`,Gender order by count desc,`Product line`;

/*What is the average rating of each product line*/
select `Product line`,round(avg(Rating),2) as Rating from sales group by `Product line` order by Rating desc;

/* Number of sales made in each time of the day per weekday*/
select * from sales;
select day_name, time_of_day,count(*) as total_sales from sales where day_name="Tuesday" group by time_of_day order by total_sales desc;
/*Which of the customer types bring the most revenue*/
select `Customer type`,sum(Total) as Revenue from sales group by `Customer type` order by Revenue desc;
/*Which city has the largest tax percent/VAT (value added tax)*/
select City,round(avg(`Tax 5%`),2) as Tax from sales group by City order by Tax desc;
/* Which customer types pays  the most in VAT*/
select `Customer type`, round(avg(`Tax 5%`),2) as Tax from sales group by `Customer type` order by Tax desc;
/* How many unique customer types does the data have*/
select distinct(`Customer type`) from sales;
/* How many unique payment methods does he data have*/
select distinct(payment_method) as payment_method from sales;
/*What is the most common customer type*/
select `Customer type` , count(*) as total from sales group by `Customer type` order by total desc;
/* WHat is the gender of most of the customer*/
select Gender ,count(*) as total from sales group by Gender order by total;
/*what is the gender distribution per branch*/
select Gender,Branch,count(*) as total from sales group by Gender,Branch order by Branch;
/*Which time of the day customers give most ratings*/
select time_of_day,avg(Rating) Rating from sales group by time_of_day order by Rating desc;
/*Which time of the day do custromers give most ratings per branch*/
 select Branch,time_of_day , avg(Rating) as Ratings from sales group by Branch,time_of_day;
 /* Which day for the week has the best avg ratings*/
 select day_name,avg(Rating) as rating from sales group  by day_name order by rating desc;
/*Which day for the week has the best avg ratings per branch*/
select Branch,day_name,avg(Rating) as Rating from sales group by Branch,day_name order by Rating;
use wallmart;
select * from sales;
select sum(`Tax 5%`)+sum(cogs) as total_gross_sales from sales;
select (sum(`Tax 5%`)+sum(cogs))-sum(cogs) as gross_profit from sales;
select sum(Total) as gross_sales from sales;
select sum(cogs) as cost from sales;
select sum(total)-sum(cogs) from sales;
select (sum(total)-sum(cogs))/sum(total) as profit_margin from sales;