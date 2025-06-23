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
    select customer_id, order_id
    from {{ ref('stg_orders') }}
)

select od.order_id, customer_id, anount 
from orders od inner join payments pt 
on od.order_id = pt.order_id