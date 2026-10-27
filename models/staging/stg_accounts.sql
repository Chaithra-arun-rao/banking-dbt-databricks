select
    cast(account_id as string) as account_id,
    cast(customer_id as string) as customer_id,
    cast(branch_id as string) as branch_id,
    upper(account_type) as account_type,
    cast(open_date as date) as open_date,
    upper(status) as account_status,
    cast(current_balance as decimal(18,2)) as current_balance,
    upper(currency) as currency

from {{ ref('raw_accounts') }}