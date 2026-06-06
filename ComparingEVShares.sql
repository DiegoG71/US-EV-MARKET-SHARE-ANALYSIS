#Comparing EV Shares between Ca;ifornia and other "big" states

WITH sum_of_vehicles AS (
    SELECT
        state,
        electric,
        phev,
        hev,
        gasoline,
        diesel,
        electric + phev + hev + biodiesel + e85 +
        cng + propane + hydrogen + gasoline +
        diesel + unknown_fuel AS total_vehicles

    FROM vehicle_data_staging
)

SELECT
	state,
	total_vehicles,
	electric,
    phev,
    gasoline,
    diesel,
	ROUND(electric / total_vehicles * 100, 2) AS ev_share_pct,
    ROUND(phev / total_vehicles * 100, 2) AS phev_share_pct,
    ROUND(hev / total_vehicles * 100, 2) AS hev_share_pct,
    ROUND(gasoline / total_vehicles * 100, 2) AS gasoline_share_pct
FROM sum_of_vehicles

WHERE state IN (
	'California',
	'Texas',
    'Florida',
    'New York'
)

ORDER BY ev_share_pct DESC;