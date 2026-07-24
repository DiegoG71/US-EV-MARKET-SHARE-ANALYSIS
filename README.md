# US-EV-MARKET-SHARE-ANALYSIS

##Project Overview

This project analyzes electriv vehicle (EV) adoption rates across the United States using vehicle regrestration data seperated by fuel type. The main objective of this project was to identify which states had the quickest/highest EV adoption rates, compare EV usage to traditional fuel vehciles, evaluate alternative fuels adoption rates, and to prvide any reccomendations for the future of EV infrastructuee investment.

This analysis was completed using SQL for sata cleaning and transformation and Power Bi for data visualization and simple dashboard development.


##Business  Problem

A transportation research group requested an analysis of alternative fuel vheicle registrations across the U.S.A. The findings will be used by policymakers and transportation planners to give them a better understanding of the EV adoption trends, and can then prioritize future infrastrucute invesments accordingly.

###Key questions included:
- What percentage of vehicles in each state are EVs, PHEVs, HEVs, and gasoline vehicles?
- Which states have the highest and lowest EV adoption rates?
- Which alternative fuels are significant versus niche?
- Where should future EV infrastrucute investments be prioritized?

##Dataset
The dataset contains vehicle regrestration counts by state for multiple fuel types including:
- Electric Vehicles (EV)
- Plug-In Hybrid Electric Vehicles (PHEV)
- Hybrid Electric Vehicles (HEV)
- Biodiesel
- Ethanol/Flex Fuel (E85)
- Compressed Natural Gas (CNG)
- Propane
- Hydrogen
- Gasoline
- Diesel
- Unknown Fuel

*The District of Columbia was included because registration data was provided in the original dataset.

##Data Cleaning (SQL)

The Following cleaning steps were performed on the data:
- Created a staging table to preserve the original dataset
- Removed commas from numeric fields
- Converted fuel count columns from text to integer data types
- Renamed columns using standardized lowercase naming conventions
- Removed Methanol column because all observations contained zero values
- Checked for duplicate state records
- Verified data consistency prior to analysis


##Analysis Performed

###Market Share Calculations
Calculated:
- Total registered vehicles by state
- EV market share
- PHEV market share
- HEV market share
- Gasoline market share

EV Adoption Rankings
Indentified:
- Top 5 states by EV adoption rate
- Bottom 5 states by EV adoption rate

Large State Comparison
Compared EV and Gasoline market share for:
- California
- Texas
- Florida
- New York

Alternative Fuel Analysis
Analyzed national market share for:
- Biodiesel
- Ethanol/Flex Fuel (E85)
- Hydrogen

##Dashboard

###The Power BI dashboard includes:
- U.S. EV adoption heat map
- Top 5 EV adoption states
- Bottom 5 EV adoption states
- California versus other large states comparison
- Alternative fuel market share visualizaiton
- KPI summary cards
- Interactive state slicer

###Key Findings
- California recorded the highest EV adoption rate at 3.41% of registered vehicles
- The average EV adoption rate across all states was 0.90%
- North Dakota and Mississippi recoreded the lowest EV adoption rates at 0.19%
- Total EV registrations exceeded 3.56 million vehicles
- e85 accounted for 87.77% of alternative fuel vehicle registrations among the alt fuels analyzed
- Biodiesel represented 12.16% and Hydrogen accounted for only 0.07% indicating limited adoption.

##Recommendations
1. The states of California, Texas, and Florida should all receive EV infrastructure investments as they all have the demand and potential to have larger increases in their EV adoption rates.
2. The states of North Dakota, Mississippi, Wyoming are not great candidates for EV infrastructure investments as the demand and adoption for EV in these states are the lowest in the country.

##Tools Used
- SQL (MYSQL)
- Power BI
- Excel (minimal usage)

##Dashboard Preview
<img width="1373" height="772" alt="image" src="https://github.com/user-attachments/assets/b6c6a168-7ab2-408e-b853-d322a5baef2f" />

