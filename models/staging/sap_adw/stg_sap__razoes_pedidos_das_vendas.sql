with
    source_salesorderheadersalesreason as (
        select 
            cast(salesorderid as int) as id_pedido_da_venda
            ,cast(salesreasonid as int) as id_razao_da_venda
            -- ,modifieddate
        from {{ source('sap', 'salesorderheadersalesreason') }}
    )

select *
from source_salesorderheadersalesreason