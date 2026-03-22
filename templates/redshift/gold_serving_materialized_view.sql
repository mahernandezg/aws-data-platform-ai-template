-- License: Apache 2.0
-- Author: Manuel Hernandez Giuliani
-- Date Created: 2026-03-22
-- Date Modified: 2026-03-22
-- Purpose: Redshift Gold-serving materialized view starter for read-optimized consumer access.

-- Architecture component: DDC - Data Distribution Center
-- Medallion layer: Gold exposure

create materialized view if not exists serving_gold.mv_customer_order_summary as
select
    customer_id,
    sum(order_count) as order_count,
    sum(total_order_amount) as total_order_amount,
    max(last_order_timestamp_utc) as last_order_timestamp_utc
from serving_gold.customer_order_summary
group by customer_id;
