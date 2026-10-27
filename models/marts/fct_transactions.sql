select
    transaction_id,
    customer_id,
    account_id,

    transaction_ts,
    cast(transaction_ts as date) as transaction_date,

    transaction_type,
    channel,

    amount,
    signed_amount,

    merchant_category,
    transaction_status,
    country,

    is_high_risk_transaction

from {{ ref('int_customer_transactions') }}