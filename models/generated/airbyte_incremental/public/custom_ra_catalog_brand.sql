{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "public",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('custom_ra_catalog_brand_ab3') }}
select
    brand_id,
    brand_name,
    source_system_name,
    record_inserted_timestamp,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_custom_ra_catalog_brand_hashid
from {{ ref('custom_ra_catalog_brand_ab3') }}
-- custom_ra_catalog_brand from {{ source('public', '_airbyte_raw_custom_ra_catalog_brand') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

