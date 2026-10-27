select
    c.customer_id,
    c.first_name,
    c.last_name,
    c.risk_rating,

    a.account_id,
    a.account_type,

    t.transaction_id,
    t.transaction_ts,
    t.transaction_type,
    t.channel,
    t.amount,
    t.merchant_category,
    t.transaction_status,
    t.country,

    case
        when t.transaction_type = 'DEBIT'
            then -t.amount
        else t.amount
    end as signed_amount,

    case
        when t.amount >= 50000 then true
        when hour(t.transaction_ts) between 0 and 4 then true
        when t.country <> 'India' then true
        else false
    end as is_high_risk_transaction

from {{ ref('stg_transactions') }} t

left join {{ ref('stg_accounts') }} a
    on t.account_id = a.account_id

left join {{ ref('stg_customers') }} c
    on a.customer_id = c.customer_id