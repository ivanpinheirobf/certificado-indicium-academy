with
    razoes_pedidos_das_vendas as (
        select *
        from {{ ref('stg_sap__razoes_pedidos_das_vendas') }}
    )
    
    ,razoes_das_vendas as (
        select *
        from {{ ref('stg_sap__razoes_das_vendas') }}
    )

    , transformacao as (
        select
            row_number() over (order by razoes_pedidos_das_vendas.id_pedido_da_venda) as sk_razoes_pedidos
            ,razoes_pedidos_das_vendas.id_pedido_da_venda
            ,razoes_das_vendas.nome_razao_da_venda
            ,razoes_das_vendas.tipo_razao_da_venda
        from razoes_pedidos_das_vendas
        left join razoes_das_vendas on razoes_pedidos_das_vendas.id_razao_da_venda = razoes_das_vendas.id_razao_da_venda
    )

select *
from transformacao