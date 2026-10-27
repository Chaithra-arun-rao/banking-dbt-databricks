select
    cast(branch_id as string) as branch_id,
    branch_name,
    city,
    state,
    upper(region) as region

from {{ ref('raw_branches') }}