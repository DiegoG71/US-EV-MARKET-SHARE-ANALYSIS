#---------------------------------------------------------------------------------------------------------------------------
# STEP 1: DATA CLEANING PROCESS
#---------------------------------------------------------------------------------------------------------------------------


CREATE TABLE
 `vehicle_data_staging` LIKE `vehicle data`;
INSERT vehicle_data_staging SELECT * FROM `vehicle data`;

Select 
State,
REPLACE(`Electric (EV)`, ',','') as Electric_EV,
REPLACE(`Plug-In Hybrid Electric (PHEV)`, ',','') as Plug_In_Hybrid_Electric_PHEV,
REPLACE(`Hybrid Electric (HEV)`, ',','') as Hybrid_Electric_HEV,
REPLACE(Biodiesel, ',','') as Biodiesel,
REPLACE(`Ethanol/Flex (E85)`, ',','') as Ethanol_Flex__E85,
REPLACE(`Compressed Natural Gas (CNG)`, ',','') as Compressed_Natural_Gas_CNG, 
REPLACE(Propane, ',','') as Propane, 
REPLACE(Hydrogen, ',','') as Hydrogen, 
REPLACE(Gasoline, ',','') as Gasoline,
REPLACE(Diesel, ',','') as Diesel,
REPLACE(`Unknown Fuel`, ',','') as Unknown_Fuel
FROM vehicle_data_staging;


# DROP methanol from table, as it contains 0 for all values and doesn't contribute to this analysis
ALTER TABLE vehicle_data_staging 
DROP COLUMN Methanol;
 
 
# Removes and replaces commas with blanks for standardization and formatting
UPDATE vehicle_data_staging
SET 
`Electric (EV)`= REPLACE(`Electric (EV)`, ',',''),
`Plug-In Hybrid Electric (PHEV)` = REPLACE(`Plug-In Hybrid Electric (PHEV)`, ',',''),
`Hybrid Electric (HEV)` = REPLACE(`Hybrid Electric (HEV)`, ',',''),
Biodiesel = REPLACE(Biodiesel, ',',''),
`Ethanol/Flex (E85)` = REPLACE(`Ethanol/Flex (E85)`, ',',''),
`Compressed Natural Gas (CNG)` = REPLACE(`Compressed Natural Gas (CNG)`, ',',''), 
Propane = REPLACE(Propane, ',',''),
Hydrogen = REPLACE(Hydrogen, ',',''),
Gasoline = REPLACE(Gasoline, ',',''),
Diesel = REPLACE(Diesel, ',',''),
`Unknown Fuel` = REPLACE(`Unknown Fuel`, ',','')
;

# Alters the table to change columns with numeric data to INT instead of a "text"
ALTER TABLE vehicle_data_staging
MODIFY COLUMN `Electric (EV)` INT,
MODIFY COLUMN `Plug-In Hybrid Electric (PHEV)` INT,
MODIFY COLUMN `Hybrid Electric (HEV)` INT,
MODIFY COLUMN Biodiesel INT,
MODIFY COLUMN `Ethanol/Flex (E85)` INT,
MODIFY COLUMN `Compressed Natural Gas (CNG)` INT,
MODIFY COLUMN Propane INT,
MODIFY COLUMN Hydrogen INT,
MODIFY COLUMN Gasoline INT,
MODIFY COLUMN Diesel INT,
MODIFY COLUMN `Unknown Fuel` INT;


# Changes the columns names to make it easier to refer to
ALTER TABLE vehicle_data_staging

RENAME COLUMN `Electric (EV)` TO electric,
RENAME COLUMN `Plug-In Hybrid Electric (PHEV)` TO phev,
RENAME COLUMN `Hybrid Electric (HEV)` TO hev,
RENAME COLUMN Biodiesel TO biodiesel,
RENAME COLUMN `Ethanol/Flex (E85)` TO e85,
RENAME COLUMN `Compressed Natural Gas (CNG)` TO cng,
RENAME COLUMN Propane TO propane,
RENAME COLUMN Hydrogen TO hydrogen,
RENAME COLUMN Gasoline TO gasoline,
RENAME COLUMN Diesel TO diesel,
RENAME COLUMN `Unknown Fuel` TO unknown_fuel,
RENAME COLUMN State TO state;


# Checks for duplicate values
SELECT State, COUNT(*)
FROM vehicle_data_staging
GROUP BY State
HAVING COUNT(*) > 1;


SELECT *
FROM vehicle_data_staging;



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

#---------------------------------------------------------------------------------------------------------------------------
# STEP 3: Top 5 states by EV adoption rate
#---------------------------------------------------------------------------------------------------------------------------

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


#---------------------------------------------------------------------------------------------------------------------------
# STEP 4: Comparing EV Shares between Ca;ifornia and other "big" states
#---------------------------------------------------------------------------------------------------------------------------

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

#---------------------------------------------------------------------------------------------------------------------------
# Step 5: Alternative fuel market share analysis
#---------------------------------------------------------------------------------------------------------------------------

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

#---------------------------------------------------------------------------------------------------------------------------
# Step 6: Infrastructure investment analysis
#---------------------------------------------------------------------------------------------------------------------------


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
