with
    pedidos as (
        select *
        from {{ ref('stg_sap__pedidos_das_vendas') }}
    )

    ,detalhes_pedidos as (
        select *
        from {{ ref('stg_sap__detalhes_pedidos_das_vendas') }}
    )

    ,cartoes_de_credito as (
        select *
        from {{ ref('stg_sap__cartoes_de_credito') }}
    )

    ,juncao_pedidos_cartoes_de_credito as (
        select
            pedidos.id_pedido_da_venda
            ,pedidos.id_cliente
            ,pedidos.id_vendedor
            ,pedidos.id_territorio
            ,pedidos.id_endereco_cobranca
            ,pedidos.id_endereco_envio
            ,cartoes_de_credito.tipo_do_cartao_de_credito
            ,pedidos.data_do_pedido
            ,pedidos.data_de_vencimento
            ,pedidos.data_de_envio
            ,pedidos.status_do_pedido
            ,pedidos.subtotal_do_pedido
            ,pedidos.imposto_do_pedido
            ,pedidos.frete_do_pedido
            ,pedidos.total_devido_do_pedido
        from pedidos
        left join cartoes_de_credito on pedidos.id_cartao_de_credito = cartoes_de_credito.id_cartao_de_credito
    )


    ,juncao as (
        select
            detalhes_pedidos.id_detalhe_pedido_da_venda
            ,detalhes_pedidos.id_pedido_da_venda
            ,detalhes_pedidos.id_produto
            ,juncao_pedidos_cartoes_de_credito.id_cliente
            ,juncao_pedidos_cartoes_de_credito.id_vendedor
            ,juncao_pedidos_cartoes_de_credito.id_territorio
            ,juncao_pedidos_cartoes_de_credito.id_endereco_cobranca
            ,juncao_pedidos_cartoes_de_credito.id_endereco_envio
            
            ,juncao_pedidos_cartoes_de_credito.data_do_pedido
            
            ,juncao_pedidos_cartoes_de_credito.tipo_do_cartao_de_credito
            ,juncao_pedidos_cartoes_de_credito.status_do_pedido
            ,juncao_pedidos_cartoes_de_credito.subtotal_do_pedido
            ,juncao_pedidos_cartoes_de_credito.imposto_do_pedido
            ,juncao_pedidos_cartoes_de_credito.frete_do_pedido
            ,juncao_pedidos_cartoes_de_credito.total_devido_do_pedido
            ,detalhes_pedidos.quantidade_do_pedido
            ,detalhes_pedidos.preco_unitario
            ,detalhes_pedidos.desconto_preco_unitario
        from detalhes_pedidos
        left join juncao_pedidos_cartoes_de_credito on detalhes_pedidos.id_pedido_da_venda = juncao_pedidos_cartoes_de_credito.id_pedido_da_venda
        
    )

select *
from juncao