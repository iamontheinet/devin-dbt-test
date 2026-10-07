select
    interaction_id,
    channel,
    customer_key,
    customer_name,
    customer_email,
    user_id,
    source_ticket_id,
    created_at,
    service_type,
    contact_preference,
    category,
    sentiment,
    sentiment in ('negative', 'mixed') as is_negative,
    message_text,
    enriched_at
from {{ ref('int_interactions_enriched') }}
