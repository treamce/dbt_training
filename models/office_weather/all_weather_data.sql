{{ config(
    materialized='incremental',
    unique_key=['office','time']
)}}
SELECT *
FROM {{ref('stg_weather_data')}}
{% if is_incremental() %}
    WHERE time >= (SELECT MAX(time) FROM {{ this }})
{% endif %}