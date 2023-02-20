with
    pedidos as (
        select
            id_pedido_da_venda
            ,id_cliente
            ,id_vendedor
            ,id_territorio
            ,id_endereco_cobranca
            ,id_endereco_envio
            ,id_cartao_de_credito
            ,data_do_pedido
            ,data_de_vencimento
            ,data_de_envio
            ,status_do_pedido
            ,subtotal_do_pedido
            ,imposto_do_pedido
            ,frete_do_pedido
            ,total_devido_do_pedido
        from {{ ref('stg_sap__pedidos_das_vendas') }}
    )

    ,detalhes_pedidos as (
        select
           id_detalhe_pedido_da_venda
           ,id_pedido_da_venda
           ,id_produto
           ,quantidade_do_pedido
           ,preco_unitario
           ,desconto_preco_unitario
        from {{ ref('stg_sap__detalhes_pedidos_das_vendas') }}
    )

    ,juncao as (
        select
            detalhes_pedidos.id_detalhe_pedido_da_venda
            ,detalhes_pedidos.id_pedido_da_venda
            ,pedidos.id_cliente
            ,pedidos.id_vendedor
            ,pedidos.id_territorio
            ,pedidos.id_endereco_cobranca
            ,pedidos.id_endereco_envio
            ,pedidos.id_cartao_de_credito
            ,detalhes_pedidos.id_produto
            
            ,pedidos.data_do_pedido
            
            ,pedidos.status_do_pedido
            ,pedidos.subtotal_do_pedido
            ,pedidos.imposto_do_pedido
            ,pedidos.frete_do_pedido
            ,pedidos.total_devido_do_pedido
            ,detalhes_pedidos.quantidade_do_pedido
            ,detalhes_pedidos.preco_unitario
            ,detalhes_pedidos.desconto_preco_unitario
        from detalhes_pedidos
        left join pedidos on detalhes_pedidos.id_pedido_da_venda = pedidos.id_pedido_da_venda
    )

select *
from juncao