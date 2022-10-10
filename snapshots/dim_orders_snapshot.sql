{% snapshot dim_orders_snapshot %}

{{
    config(

      target_schema='snapshots',
      unique_key='order_key',

      strategy='timestamp',
      updated_at='update_timestamp_ntz',
    )
}}

select *
 from {{ ref('incremental_dim_orders') }}

{% endsnapshot %}