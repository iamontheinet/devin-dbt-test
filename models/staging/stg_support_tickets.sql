select
    ticket_id,
    customer_name,
    lower(trim(customer_email)) as customer_email,
    service_type,
    contact_preference,
    request as message_text
from {{ source('dash_schema', 'SUPPORT_TICKETS') }}
