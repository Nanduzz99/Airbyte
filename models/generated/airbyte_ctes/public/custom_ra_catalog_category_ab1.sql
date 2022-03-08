{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('public', '_airbyte_raw_custom_ra_catalog_category') }}
select
    {{ json_extract_scalar('_airbyte_data', ['active'], ['active']) }} as active,
    {{ json_extract_scalar('_airbyte_data', ['category_id'], ['category_id']) }} as category_id,
    {{ json_extract_scalar('_airbyte_data', ['display_name'], ['display_name']) }} as display_name,
    {{ json_extract_scalar('_airbyte_data', ['root_category'], ['root_category']) }} as root_category,
    {{ json_extract_scalar('_airbyte_data', ['external_type_id'], ['external_type_id']) }} as external_type_id,
    {{ json_extract_scalar('_airbyte_data', ['long_description'], ['long_description']) }} as long_description,
    {{ json_extract_scalar('_airbyte_data', ['parent_category_id'], ['parent_category_id']) }} as parent_category_id,
    {{ json_extract_scalar('_airbyte_data', ['source_system_name'], ['source_system_name']) }} as source_system_name,
    {{ json_extract_scalar('_airbyte_data', ['record_inserted_timestamp'], ['record_inserted_timestamp']) }} as record_inserted_timestamp,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('public', '_airbyte_raw_custom_ra_catalog_category') }} as table_alias
-- custom_ra_catalog_category
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

