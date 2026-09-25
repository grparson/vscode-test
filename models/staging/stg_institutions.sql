with source as (
    select * from {{ source('raw', 'call_bulk_por') }}
)

select
    cast(idrssd as integer)                        as idrssd,
    cast(fdic_certificate_number as integer)       as fdic_cert_number,
    cast(occ_charter_number as integer)            as occ_charter_number,
    cast(ots_docket_number as integer)             as ots_docket_number,
    primary_aba_routing_number                     as aba_routing_number,
    trim(financial_institution_name)               as institution_name,
    trim(financial_institution_address)            as address,
    trim(financial_institution_city)               as city,
    trim(financial_institution_state)              as state,
    trim(financial_institution_zip_code)           as zip_code,
    trim(financial_institution_filing_type)        as filing_type,
    try_to_timestamp(last_datetime_submission_updated_on) as submission_updated_at,
    _source_file,
    _load_timestamp
from source
