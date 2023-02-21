with
    territorios as (
        select *
        from {{ ref('stg_sap__territorios') }}
    )

    ,paises as (
        select *
        from {{ ref('stg_sap__paises') }}
    )

    ,juncao as (
        select
            territorios.id_territorio
            ,territorios.nome_territorio
            ,territorios.codigo_pais
            ,paises.nome_pais
        from territorios
        left join paises on territorios.codigo_pais = paises.codigo_pais
    )

select *
from juncao