/* This model is an example of an incremental model. It defaults to the Snowflake merge behavior (https://docs.getdbt.com/reference/resource-configs/snowflake-configs#merge-behavior-incremental-models)
when it is rebuilding only the latest roles.

Full documentation: https://docs.getdbt.com/docs/building-a-dbt-project/building-models/configuring-incremental-models

*/


{{
    config(
        materialized = 'incremental',
        unique_key = 'order_key',
        tags=['finance']
    )
}}

with orders as (
    
    select * from {{ ref('stg_tpch_orders') }} 

),

final as (

    select 

        orders.order_key, 
        orders.order_date,
        orders.customer_key,
        orders.status_code,
        orders.priority_code,
        orders.clerk_name,
        orders.ship_priority,
        orders.comment

    from
        orders
        {% if is_incremental() %}

            -- this filter will only be applied on an incremental run. Incremental models can be used to only rebuild the defined latest rows without rebuilding the entire table. 
            -- full documentation: https://docs.getdbt.com/docs/building-a-dbt-project/building-models/configuring-incremental-models#understanding-the-is_incremental-macro

            WHERE orders.update_timestamp_ntz > (select max(update_timestamp_ntz) from {{ this }})

        {% endif %}
)

select 
    *
from
    final

  

