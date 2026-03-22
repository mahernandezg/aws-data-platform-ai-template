-- License: Apache 2.0
-- Author: Manuel Hernandez Giuliani
-- Date Created: 2026-03-22
-- Date Modified: 2026-03-22
-- Purpose: Silver transformation starter for the ingestion-s3-to-iceberg-dbt example.

-- Architecture component: DP-EH - Data Processing Center - Enterprise Hub
-- Medallion layer: Silver

with staged as (
    select * from {{ ref('stg_orders_landing') }}
)

select
    order_id,
    customer_id,
    lower(order_status) as order_status_normalized,
    order_total,
    order_timestamp
from staged
where order_id is not null
