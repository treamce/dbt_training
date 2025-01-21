{{
    config(
        materialized='view'
    )
}}

select 
	 P.PART_NUM
from {{ source('lego', 'parts') }} as P
    inner join {{ source('lego', 'inventory_parts') }} as IP    on P.part_num = IP.part_num
    inner join {{ source('lego', 'inventories') }} as I         on I.id = IP.inventory_id
    inner join {{ source('lego', 'sets') }} as S                on S.set_num = I.set_num
group by P.PART_NUM
having count(*) = 1