{{ config(materialized='table') }}

with fhv_trips as (
    select *
    from {{ ref('stg_fhv_tripdata') }}
)
, dim_zones as (
    select * 
    from {{ ref('dim_zones') }}
    where borough != "Unknown"
)

select
    dispatching_base_num,
    pickup_datetime,
    dropOff_datetime,
    PUlocationID,
    DOlocationID,
    SR_Flag,
    Affiliated_base_number,
    d1.zone as pickup_zone,
    d1.borough as pickup_borough,
    d2.zone as dropoff_zone,
    d2.borough as dropoff_borough
from fhv_trips
INNER JOIN dim_zones d1
on d1.locationid = fhv_trips.PUlocationID
INNER JOIN dim_zones d2
on d2.locationid = fhv_trips.DOlocationID