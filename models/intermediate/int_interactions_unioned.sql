-- Tickets and emails come from unrelated systems (no shared keys), so they are
-- stacked as separate channels rather than joined.
with tickets as (
    select
        'support_ticket' as channel,
        ticket_id as source_ticket_id,
        md5('support_ticket|' || coalesce(customer_email, 'unknown:' || ticket_id)) as customer_key,
        customer_name,
        customer_email,
        null::number as user_id,
        null::timestamp_ntz as created_at,
        service_type,
        contact_preference,
        message_text
    from {{ ref('stg_support_tickets') }}
),

emails as (
    select
        'email' as channel,
        ticket_id as source_ticket_id,
        md5('email|' || user_id) as customer_key,
        null as customer_name,
        null as customer_email,
        user_id,
        created_at,
        null as service_type,
        'Email' as contact_preference,
        message_text
    from {{ ref('stg_emails') }}
),

unioned as (
    select * from tickets
    union all
    select * from emails
)

select
    md5(channel || '|' || source_ticket_id || '|' || message_text) as interaction_id,
    *
from unioned
where message_text is not null
qualify row_number() over (partition by interaction_id order by created_at) = 1
