use olist_data_analysis;
select * from order_dataset;
## Weekend Vs Weekday ##
select * from order_dataset;
select * from Order_Payments_dataset;
select case when dayofweek(str_to_date(o.order_purchase_timestamp, '%Y-%m-%d')) in (1,7) then "weekend" else "weekday"
end as Day_Name,
round(sum(p.Payment_value))as Total_Payment
from order_dataset o join order_payments_dataset p on o.order_id = p.Order_id
group by Day_name;

## Number of Orders with review Score 5 ##
select * from order_reviews_dataset;
select * from order_payments_dataset;
select count(distinct p.order_id)as CountOfOrders
from order_payments_dataset p
join order_reviews_dataset r on p.order_id = r.order_id
where r.review_score = 5
and p.payment_type = 'Credit_card';

## Average Number Of days Taken for Pet Shop ##
select * from order_dataset;
select product_category_name, round(avg(datediff(order_delivered_customer_date, order_purchase_timestamp)),0) as Average_Delivery_Days
from order_dataset o
join Order_items_dataset i on i.order_id = o.order_id
join Products_dataset p on p.product_id = i.product_id
where p.product_category_name = 'pet_shop'
and o.order_delivered_customer_date is not null;

## Average Payment and Average Price for Sao Palao City ##
select * from customers_dataset;
select round(avg(i.price)) as Average_Price,
round(avg(p.payment_value)) as Average_payment
from customers_dataset c
join order_dataset o on c.customer_id = o.customer_id
join Order_items_dataset i on o.order_id =i.Order_id
join order_payments_dataset p on o.order_id = p.order_id
where c.customer_city = 'Sao Paulo';

## Review score with Average shipping Days ##
select round(avg(datediff(order_delivered_customer_date, order_purchase_timestamp)),0) as Average_Shipping_Days,
Review_score from Order_dataset o
join Order_reviews_dataset r on o.order_id = r.order_id
where order_delivered_customer_date is not null
and order_purchase_timestamp is not null 
group by review_score;

