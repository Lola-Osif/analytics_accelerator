-- Notes from SQL udacity course--
/* LIMIT returns first entries up to the no of rows specified */
SELECT occurred_at, account_id, channel
FROM web_events
LIMIT 15

  
/* ORDER BY arranges a  list in ascending order based on column selected, add DESCat the end for descending order
  ORDER BY must precede LIMIT for code to run
  WHERE precedes ORDER BY*/
SELECT id, occurred_at, total_amt_usd
FROM orders
ORDER BY total_amt_usd DESC
LIMIT 5;

SELECT id, occurred_at, total_amt_usd
FROM orders
ORDER BY total_amt_usd 
LIMIT 20;

/* ORDER BY can be used for multiple colums but the first column takes priority */
SELECT id,account_id,total_amt_usd
FROM orders
ORDER BY account_id, total_amt_usd DESC;

SELECT id,account_id,total_amt_usd
FROM orders
ORDER BY total_amt_usd DESC,account_id;


/* WHERE states a conditon to filter data,
 note that WHERE returns rows that fufil that condition based on initial ordering in this case by id, not in ascending or desecending order */
SELECT *
FROM orders
WHERE gloss_amt_usd >=1000
LIMIT 5;

/* WHERE can be used for non-numeric data, single quotes are required
if theres an apostrophe within the text data, double quotes are used */
SELECT name, website, primary_poc
FROM accounts
WHERE name != 'Exxon Mobil'



/* Derived colums are computed based on one or more columns using arithmethic operators
They are temporary for the duration of the query and not added to the table
Notice that the new table name does not require quotes, its text data within the table that require this  */
SELECT standard_amt_usd/standard_qty AS unit_price, id,account_id
FROM orders
LIMIT 10;

SELECT id, account_id, (poster_amt_usd/total_amt_usd)*100 AS Revenue_share_poster
FROM orders
LIMIT 10

/* LIKE is used with WHERE when the only a part of the condition is known*/
SELECT *
FROM accounts
WHERE name LIKE 'C%'

/* IN is also used with WHERE to return rows related to for one or more data from a coulmn, its similar to OR
  IN requires parenthesis*/
SELECT name, primary_poc, sales_rep_id
FROM accounts
WHERE name IN ('Walmart', 'Target', 'Nordstrom');

/* NOT LIKE OR NOT IN is used for reverse cases of LIKE and IN
AND is used to combine multiple conditions, table name needs to be stated after the AND command*/
SELECT name
FROM accounts
WHERE name NOT LIKE 'C%' AND name NOT LIKE'%s'

/* AND & BETWEEN can be used together to simply AND statements for a single column, works best with numerical data
  Both numbers stated are included */
SELECT occurred_at, gloss_qty
FROM orders
WHERE gloss_qty BETWEEN 24 AND 29

/* Both codes below return the same values using IN or AND */
SELECT *
FROM web_events 
WHERE channel IN ('organic', 'adwords')
ORDER BY occurred_at DESC;

SELECT *
FROM web_events 
WHERE channel ='organic' OR channel = 'adwords'
ORDER BY occurred_at DESC

/* Note that with dates the time 00:00:00 is assumed, so to capture al 2016 dates, endpoint should be 2017-01-01 */
SELECT *
FROM web_events 
WHERE channel IN ('organic', 'adwords') AND occurred_at BETWEEN '2016-01-01' AND '2017-01-01'
ORDER BY occurred_at DESC

/* Samples combining multiple SQL commands
  parenthesis are important to ensure the logic is executed correctly*/
SELECT *
FROM orders
WHERE standard_qty =0 
AND (gloss_qty> 1000 OR poster_qty>1000)

FROM accounts
WHERE (name LIKE 'C%' OR name LIKE 'W%') 
AND (primary_poc LIKE '%ana%' OR primary_poc LIKE '%Ana%') 
AND (primary_poc NOT LIKE '%eana%');
