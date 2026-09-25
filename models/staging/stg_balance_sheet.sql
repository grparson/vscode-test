with source as (
    select * from {{ source('raw', 'call_schedule_rc') }}
)

select
    cast(idrssd as integer)               as idrssd,

    -- Key balance sheet line items (RCFD = consolidated, RCON = domestic)
    cast(rcfd2170 as numeric(18,0))       as total_assets,
    cast(rcfd3210 as numeric(18,0))       as total_liabilities,
    cast(rcfd3230 as numeric(18,0))       as total_equity_capital,
    cast(rcon2200 as numeric(18,0))       as total_deposits_domestic,
    cast(rcfn2200 as numeric(18,0))       as total_deposits_consolidated,
    cast(rcfd2130 as numeric(18,0))       as securities_held_to_maturity,
    cast(rcfd2145 as numeric(18,0))       as securities_available_for_sale,
    cast(rcfd0071 as numeric(18,0))       as total_loans_and_leases_net,
    cast(rcfd3300 as numeric(18,0))       as total_risk_weighted_assets,
    cast(rcfd2930 as numeric(18,0))       as other_real_estate_owned,
    cast(rcfd3000 as numeric(18,0))       as total_investment_securities,
    cast(rcfd3545 as numeric(18,0))       as goodwill,
    cast(rcfd3548 as numeric(18,0))       as other_intangible_assets,
    cast(rcfd2948 as numeric(18,0))       as interest_bearing_deposits,
    cast(rcfdb995 as numeric(18,0))       as trading_assets,
    cast(rcfd5369 as numeric(18,0))       as retained_earnings,
    cast(rcfd3838 as numeric(18,0))       as tier_1_leverage_capital,
    cast(rcfd3839 as numeric(18,0))       as tier_1_risk_based_capital,

    _source_file,
    _load_timestamp
from source
