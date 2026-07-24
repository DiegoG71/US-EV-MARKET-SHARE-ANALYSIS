#---------------------------------------------------------------------------------------------------------------------------
#STEP 2: Calculations for total number of vehicles and percentage shares per state
#---------------------------------------------------------------------------------------------------------------------------

WITH sum_of_vehicles AS(
SELECT
    state,
    electric,
    phev,
    hev,
    gasoline,
    diesel,
    electric +
    phev +
    hev +
    biodiesel +
    e85 +
    cng +
    propane +
    hydrogen +
    gasoline +
    diesel +
    unknown_fuel AS total_vehicles
FROM vehicle_data_staging
)

SELECT
    state,
	total_vehicles,
    electric,
	ROUND(electric / total_vehicles * 100, 2) AS ev_share_pct,
    phev,
    ROUND(phev / total_vehicles * 100, 2) AS phev_share_pct,
    hev,
    ROUND(hev / total_vehicles * 100, 2) AS hev_share_pct,
    gasoline,
    ROUND(gasoline / total_vehicles * 100, 2) AS gasoline_share_pct,
    diesel,
    ROUND(diesel / total_vehicles * 100, 2) AS diesel_share_pct
FROM sum_of_vehicles;
