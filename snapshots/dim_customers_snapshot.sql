{% snapshot dim_customers_snapshot %}

{{
    config(

      target_schema='snapshots',
      unique_key='customer_key',

      strategy='check',
      check_cols = 'all'
      
    )
}}

select *
 from {{ ref('dim_customers') }}

{% endsnapshot %}