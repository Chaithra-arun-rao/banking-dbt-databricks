select
    c.customer_id,
    c.first_name,
    c.last_name,
    c.city,
    c.state,
    c.country,
    c.risk_rating,

    a.account_id,
    a.branch_id,
    a.account_type,
    a.open_date,
    a.account_status,
    a.current_balance,
    a.currency

from {{ ref('stg_customers') }} c

left join {{ ref('stg_accounts') }} a
    on c.customer_id = a.customer_id