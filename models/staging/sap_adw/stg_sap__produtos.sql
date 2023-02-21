with
    source_product as (
        select 
            cast(productid as int) as id_produto
            ,cast(name as string) as nome_produto
            ,cast(productnumber as string) as numero_produto
            ,cast(color as string) as cor_produto
            ,cast(safetystocklevel as int) as nivel_estoque_seguranca
            ,cast(reorderpoint as int) as ponto_reabastecimento
            ,cast(standardcost as numeric) as custo_padrao
            ,cast(listprice as numeric) as preco_tabelado
            -- ,makeflag
            -- ,finishedgoodsflag
            -- ,'size'
            -- ,sizeunitmeasurecode
            -- ,weightunitmeasurecode
            -- ,weight
            -- ,daystomanufacture
            -- ,productline
            -- ,class
            -- ,style
            -- ,productsubcategoryid
            -- ,productmodelid
            -- ,sellstartdate
            -- ,sellenddate
            -- ,discontinueddate
            -- ,rowguid
            -- ,modifieddate
        from {{ source('sap', 'product') }}
    )

select *
from source_product