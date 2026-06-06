WITH alt_fuel_totals AS (
    SELECT
        SUM(biodiesel) AS total_biodiesel,
        SUM(e85) AS total_e85,
        SUM(hydrogen) AS total_hydrogen
    FROM vehicle_data_staging
)

SELECT
    'Biodiesel' AS fuel_type,
    total_biodiesel AS total,
    ROUND(
        total_biodiesel /
        (total_biodiesel + total_e85 + total_hydrogen) * 100,
        2
    ) AS share_pct
FROM alt_fuel_totals

UNION ALL

SELECT
    'E85',
    total_e85,
    ROUND(
        total_e85 /
        (total_biodiesel + total_e85 + total_hydrogen) * 100,
        2
    )
FROM alt_fuel_totals

UNION ALL

SELECT
    'Hydrogen',
    total_hydrogen,
    ROUND(
        total_hydrogen /
        (total_biodiesel + total_e85 + total_hydrogen) * 100,
        2
    )
FROM alt_fuel_totals;