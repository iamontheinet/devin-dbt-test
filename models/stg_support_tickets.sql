{{ config(materialized='view') }}

select
    ticket_id,
    service_type,
    contact_preference
from {{ source('dash_schema', 'SUPPORT_TICKETS') }}
