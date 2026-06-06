# Step 5: Alternative fuel market share analysis

WITH alt_fuel_totals AS (
    SELECT
        SUM(biodiesel) AS total_biodiesel,
        SUM(e85) AS total_e85,
        SUM(hydrogen) AS total_hydrogen,
        SUM(electric + phev + hev + biodiesel + e85 +
            cng + propane + hydrogen + gasoline +
            diesel + unknown_fuel) AS total_vehicles
    FROM vehicle_data_staging
)

SELECT
    total_vehicles,

    total_biodiesel,
    ROUND(total_biodiesel / (total_biodiesel + total_e85 + total_hydrogen) * 100, 2) AS biodiesel_share_pct,

    total_e85,
    ROUND(total_e85 / (total_biodiesel + total_e85 + total_hydrogen) * 100, 2) AS e85_share_pct,

    total_hydrogen,
    ROUND(total_hydrogen / (total_biodiesel + total_e85 + total_hydrogen) * 100, 2) AS hydrogen_share_pct

FROM alt_fuel_totals;