-- data exploration
select * from zepto limit 10;

--count of rows
select count(*) from zepto;

--null values
select * from zepto 
where name is null 
or
category is null
or
mrp IS NULL
OR
discountPercent IS NULL
OR
discountedSellingPrice IS NULL
OR
weightInGms IS null
OR
availableQuantity is null
OR
outOfStock is null
OR
quantity is null;

-- above query is there is no null value for this datset!

--different /unique products
select distinct category 
from zepto
order by category;

--products stock info
select outOfStock, count(sku_id)
from zepto
group by outOfStock;

-- products name list with count
select name , count(sku_id) as "Stocks"
from zepto 
group by name
having count(sku_id)>1
order by name;
-- desc order
select name , count(sku_id) as "Stocks"
from zepto 
group by name
having count(sku_id)>1
order by count(sku_id) desc;


--prd rate =0
SELECT * FROM zepto
WHERE mrp = 0 OR discountedSellingPrice = 0;
--delete rate is zero
delete from zepto
where mrp=0;

--convert paise to Rs
UPDATE zepto
SET mrp = mrp / 100.0,
discountedSellingPrice = discountedSellingPrice / 100.0;

SELECT mrp, discountedSellingPrice FROM zepto limit 10;

-- top 10 best discount values
select mrp ,discountPercent
from zepto
order by discountPercent desc
limit 10;

--prd with high mrp but outofstock

select name,mrp from zepto 
where outOfstock=True
order by mrp desc;
--unique prd
select distinct name,mrp from zepto 
where outOfstock=True
order by mrp desc;

-- mrp>350
select distinct name,mrp from zepto 
where outOfstock=True and mrp>350
order by mrp desc;

--revenue for each category
select category, 
sum(discountedSellingPrice* availableQuantity) as Totalrevenue
from zepto
group by category
order by Totalrevenue;

-- condition mrp>500 and discount<10%
--v1
select name from zepto
where mrp>500 and discountpercent<10
order by name;
--v2
select name,mrp,discountpercent from zepto
where mrp>500 and discountpercent<10
order by name;
--v3
select distinct name,mrp,discountpercent from zepto
where mrp>500 and discountpercent<10
order by mrp desc;

--top 5 categories with high avg discount percentage

select category, round(avg(discountpercent),2) as Avg_discount
from zepto 
group by category
order by Avg_discount desc
limit 5;

--highest weightingms by product
select distinct name , weightingms 
from zepto 
order by weightingms desc;

-- price per grams with prd (best value)
select distinct name, weightingms , discountedSellingPrice,
round(discountedSellingprice/weightingms,2) as priceperGram
from zepto
where weightingms >=100
order by priceperGram desc;

--group prd with category  like low, medium, high

select distinct name,weightingms, 
case when weightingms <1000 then 'Low'
  when weightingms <1500 then 'Medium'
  else 'High'
  end as Weight_category
from zepto;

-- total inventory weight per category

select category ,
sum(weightingms * availablequantity) as TotalWeight
from zepto
group by category
order by Totalweight;

select category ,
sum(weightingms * availablequantity) as TotalWeight
from zepto
group by category
order by Totalweight desc;






