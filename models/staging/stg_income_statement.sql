with source as (
    select * from {{ source('raw', 'call_schedule_ri') }}
)

select
    cast(idrssd as integer)               as idrssd,

    -- Interest income and expense
    cast(riad4107 as numeric(18,0))       as total_interest_income,
    cast(riad4073 as numeric(18,0))       as total_interest_expense,
    cast(riad4074 as numeric(18,0))       as net_interest_income,

    -- Noninterest income and expense
    cast(riad4079 as numeric(18,0))       as total_noninterest_income,
    cast(riad4093 as numeric(18,0))       as total_noninterest_expense,

    -- Net income
    cast(riad4300 as numeric(18,0))       as income_before_taxes,
    cast(riad4302 as numeric(18,0))       as applicable_income_taxes,
    cast(riad4340 as numeric(18,0))       as net_income,

    -- Loan interest components
    cast(riad4010 as numeric(18,0))       as interest_income_loans_leases,
    cast(riad4020 as numeric(18,0))       as interest_income_us_treasuries,
    cast(riad4115 as numeric(18,0))       as interest_income_trading_assets,

    -- Deposit expense components
    cast(riad4508 as numeric(18,0))       as interest_expense_deposits,
    cast(riad4180 as numeric(18,0))       as interest_expense_fed_funds,

    -- Salary and benefits
    cast(riad4135 as numeric(18,0))       as salaries_and_employee_benefits,

    _source_file,
    _load_timestamp
from source
