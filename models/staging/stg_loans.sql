select
    cast(loan_id as string) as loan_id,
    cast(customer_id as string) as customer_id,
    upper(loan_type) as loan_type,
    cast(principal_amount as decimal(18,2)) as principal_amount,
    cast(interest_rate as decimal(5,2)) as interest_rate,
    cast(start_date as date) as start_date,
    cast(end_date as date) as end_date,
    upper(loan_status) as loan_status,
    cast(outstanding_amount as decimal(18,2)) as outstanding_amount

from {{ ref('raw_loans') }}