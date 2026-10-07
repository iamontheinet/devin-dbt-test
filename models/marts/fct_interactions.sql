select
    interaction_id,
    channel,
    customer_key,
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
