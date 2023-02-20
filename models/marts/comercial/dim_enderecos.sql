with
    enderecos as (
        select *
        from {{ ref('stg_sap__enderecos') }}
    )

    ,territorios as (
        select *
        from {{ ref('int_vendas__territorios') }}
    )

    ,estados as (
        select *
        from {{ ref('stg_sap__estados') }}
    )

    ,juncao_estados_territorios as (
        select 
            estados.id_estado
            ,estados.codigo_estado
            ,estados.codigo_pais
            ,estados.nome_estado
            ,territorios.nome_territorio
            ,territorios.nome_pais
        from estados
        left join territorios on estados.id_territorio = territorios.id_territorio
    )

    , transformacao as (
        select
            row_number() over (order by enderecos.id_endereco) as sk_endereco
            ,enderecos.id_endereco
            ,enderecos.cidade
            
            ,juncao_estados_territorios.codigo_estado
            ,juncao_estados_territorios.codigo_pais
            ,juncao_estados_territorios.nome_estado
            ,juncao_estados_territorios.nome_territorio
            ,juncao_estados_territorios.nome_pais
        from enderecos
        left join juncao_estados_territorios on enderecos.id_estado = juncao_estados_territorios.id_estado
    )

select *
from transformacao