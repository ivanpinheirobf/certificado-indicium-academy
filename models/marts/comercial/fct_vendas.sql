with
    clientes as (
        select *
        from {{ ref('dim_clientes') }}
    )

    ,produtos as (
        select *
        from {{ ref('dim_produtos') }}
    )

    ,enderecos as (
        select *
        from {{ ref('dim_enderecos') }}
    )

    ,territorios as (
        select *
        from {{ ref('int_vendas__territorios') }}
    )

    ,pedidos_das_vendas as (
        select *
        from {{ ref('int_vendas__pedidos_das_vendas') }}
    )

    ,juncao as (
        select
            id_detalhe_pedido_da_venda
            ,id_pedido_da_venda
            ,clientes.sk_cliente as fk_cliente
            ,produtos.sk_produto as fk_produto
            ,enderecos.sk_endereco as fk_endereco
            
            ,territorios.nome_territorio
            ,territorios.codigo_pais
            ,territorios.nome_pais
            
            ,pedidos_das_vendas.data_do_pedido
            ,pedidos_das_vendas.tipo_do_cartao_de_credito
            ,pedidos_das_vendas.status_do_pedido
            ,pedidos_das_vendas.subtotal_do_pedido
            ,pedidos_das_vendas.imposto_do_pedido
            ,pedidos_das_vendas.frete_do_pedido
            ,pedidos_das_vendas.total_devido_do_pedido
            ,pedidos_das_vendas.quantidade_do_pedido
            ,pedidos_das_vendas.preco_unitario
            ,pedidos_das_vendas.desconto_preco_unitario
        from pedidos_das_vendas
        left join clientes on pedidos_das_vendas.id_cliente = clientes.id_cliente
        left join produtos on pedidos_das_vendas.id_produto = produtos.id_produto
        left join enderecos on pedidos_das_vendas.id_endereco_cobranca = enderecos.id_endereco
        left join territorios on pedidos_das_vendas.id_territorio = territorios.id_territorio
    )

    ,transformacao as (
        select
            {{ dbt_utils.generate_surrogate_key(['id_detalhe_pedido_da_venda','id_pedido_da_venda']) }} as sk_venda
            ,*
            ,preco_unitario * quantidade_do_pedido as total_bruto_do_item_pedido
            ,(1 - desconto_preco_unitario) * preco_unitario * quantidade_do_pedido as total_liquido_do_item_pedido
        from juncao
    )

select *
from transformacao