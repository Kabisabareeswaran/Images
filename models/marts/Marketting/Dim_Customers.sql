
with customers as  ( 
    
Select * 
from {{ ref('Stg_Jaffle__Customers')}}
),

Orders as (
Select * 
from {{ ref('Stg_Jaffle__Orders') }}

),

customer_orders as (
    select
        customer_Id,
        min(order_date) as first_order_date,
        max(order_date) as most_recent_order_date,
        count(Order_Id) as number_of_orders
    from Orders
    group by 1 
),

final as (
    Select 
        customers.customer_id,
        customers.first_name,
        customers.last_name,
        customer_orders.first_order_date,
        customer_orders.most_recent_order_date,
        coalesce(customer_orders.number_of_orders, 0) as number_of_orders
    from customers

    left join customer_orders using (customer_id)
)

select * from final