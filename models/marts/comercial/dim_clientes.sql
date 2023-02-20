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
        from {{ ref('stg_sap__territorios') }}
    )

    ,paises as (
        select *
        from {{ ref('stg_sap__paises') }}
    )

    ,joined_pessoas as (
        select 
            contatos_entidades_do_negocio.id_pessoa
            ,pessoas.nome_completo
        from contatos_entidades_do_negocio
        left join pessoas on contatos_entidades_do_negocio.id_entidade_do_negocio = pessoas.id_entidade_do_negocio
    )

    ,joined_territorios as (
        select
            territorios.id_territorio
            ,territorios.nome_territorio
            ,territorios.codigo_pais
            ,paises.nome_pais
        from territorios
        left join paises on territorios.codigo_pais = paises.codigo_pais
    )

    , transformacao as (
        select
            row_number() over (order by clientes.id_cliente) as sk_cliente
            ,joined_pessoas.nome_completo
            ,joined_territorios.nome_territorio
            ,joined_territorios.codigo_pais
            ,joined_territorios.nome_pais
        from clientes
        left join joined_pessoas on clientes.id_pessoa = joined_pessoas.id_pessoa
        left join joined_territorios on clientes.id_territorio = joined_territorios.id_territorio
    )

select *
from transformacao