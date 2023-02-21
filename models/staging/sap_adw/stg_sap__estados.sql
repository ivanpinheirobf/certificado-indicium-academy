with
    source_states as (
        select 
        cast(stateprovinceid as int) as id_estado
        ,cast(territoryid as int) as id_territorio
        ,cast(stateprovincecode as string) as codigo_estado
        ,cast(countryregioncode as string) as codigo_pais
        ,cast(name as string) as nome_estado
        -- ,isonlystateprovinceflag	BOOLEAN	NULLABLE			
        -- ,rowguid	STRING	NULLABLE			
        -- ,modifieddate	STRING	NULLABLE
        from {{ source('sap', 'stateprovince') }}
    )

select *
from source_states