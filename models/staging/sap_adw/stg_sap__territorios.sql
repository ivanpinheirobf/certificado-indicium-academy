with
    source_salesterritory as (
        select 
            cast(territoryid as int) as id_territorio
            ,cast(name as string) as nome_territorio
            ,cast(countryregioncode as string) as codigo_pais
            -- ,'group'
            -- ,salesytd
            -- ,saleslastyear
            -- ,costytd
            -- ,costlastyear
            -- ,rowguid
            -- ,modifieddate
        from {{ source('sap', 'salesterritory') }}
    )

select *
from source_salesterritory