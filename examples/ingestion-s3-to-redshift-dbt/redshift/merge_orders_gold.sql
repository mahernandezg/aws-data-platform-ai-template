-- License: Apache 2.0
-- Author: Manuel Hernandez Giuliani
-- Date Created: 2026-03-22
-- Date Modified: 2026-03-22
-- Purpose: Redshift staging-table and merge skeleton for the ingestion-s3-to-redshift-dbt example.

-- Architecture component: DDC - Data Distribution Center
-- Serving layer: Gold
-- Note: this script assumes the Gold-ready batch has already been produced in DP-EH and staged in a controlled S3 location.

create table if not exists ddc_gold.orders_gold_stage (
    customer_id varchar(256),
    order_count integer,
    total_order_value decimal(18,2),
    last_order_timestamp timestamp,
    load_batch_id varchar(64),
    load_timestamp_utc timestamp
);

truncate table ddc_gold.orders_gold_stage;

copy ddc_gold.orders_gold_stage
from 's3://<redshift-stage-bucket>/<path-to-current-batch>/'
iam_role '<ddc-redshift-copy-role-arn>'
format as parquet;

merge into ddc_gold.orders_gold as target
using ddc_gold.orders_gold_stage as source
on target.customer_id = source.customer_id
when matched then update set
    order_count = source.order_count,
    total_order_value = source.total_order_value,
    last_order_timestamp = source.last_order_timestamp,
    load_batch_id = source.load_batch_id,
    load_timestamp_utc = source.load_timestamp_utc
when not matched then insert (
    customer_id,
    order_count,
    total_order_value,
    last_order_timestamp,
    load_batch_id,
    load_timestamp_utc
) values (
    source.customer_id,
    source.order_count,
    source.total_order_value,
    source.last_order_timestamp,
    source.load_batch_id,
    source.load_timestamp_utc
);
