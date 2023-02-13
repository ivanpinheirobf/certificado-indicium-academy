with
    source_salesreason as (
        select 
            cast(salesreasonid as int) id_razao_da_venda
            ,cast(name as string) as nome_razao_da_venda
            ,cast(reasontype as string) as tipo_razao_da_venda
            -- ,modifieddate
        from {{ source('sap', 'salesreason') }}
    )

select *
from source_salesreason