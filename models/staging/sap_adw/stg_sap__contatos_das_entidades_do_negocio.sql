with
    source_businessentitycontact as (
        select 
            cast(businessentityid as int) as id_entidade_do_negocio
            ,cast(personid as int) as id_pessoa
            -- ,contacttypeid
            -- ,rowguid
            -- ,modifieddate
        from {{ source('sap', 'businessentitycontact') }}
    )

select *
from source_businessentitycontact