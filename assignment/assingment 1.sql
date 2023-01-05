USE DATABASE WORK;
CREATE OR REPLACE TABLE AS_SALES_DATA
( ORDER_ID VARCHAR(50),
ORDER_DATE VARCHAR(50),
SHIP_DATE VARCHAR(50) ,
SHIP_MODE VARCHAR(15),
CUSTOMER_NAME VARCHAR(50),
SEGMENT VARCHAR(50),
STATE VARCHAR(50),
COUNTRY VARCHAR(50),
MARKET VARCHAR(50),
REGION VARCHAR(50),
PRODUCT_ID VARCHAR(50),
CATEGORY VARCHAR(50),
SUB_CATEGORY VARCHAR(50),
PRODUCT_NAME VARCHAR(150),
SALES varchar(50),
QUANTITY INT,
DISCOUNT FLOAT(4),
PROFIT FLOAT(10),
SHIPPONG_COST VARCHAR(8),
ORDER_PRIORITY VARCHAR (8),
YEAR VARCHAR(4));
describe table as_sales_data;
select * from as_sales_data;
------------------------------
describe table as_sales_data;
alter table as_sales_data
drop primary key;

/*2. creating 'order_id' as primary key*/

alter table as_sales_data
add primary key (order_id);
describe table as_sales_data;

/*3. check the data type for order date and ship date and mention in what data type it should be ?*/
describe table as_sales_data;
alter table as_sales_data
add column order_date_new date;
update as_sales_data set order_date_new = order_date;
alter table as_sales_data
add column ship_date_new date;
update as_sales_data set ship_date_new = ship_date;
describe table as_sales_data;

/*4. create a new column called order extract and extract the number after the last '-' from order id column*/

alter table as_sales_data
add column order_extract varchar(10);
update as_sales_data set order_extract =  substring(order_id,9);

/*5. create a new column called discount flag and categorize it based on dicount,
use 'yes' if dicount is greater than zero else 'no'*/

select *,
        case when discount > 0 then 'yes'
        else 'no'
        end as discount_flag from as_sales_data;
        
/*6. create a new column called process days and calculate how many days it takes for each order id to process from
the order to its shipment*/
        
alter table as_sales_data
add column process_days varchar(10);
update as_sales_data set process_days = datediff('days',order_date,ship_date);

/*7. create a new column rating and than based on the process days give rating*/

alter table as_sales_data
add column rating int;
update as_sales_data
set rating = 5 where process_days <= 3;
update as_sales_data
set rating = 4 where process_days > 3 and process_days <=6;
update as_sales_data
set rating = 3 where process_days > 6 and process_days <=10;
update as_sales_data
set rating = 2 where process_days >10;
