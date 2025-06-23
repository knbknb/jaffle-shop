with

source as (

    --select * from {{ source('ecom', 'raw_customers') }}
    --select * from `dbt-tutorial`.stripe.payment
    select * from {{ source('stripe', 'payments') }}
),

renamed as (

    select

        ----------  ids
        id as payment_id,
        orderid as order_id,

        ---------- text
        paymentmethod as payment_method,
        status,
        amount /100 as amount
        created as created_at

    from source

)

select * from renamed