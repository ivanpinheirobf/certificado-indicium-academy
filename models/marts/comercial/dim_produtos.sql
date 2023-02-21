with
    produtos as (
        select *
        from {{ ref('stg_sap__produtos') }}
    )

    , transformacao as (
        select
            row_number() over (order by id_produto) as sk_produto
            ,id_produto
            ,nome_produto
            ,numero_produto
            ,cor_produto
            ,nivel_estoque_seguranca
            ,ponto_reabastecimento
            ,custo_padrao
            ,preco_tabelado
        from produtos
    )

select *
from transformacao