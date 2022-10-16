/* This is an analysis model. Models in the analysis folder are compiled by dbt but not executed. These sql queries allows you to use 
dbt functionalities like ref to select from environment-specific locations and version control without the need to create an object in 
Snowflake. These are useful for shared audit queries, potential dashboard queries, etc. 
For full documentation: https://docs.getdbt.com/docs/building-a-dbt-project/analyses

*/

select * from {{ ref('dim_orders') }}

