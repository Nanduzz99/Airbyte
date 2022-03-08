{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('custom_ra_catalog_brand_ab1') }}
select
    cast(brand_id as {{ dbt_utils.type_string() }}) as brand_id,
    cast(brand_name as {{ dbt_utils.type_string() }}) as brand_name,
    cast(source_system_name as {{ dbt_utils.type_string() }}) as source_system_name,
    cast(record_inserted_timestamp as {{ dbt_utils.type_string() }}) as record_inserted_timestamp,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('custom_ra_catalog_brand_ab1') }}
-- custom_ra_catalog_brand
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

