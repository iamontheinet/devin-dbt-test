select
    channel,
    category,
    sentiment,
    count(*) as interaction_count,
    round(ratio_to_report(count(*)) over (partition by channel, category), 3) as share_of_category
from {{ ref('fct_interactions') }}
group by channel, category, sentiment
