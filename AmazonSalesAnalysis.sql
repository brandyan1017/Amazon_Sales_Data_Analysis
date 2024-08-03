/*
CREATED BY: Brandy Nolan
CREATED ON: July 14,2024
DESCRIPTION: This dataset contains  100 rows of sales data for Amazon.
*/

-- Gross Profit Margin by `Item Type`. 
SELECT 
	`Item Type`,
    ROUND(SUM((`Total Revenue`-`Total Cost`)/`Total Revenue`*100),2) 'Gross Profit Margin'
FROM amazonsalesdata
GROUP BY `Item Type`
ORDER BY 2 DESC;

-- How many countries are represented?
SELECT
	COUNT(DISTINCT `Country`) 'Country Count'
FROM amazonsalesdata

-- Gross profit by `Sales Channel`
SELECT
	`Sales Channel`,
    ROUND(SUM(`Units Sold` * `Unit Cost`),2) 'COGS',
    ROUND(SUM((`Total Revenue` -  (`Units Sold` * `Unit Cost`))),2) 'Gross Profit'
FROM amazonsalesdata
GROUP BY `Sales Channel`;


-- how do most regions order and what do they order
SELECT 
	`Region`,
	ROUND(SUM(`Total Revenue`),2) `Total Revenue`,
    ROUND(SUM(`Total Profit`),2) `Total Profit`
FROM amazonsalesdata
GROUP BY 
	`Region`
ORDER BY 3 desc;

-- date to see most profitable months or quarters
WITH date_cte AS (SELECT
	*,
	MONTH(STR_TO_DATE(`Order Date`, '%m/%d/%Y')) AS `Month`,
    YEAR(STR_TO_DATE(`Order Date`, '%m/%d/%Y')) AS `Year`,
    QUARTER(STR_TO_DATE(`Order Date`, '%m/%d/%Y')) AS `Quarter`
FROM amazonsalesdata)
SELECT
   `Quarter`,
   `Year`,
	ROUND(SUM((`Total Revenue` -  (`Units Sold` * `Unit Cost`))),2) 'Gross Profit'
FROM date_cte
GROUP BY 
    `Quarter`,
   `Year`
ORDER BY 3 DESC;

-- What `Region` has the highest mark up?
SELECT 
	`Region`,
	 CONCAT(ROUND(SUM((`Unit Price` - `Unit Cost`) / `Unit Cost`) * 100, 0),"%") AS `Markup%`
FROM amazonsalesdata
GROUP BY `Region`
ORDER BY SUM((`Unit Price` - `Unit Cost`) / `Unit Cost`) * 100 DESC

-- `Item Type` Revenue by Year
WITH date_cte AS (SELECT
	*,
	MONTH(STR_TO_DATE(`Order Date`, '%m/%d/%Y')) AS `Month`,
    YEAR(STR_TO_DATE(`Order Date`, '%m/%d/%Y')) AS `Year`,
    QUARTER(STR_TO_DATE(`Order Date`, '%m/%d/%Y')) AS `Quarter`
FROM amazonsalesdata)
SELECT
	`Item Type`,
    `Year`,
    `Total Profit`
FROM date_cte
GROUP BY 
	`Item Type`,
    `Year`,
    `Total Profit`
ORDER BY 2, 1,3 DESC;

-- Look at `Total Revenue` for `Region` by `Year` 
WITH date_cte AS (SELECT
	*,
	MONTH(STR_TO_DATE(`Order Date`, '%m/%d/%Y')) AS `Month`,
    YEAR(STR_TO_DATE(`Order Date`, '%m/%d/%Y')) AS `Year`,
    QUARTER(STR_TO_DATE(`Order Date`, '%m/%d/%Y')) AS `Quarter`
FROM amazonsalesdata)
SELECT
	`Region`,
    `Year`,
    ROUND(SUM((`Total Revenue` -  (`Units Sold` * `Unit Cost`))),2) 'Gross Profit'
FROM date_cte
GROUP BY
	`Region`,
    `Year`
ORDER BY 2,1,3 DESC
