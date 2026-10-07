select
    customer_key,
    any_value(channel) as channel,
    max(customer_name) as customer_name,
    max(customer_email) as customer_email,
    max(user_id) as user_id,
    count(*) as interaction_count,
    count_if(is_negative) as negative_interaction_count,
    round(count_if(is_negative) / count(*), 3) as negative_rate,
    mode(category) as top_category,
    min(created_at) as first_interaction_at,
    max(created_at) as last_interaction_at
from {{ ref('fct_interactions') }}
group by customer_key
