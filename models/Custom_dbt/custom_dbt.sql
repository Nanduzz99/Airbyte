select
    a.brand_name,
    b.display_name,
    b.category_id
from {{ ref('custom_ra_catalog_brand') }} a
left join {{ ref('custom_ra_catalog_category') }} b
on a._airbyte_custom_ra_catalog_brand_hashid = b._airbyte_custom_ra_catalog_category_hashid