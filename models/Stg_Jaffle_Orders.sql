select
        id as Order_id,
        user_id as customer_id,
        order_date,
        status
    from raw.jaffle_shop.Orders