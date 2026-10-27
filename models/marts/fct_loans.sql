select
    loan_id,
    customer_id,

    loan_type,

    principal_amount,
    interest_rate,

    start_date,
    end_date,

    loan_status,

    outstanding_amount,
    outstanding_pct,

    risk_rating,
    is_credit_risk

from {{ ref('int_customer_loans') }}