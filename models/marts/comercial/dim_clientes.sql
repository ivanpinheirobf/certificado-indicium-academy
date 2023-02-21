with
    clientes as (
        select *
        from {{ ref('stg_sap__clientes') }}
    )

    ,pessoas as (
        select *
        from {{ ref('stg_sap__pessoas') }}
    )

    ,contatos_entidades_do_negocio as (
        select *
        from {{ ref('stg_sap__contatos_das_entidades_do_negocio') }}
    )

    ,territorios as (
        select *
        from {{ ref('int_vendas__territorios') }}
    )

    ,juncao_pessoas as (
        select 
            contatos_entidades_do_negocio.id_pessoa
            ,pessoas.nome_completo
        from contatos_entidades_do_negocio
        left join pessoas on contatos_entidades_do_negocio.id_entidade_do_negocio = pessoas.id_entidade_do_negocio
    )

    , transformacao as (
        select
            row_number() over (order by clientes.id_cliente) as sk_cliente
            ,clientes.id_cliente
            ,juncao_pessoas.nome_completo
            ,territorios.nome_territorio
            ,territorios.codigo_pais
            ,territorios.nome_pais
        from clientes
        left join juncao_pessoas on clientes.id_pessoa = juncao_pessoas.id_pessoa
        left join territorios on clientes.id_territorio = territorios.id_territorio
    )

select *
from transformacao