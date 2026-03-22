-- License: Apache 2.0
-- Author: Manuel Hernandez Giuliani
-- Date Created: 2026-03-22
-- Date Modified: 2026-03-22
-- Purpose: Redshift Gold-serving table starter for DDC-owned final Data Product storage.

-- Architecture component: DDC - Data Distribution Center
-- Medallion layer: Gold exposure
-- Notes:
-- - This table stores the final serving copy of a Gold Data Product.
-- - Processing and Gold-ready derivation must happen outside Redshift.
-- - Extend with business columns appropriate for the Data Product.

create table if not exists serving_gold.customer_order_summary (
    customer_id varchar(256) not null,
    order_count integer,
    total_order_amount decimal(18,2),
    last_order_timestamp_utc timestamp,
    data_product_name varchar(256),
    load_batch_id varchar(64),
    load_timestamp_utc timestamp
);
