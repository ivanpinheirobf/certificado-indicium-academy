with
    clientes as (
        select *
        from {{ ref('stg_sap__clientes') }}
    )

    ,pessoas as (
        select *
        from {{ ref('stg_sap__pessoas') }}
    )

    ,territorios as (
        select *
        from {{ ref('int_vendas__territorios') }}
    )

    , transformacao as (
        select
            row_number() over (order by clientes.id_cliente) as sk_cliente
            ,clientes.id_cliente
            ,pessoas.nome_completo
            ,territorios.nome_territorio
            ,territorios.codigo_pais
            ,territorios.nome_pais
        from clientes
        left join pessoas on clientes.id_pessoa = pessoas.id_entidade_do_negocio
        left join territorios on clientes.id_territorio = territorios.id_territorio
    )

select *
from transformacao