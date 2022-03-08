{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('custom_ra_catalog_category_ab1') }}
select
    {{ cast_to_boolean('active') }} as active,
    cast(category_id as {{ dbt_utils.type_string() }}) as category_id,
    cast(display_name as {{ dbt_utils.type_string() }}) as display_name,
    cast(root_category as {{ dbt_utils.type_string() }}) as root_category,
    cast(external_type_id as {{ dbt_utils.type_string() }}) as external_type_id,
    cast(long_description as {{ dbt_utils.type_string() }}) as long_description,
    cast(parent_category_id as {{ dbt_utils.type_string() }}) as parent_category_id,
    cast(source_system_name as {{ dbt_utils.type_string() }}) as source_system_name,
    cast(record_inserted_timestamp as {{ dbt_utils.type_string() }}) as record_inserted_timestamp,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('custom_ra_catalog_category_ab1') }}
-- custom_ra_catalog_category
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

