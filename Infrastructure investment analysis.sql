# Step 6: Infrastructure investment analysis

WITH vehicle_totals AS (
    SELECT
        state,
        electric,
        gasoline,
        electric + phev + hev + biodiesel + e85 +
        cng + propane + hydrogen + gasoline +
        diesel + unknown_fuel AS total_vehicles
    FROM vehicle_data_staging
)

SELECT
    state,
    total_vehicles,
    electric,
    gasoline,
    ROUND(electric / total_vehicles * 100, 2) AS ev_share_pct,
    ROUND(gasoline / total_vehicles * 100, 2) AS gasoline_share_pct
FROM vehicle_totals

ORDER BY
    electric DESC;