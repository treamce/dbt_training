select 
     book_id
    ,location
    ,book_name
    ,'Fact' as genre
from {{ source("library", "books_factual") }}
    where book_id is not null
union
select 
     book_id
    ,location
    ,book_name
    ,'Fiction' as genre
from {{ source("library", "books_fictional") }}
where book_id is not null
