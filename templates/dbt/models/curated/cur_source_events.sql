-- License: Apache 2.0
-- Author: Manuel Hernandez Giuliani
-- Date Created: 2026-03-22
-- Date Modified: 2026-03-22
-- Purpose: Curated model starter that exposes a final transformation output for DP-EH or DP-SP ownership.

-- Architecture component: do not place this model in DDC. Curated transformation ownership belongs to DP-EH or DP-SP.

select
    event_id,
    normalized_event_type as event_type,
    event_timestamp,
    source_system
from {{ ref('int_source_events_enriched') }}
