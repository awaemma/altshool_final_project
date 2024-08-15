/** Given the requirement to calculate the average delivery time for each order,
    all order_ids are unqiue, hence we are able to calculate just the delivery time 
    and I have used the difference between when customer confirmed receipt (order_delivered_customer_date)
    and when order purchase was made (order_purchase_timestamp).
    - More so, we have filtered to only orders with order_status as 'delivered'.
**/

with delivery_time as (
    select
       order_id
     ,order_purchase_timestamp
     ,order_delivered_carrier_date
    from
        {{ref('stg_orders')}}
    where
       order_status = 'delivered'      
)
select
   order_id
  ,AVG(TIMESTAMP_DIFF(order_delivered_carrier_date,order_purchase_timestamp,DAY)) as avg_delivery_time
from
   delivery_time
group by 
   order_id
