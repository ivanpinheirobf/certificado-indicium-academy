with
    source_salesorderheader as (
        select 
            cast(salesorderid as int) as id_pedido_da_venda
            ,cast(customerid as int) as id_cliente
            ,cast(salespersonid as int) as id_vendedor
            ,cast(territoryid as int) as id_territorio
            ,cast(billtoaddressid as int) as id_endereco_cobranca
            ,cast(shiptoaddressid as int) as id_endereco_envio
            ,cast(creditcardid as int) as id_cartao_de_credito
            ,cast(orderdate as string) as data_do_pedido
            ,cast(duedate as string) as data_de_vencimento
            ,cast(shipdate as string) as data_de_envio
            ,cast(status as int) as status_do_pedido
            ,cast(subtotal as numeric) as subtotal_do_pedido
            ,cast(taxamt as numeric) as imposto_do_pedido
            ,cast(freight as numeric) as frete_do_pedido
            ,cast(totaldue as numeric) as total_devido_do_pedido
            -- ,revisionnumber
            -- ,onlineorderflag
            -- ,purchaseordernumber
            -- ,accountnumber
            -- ,shipmethodid
            -- ,creditcardapprovalcode
            -- ,currencyrateid
            -- ,comment
            -- ,rowguid
            -- ,modifieddate
        from {{ source('sap', 'salesorderheader') }}
    )

select *
from source_salesorderheader