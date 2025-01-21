select *
from {{ source("library", "loans") }}
where
    loan_id is not null
    and book_id is not null
    and member_id is not null
    and book_id in (select book_id from {{ ref("stg_books") }})
    and member_id in (select member_id from {{ ref("stg_members") }})
