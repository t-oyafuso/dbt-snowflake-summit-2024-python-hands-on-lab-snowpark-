with results as (

  select * from {{ ref('fct_results') }}

),

races as ( 

  select * from {{ ref('dim_races') }}

),

drivers as (

  select * from {{ ref('dim_drivers') }}

), 

constructors as (

  select * from {{ ref('dim_constructors') }}
  
), 

status as (

  select * from {{ ref('dim_status') }}
  
), 

int_results as (
    select 
      result_id,
      results.race_id,
      results.race_year as race_year, 
      results.race_round as race_round,
      results.circuit_id as circuit_id,
      race_name,
      results.race_date as race_date,
      results.race_time, 
      results.driver_id,
      results.driver_number,
      forename ||' '|| surname as driver, 
      cast(datediff('year', date_of_birth, results.race_date) as int) as drivers_age_years, 
      drivers.driver_nationality as driver_nationality,
      results.constructor_id,
      constructors.constructor_name as constructor_name,
      constructors.constructor_nationality as constructor_nationality, 
      grid, 
      results.position as driver_position,
      position_text,
      position_order,
      points,
      laps,
      RESULTS_MILLISECONDS as milliseconds,
      fastest_lap,
      RESULTS_RANK as driver_rank,
      FASTEST_LAP_TIME_FORMATTED as fastest_lap_time,
      fastest_lap_speed, 
      results.status_id,
      results.status,
      case when driver_position is null then 1 else 0 end as dnf_flag
    from results
    left join races
      on results.race_id=races.race_id
    left join drivers 
      on results.driver_id = drivers.driver_id
    left join constructors 
      on results.constructor_id = constructors.constructor_id
    left join status
      on results.status_id = status.status_id
 )

 select * from int_results 
