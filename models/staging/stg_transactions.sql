select
    cast(transaction_id as string) as transaction_id,
    cast(account_id as string) as account_id,
    cast(transaction_ts as timestamp) as transaction_ts,
    upper(transaction_type) as transaction_type,
    upper(channel) as channel,
    cast(amount as decimal(18,2)) as amount,
    upper(merchant_category) as merchant_category,
    upper(transaction_status) as transaction_status,
    country

from {{ ref('raw_transactions') }}