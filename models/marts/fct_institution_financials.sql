with institutions as (
    select * from {{ ref('stg_institutions') }}
),

balance_sheet as (
    select * from {{ ref('stg_balance_sheet') }}
),

income_statement as (
    select * from {{ ref('stg_income_statement') }}
)

select
    i.idrssd,
    i.institution_name,
    i.city,
    i.state,
    i.zip_code,
    i.fdic_cert_number,
    i.aba_routing_number,
    i.filing_type,

    -- Balance sheet
    bs.total_assets,
    bs.total_liabilities,
    bs.total_equity_capital,
    bs.total_deposits_domestic,
    bs.total_loans_and_leases_net,
    bs.securities_held_to_maturity,
    bs.securities_available_for_sale,
    bs.total_risk_weighted_assets,
    bs.goodwill,
    bs.retained_earnings,
    bs.tier_1_leverage_capital,

    -- Income statement
    ist.total_interest_income,
    ist.total_interest_expense,
    ist.net_interest_income,
    ist.total_noninterest_income,
    ist.total_noninterest_expense,
    ist.net_income,
    ist.salaries_and_employee_benefits,

    -- Derived metrics
    ist.net_interest_income + coalesce(ist.total_noninterest_income, 0)
        as total_revenue,
    case when bs.total_assets > 0
        then round(ist.net_income / bs.total_assets * 100, 4)
    end as return_on_assets_pct,
    case when bs.total_equity_capital > 0
        then round(ist.net_income / bs.total_equity_capital * 100, 4)
    end as return_on_equity_pct,
    case when bs.total_assets > 0
        then round(ist.net_interest_income / bs.total_assets * 100, 4)
    end as net_interest_margin_pct,
    case when (ist.net_interest_income + coalesce(ist.total_noninterest_income, 0)) > 0
        then round(
            ist.total_noninterest_expense
            / (ist.net_interest_income + coalesce(ist.total_noninterest_income, 0)) * 100,
            2
        )
    end as efficiency_ratio_pct,
    case when bs.total_assets > 0
        then round(bs.total_equity_capital / bs.total_assets * 100, 2)
    end as equity_to_assets_pct

from institutions i
left join balance_sheet bs on i.idrssd = bs.idrssd
left join income_statement ist on i.idrssd = ist.idrssd
