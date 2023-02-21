with
    source_salesorderdetail as (
        select 
            cast(salesorderdetailid as int) as id_detalhe_pedido_da_venda
            ,cast(salesorderid as int) as id_pedido_da_venda
            ,cast(productid as int) as id_produto
            ,cast(orderqty as int) as quantidade_do_pedido
            ,cast(unitprice as numeric) as preco_unitario
            ,cast(unitpricediscount as numeric) as desconto_preco_unitario
            -- ,specialofferid
            -- ,carriertrackingnumber
            -- ,rowguid
            -- ,modifieddate
        from {{ source('sap', 'salesorderdetail') }}
    )

select *
from source_salesorderdetail