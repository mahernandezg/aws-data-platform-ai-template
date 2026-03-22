-- License: Apache 2.0
-- Author: Manuel Hernandez Giuliani
-- Date Created: 2026-03-22
-- Date Modified: 2026-03-22
-- Purpose: Bronze-aligned staging model starter for the ingestion-s3-to-redshift-dbt example.

-- Architecture component: DP-EH - Data Processing Center - Enterprise Hub
-- Medallion layer: Bronze

select
    cast(order_id as varchar) as order_id,
    cast(customer_id as varchar) as customer_id,
    cast(order_status as varchar) as order_status,
    cast(order_total as decimal(18,2)) as order_total,
    cast(order_timestamp as timestamp) as order_timestamp
from {{ source('bronze_landing', 'orders_bronze') }}
