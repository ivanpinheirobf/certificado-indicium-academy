with
    source_country as (
        select     	
        cast(countryregioncode as string) as codigo_pais
        ,cast(name as string) as nome_pais	
        -- ,modifieddate
        from {{ source('sap', 'countryregion') }}
    )

select *
from source_country