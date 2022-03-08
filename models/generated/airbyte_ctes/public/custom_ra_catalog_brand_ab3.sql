{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('custom_ra_catalog_brand_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'brand_id',
        'brand_name',
        'source_system_name',
        'record_inserted_timestamp',
    ]) }} as _airbyte_custom_ra_catalog_brand_hashid,
    tmp.*
from {{ ref('custom_ra_catalog_brand_ab2') }} tmp
-- custom_ra_catalog_brand
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

