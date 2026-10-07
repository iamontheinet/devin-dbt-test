-- Incremental so Cortex AI functions only run on new interactions.
{{ config(
    materialized='incremental',
    unique_key='interaction_id',
    on_schema_change='append_new_columns'
) }}

select
    u.*,
    ai_sentiment(u.message_text):categories[0]:sentiment::string as sentiment,
    ai_classify(
        u.message_text,
        [{% for c in interaction_categories() %}'{{ c }}'{% if not loop.last %}, {% endif %}{% endfor %}]
    ):labels[0]::string as category,
    current_timestamp() as enriched_at
from {{ ref('int_interactions_unioned') }} u
{% if is_incremental() %}
where u.interaction_id not in (select interaction_id from {{ this }})
{% endif %}
