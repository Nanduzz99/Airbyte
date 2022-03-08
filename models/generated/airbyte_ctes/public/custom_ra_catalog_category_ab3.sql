{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('custom_ra_catalog_category_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        boolean_to_string('active'),
        'category_id',
        'display_name',
        'root_category',
        'external_type_id',
        'long_description',
        'parent_category_id',
        'source_system_name',
        'record_inserted_timestamp',
    ]) }} as _airbyte_custom_ra_catalog_category_hashid,
    tmp.*
from {{ ref('custom_ra_catalog_category_ab2') }} tmp
-- custom_ra_catalog_category
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

