with

source  as (

    select * from {{ source('formula1','constructors') }}

),

renamed as (
    select
        constructor_id as constructor_id,
        constructor_ref as constructor_ref,
        name as constructor_name,
        nationality as constructor_nationality
        -- omit the url
    from source
)

select * from renamed