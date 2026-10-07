select
    to_varchar(ticket_id) as ticket_id,
    user_id,
    created_at,
    content as message_text
from {{ source('dash_schema', 'EMAILS') }}
