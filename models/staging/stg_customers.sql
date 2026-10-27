select
    cast(customer_id as string) as customer_id,
    initcap(first_name) as first_name,
    initcap(last_name) as last_name,
    cast(date_of_birth as date) as date_of_birth,
    city,
    state,
    country,
    cast(customer_since as date) as customer_since,
    upper(risk_rating) as risk_rating

from {{ ref('raw_customers') }}