with
    source_creditcard as (
        select 
            cast(creditcardid as int) as id_cartao_de_credito
            ,cast(cardtype as string) as tipo_do_cartao_de_credito
            -- ,cast(cardnumber)
            -- ,cast(expmonth)
            -- ,cast(expyear)
            -- ,cast(modifieddate)
        from {{ source('sap', 'creditcard') }}
    )

select *
from source_creditcard