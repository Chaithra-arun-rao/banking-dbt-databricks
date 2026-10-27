select
    a.account_id,
    a.customer_id,
    a.branch_id,

    b.branch_name,
    b.city as branch_city,
    b.state as branch_state,
    b.region,

    a.account_type,
    a.open_date,
    a.account_status,
    a.current_balance,
    a.currency

from {{ ref('stg_accounts') }} a

left join {{ ref('stg_branches') }} b
    on a.branch_id = b.branch_id