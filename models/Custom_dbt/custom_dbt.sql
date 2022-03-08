select
    a.brand_name,
    b.display_name,
from {{ ref('custom_ra_catalog_brand') }} a
left join {{ ref('custom_ra_catalog_category') }} b
no _airbyte_custom_ra_catalog_category_hashid