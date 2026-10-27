with account_summary as (

    select
        customer_id,
        count(*) as account_count,
        sum(current_balance) as total_balance

    from {{ ref('dim_accounts') }}

    group by customer_id

),

transaction_summary as (

    select
        customer_id,

        count(*) as transaction_count,

        sum(
            case
                when transaction_type = 'DEBIT'
                then amount
                else 0
            end
        ) as total_debits,

        sum(
            case
                when transaction_type = 'CREDIT'
                then amount
                else 0
            end
        ) as total_credits,

        sum(
            case
                when is_high_risk_transaction = true
                then 1
                else 0
            end
        ) as high_risk_transaction_count

    from {{ ref('fct_transactions') }}

    group by customer_id

),

loan_summary as (

    select
        customer_id,

        count(*) as loan_count,

        sum(outstanding_amount)
            as total_loan_outstanding,

        max(
            case
                when is_credit_risk = true
                then 1
                else 0
            end
        ) as has_credit_risk

    from {{ ref('fct_loans') }}

    group by customer_id

)

select
    c.customer_id,
    c.first_name,
    c.last_name,

    c.city,
    c.state,

    c.customer_since,
    c.risk_rating,

    coalesce(a.account_count, 0)
        as account_count,

    coalesce(a.total_balance, 0)
        as total_balance,

    coalesce(t.transaction_count, 0)
        as transaction_count,

    coalesce(t.total_debits, 0)
        as total_debits,

    coalesce(t.total_credits, 0)
        as total_credits,

    coalesce(t.high_risk_transaction_count, 0)
        as high_risk_transaction_count,

    coalesce(l.loan_count, 0)
        as loan_count,

    coalesce(l.total_loan_outstanding, 0)
        as total_loan_outstanding,

    coalesce(l.has_credit_risk, 0)
        as has_credit_risk

from {{ ref('dim_customers') }} c

left join account_summary a
    on c.customer_id = a.customer_id

left join transaction_summary t
    on c.customer_id = t.customer_id

left join loan_summary l
    on c.customer_id = l.customer_id