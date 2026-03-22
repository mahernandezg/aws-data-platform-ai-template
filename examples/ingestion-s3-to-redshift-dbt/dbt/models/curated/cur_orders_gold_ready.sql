-- License: Apache 2.0
-- Author: Manuel Hernandez Giuliani
-- Date Created: 2026-03-22
-- Date Modified: 2026-03-22
-- Purpose: Gold-ready Data Product starter for the ingestion-s3-to-redshift-dbt example.

-- Architecture component: DP-EH - Data Processing Center - Enterprise Hub
-- Medallion layer: Gold
-- Serving note: this model is the Gold-ready source for DDC Redshift serving and is not itself the final Redshift serving table.

select
    customer_id,
    count(*) as order_count,
    sum(order_total) as total_order_value,
    max(order_timestamp) as last_order_timestamp
from {{ ref('int_orders_silver') }}
group by customer_id
