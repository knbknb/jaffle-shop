with payments as (
 select
   payment_id,
  `amount`,
  `order_id`,
  `payment_method`,
  `status`
 from {{ ref('stg_stripe__payments') }} 
 where status = 'success'
),

orders as (
    select customer_id, customer_order_number as order_id
    from {{ ref('orders') }}
)

select od.order_id, customer_id, pt.amount 
from orders od inner join payments pt 
on od.order_id = pt.order_id
order by customer_id, order_id