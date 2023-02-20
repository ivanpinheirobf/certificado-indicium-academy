with
    source_customer as (
        select 
            cast(customerid as int) as id_cliente
            ,cast(personid as int) as id_pessoa
            ,cast(territoryid as int) as id_territorio
            -- ,storeid
            -- ,rowguid
            -- ,modifieddate
        from {{ source('sap', 'customer') }}
    )

select *
from source_customer