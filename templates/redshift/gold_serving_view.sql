-- License: Apache 2.0
-- Author: Manuel Hernandez Giuliani
-- Date Created: 2026-03-22
-- Date Modified: 2026-03-22
-- Purpose: Redshift Gold-serving view starter for consumer-friendly access over final serving tables.

-- Architecture component: DDC - Data Distribution Center
-- Medallion layer: Gold exposure

create or replace view serving_gold.vw_customer_order_summary as
select
    customer_id,
    order_count,
    total_order_amount,
    last_order_timestamp_utc
from serving_gold.customer_order_summary;
