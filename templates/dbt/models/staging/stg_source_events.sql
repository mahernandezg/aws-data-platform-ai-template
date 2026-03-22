-- License: Apache 2.0
-- Author: Manuel Hernandez Giuliani
-- Date Created: 2026-03-22
-- Date Modified: 2026-03-22
-- Purpose: Staging model starter for DP-EH or DP-SP that normalizes source event fields before downstream transformation.

-- Architecture component: choose DP-EH for shared logic or DP-SP for domain-specific logic before using this template.

select
    cast(event_id as varchar) as event_id,
    cast(event_type as varchar) as event_type,
    cast(event_timestamp as timestamp) as event_timestamp,
    cast(source_system as varchar) as source_system
from {{ source('landing', 'source_events') }}
