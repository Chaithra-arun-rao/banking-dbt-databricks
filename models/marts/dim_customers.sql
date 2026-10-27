select
    customer_id,
    first_name,
    last_name,
    date_of_birth,
    city,
    state,
    country,
    customer_since,
    risk_rating

from {{ ref('stg_customers') }}