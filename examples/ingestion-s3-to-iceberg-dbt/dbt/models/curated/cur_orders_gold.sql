-- License: Apache 2.0
-- Author: Manuel Hernandez Giuliani
-- Date Created: 2026-03-22
-- Date Modified: 2026-03-22
-- Purpose: Gold Data Product starter for the ingestion-s3-to-iceberg-dbt example.

-- Architecture component: DP-EH - Data Processing Center - Enterprise Hub
-- Medallion layer: Gold
-- DDC exposure rule: this model is intended for Gold-only downstream exposure through Athena.

select
    order_status_normalized as order_status,
    count(*) as order_count,
    sum(order_total) as total_order_value
from {{ ref('int_orders_silver') }}
group by order_status_normalized
