{{ config(materialized='view') }}

select
    cast(dispatching_base_num AS STRING) as dispatching_base_num,
    cast(pickup_datetime as timestamp) as pickup_datetime,
    cast(dropOff_datetime as timestamp) as dropOff_datetime,
    cast(PUlocationID as INTEGER) as PUlocationID,
    cast(DOlocationID as INTEGER) as DOlocationID,
    cast(SR_Flag AS STRING) as SR_Flag,
    cast(Affiliated_base_number AS STRING) as Affiliated_base_number
from {{ source('staging','fhv_tripdata') }}

{% if var('is_test_run', default=true) %}

  limit 100

{% endif %}