-- License: Apache 2.0
-- Author: Manuel Hernandez Giuliani
-- Date Created: 2026-03-22
-- Date Modified: 2026-03-22
-- Purpose: Redshift column anonymization view starter for controlled consumer exposure of sensitive attributes.

-- Architecture component: DDC - Data Distribution Center
-- Pattern intent: PII masking and controlled Gold exposure
-- Notes:
-- - Use governed access and masking logic together.
-- - Do not expose raw sensitive columns broadly through DDC.

create or replace view serving_gold.vw_customer_order_summary_masked as
select
    customer_id,
    order_count,
    total_order_amount,
    last_order_timestamp_utc,
    case
        when current_user in ('platform_admin') then data_product_name
        else 'masked'
    end as data_product_name_masked
from serving_gold.customer_order_summary;
