with UNIQUE_PARTS as (
    select * 
    from {{ ref('unique_parts') }}
)
select
	 T.NAME as THEME_NAME
	,S.NAME as SET_NAME
	,S.YEAR as SET_YEAR
	,case 
		when UP.part_num IS NULL then 'Not Unique' 
		else 'Unique' 
	end as unique_part,
	count(P.PART_NUM) as PARTS
FROM {{ source('lego', 'parts') }} as P
LEFT JOIN UNIQUE_PARTS as UP on P.part_num = UP.part_num
INNER JOIN {{ source('lego', 'inventory_parts') }} as IP    on P.part_num = IP.part_num
INNER JOIN {{ source('lego', 'inventories') }}     as I     on I.id = IP.inventory_id
INNER JOIN {{ source('lego', 'sets') }}            as S     on S.set_num = I.set_num
INNER JOIN {{ source('lego', 'themes') }}          as T     on T.id = S.theme_id
GROUP BY 1,2,3,4