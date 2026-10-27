select
    c.customer_id,
    c.first_name,
    c.last_name,
    c.city,
    c.state,
    c.risk_rating,

    l.loan_id,
    l.loan_type,
    l.principal_amount,
    l.interest_rate,
    l.start_date,
    l.end_date,
    l.loan_status,
    l.outstanding_amount,

    round(
        l.outstanding_amount
        / nullif(l.principal_amount, 0)
        * 100,
        2
    ) as outstanding_pct,

    case
        when l.loan_status = 'DELINQUENT' then true
        when l.interest_rate >= 14 then true
        else false
    end as is_credit_risk

from {{ ref('stg_loans') }} l

left join {{ ref('stg_customers') }} c
    on l.customer_id = c.customer_id