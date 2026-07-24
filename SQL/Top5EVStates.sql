# Top 5 states by EV adoption rate

WITH sum_of_vehicles AS (
    SELECT
        state,
        electric,
        electric + phev + hev + biodiesel + e85 +
        cng + propane + hydrogen + gasoline +
        diesel + unknown_fuel AS total_vehicles
    FROM vehicle_data_staging
)

SELECT
    state,
    total_vehicles,
    electric,
    ROUND(electric / total_vehicles * 100, 2) AS ev_share_pct
FROM sum_of_vehicles
ORDER BY ev_share_pct DESC
LIMIT 5;
