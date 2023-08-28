{% test primary_key(model, column_name) %}

    with dataset as (
        select
            {{ column_name }} as pk
        from {{ model }} )
    select pk from dataset where pk is null
    UNION ALL 
    select pk from dataset group by pk 
    having count(1)>1

{% endtest  %}