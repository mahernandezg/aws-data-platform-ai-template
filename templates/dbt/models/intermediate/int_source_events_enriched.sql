-- License: Apache 2.0
-- Author: Manuel Hernandez Giuliani
-- Date Created: 2026-03-22
-- Date Modified: 2026-03-22
-- Purpose: Intermediate model starter that applies reusable transformation logic while preserving readable lineage.

with staged as (
    select * from {{ ref('stg_source_events') }}
)

select
    event_id,
    event_type,
    event_timestamp,
    source_system,
    case
        when event_type is null then 'unknown'
        else lower(event_type)
    end as normalized_event_type
from staged
