select
    cast(event_date as date) as event_date,
    region,
    category,
    sessions,
    conversions,
    revenue,
    latency_ms,
    conversions * 1.0 / nullif(sessions, 0) as conversion_rate,
    revenue * 1.0 / nullif(conversions, 0) as revenue_per_conversion
from {{ ref('chart_metrics') }}
