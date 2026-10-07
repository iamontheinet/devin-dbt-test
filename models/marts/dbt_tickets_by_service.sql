{{ config(materialized='table') }}

select
    service_type,
    contact_preference,
    count(*) as ticket_count
from {{ ref('stg_support_tickets') }}
group by service_type, contact_preference
