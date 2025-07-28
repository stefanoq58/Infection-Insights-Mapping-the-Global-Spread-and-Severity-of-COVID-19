# Infection-Insights-Mapping-the-Global-Spread-and-Severity-of-COVID-19

## Overview 
The primary goal of this project was to analyze the global spread and severity of COVID-19 through data-driven insights. Using datasets from the reputable source Our World in Data (https://ourworldindata.org/covid-deaths), the project explored infection rates, mortality figures, and vaccination progress across countries and continents. The analysis focused on identifying key patterns and disparities in how the pandemic impacted different regions over time.

By examining both cumulative and time-series data—such as total cases, deaths, infection percentages, and vaccination trends I was able to extract meaningful indicators and trends. These insights were transformed into an interactive Tableau dashboard, offering a comprehensive and accessible visualization of the pandemic’s global trajectory.

---

## Objectives
- Track the global spread and impact of a disease
- Compare the severity of the pandemic across continents and countries
- Analyze the progression of infection over time in selected countries
- Identify countries/regions with high infection penetration
- Develop an interactive visual dashboard that displays key information

--- 

## Tools & Technologies
- **ourworldindata** — source where the data was extracted from (COVID Deaths and COVID Vaccinations CSV raw files)
- **Excel** - utilized for initial observation and data cleaning (correction of NULL values, and incorrect data types)
- **SQL**
   - Imported data into the SSMS database.
   - Wrote advanced SQL queries to extract, transform, and analyze COVID-19 data from global datasets:
   - Used SELECT, WHERE, and ORDER BY clauses to filter and organize key indicators such as cases, deaths, population, and vaccination counts
   - Implemented GROUP BY with aggregation functions like SUM(), MAX(), and arithmetic operations to calculate death rates and infection percentages by country, continent, and globally
   - Applied window functions (SUM(...) OVER (PARTITION BY...)) to compute rolling vaccination totals over time for each country
   - Leveraged Common Table Expressions (CTEs) for streamlined comparisons of vaccinations versus population and to enable more readable multi-step logic
   - Created and queried temporary tables to store the percent population vaccinated and simplify iterative analysis
- **Tableu**
   - Built an interactive Tableau dashboard to visualize the global impact of COVID-19 using curated SQL views and extracted datasets:
   - Designed global KPI tiles to highlight total cases, deaths, and calculated death percentage using dynamic aggregation fields
   - Created bar charts to compare total death counts across continents, leveraging categorical filtering and aggregated measures
   - Used choropleth maps to display percent population infected by country, applying color gradients to reflect infection severity geographically
   - Developed line graphs to illustrate trends in percent population infected over time across multiple countries (e.g., US, UK, Mexico), enabling cross-country comparison and time-series analysis
   - Applied filters, tooltips, and calculated fields within Tableau to enhance interactivity and enable multi-dimensional exploration of pandemic metrics

---

## Key Insights
- The United States exhibited one of the highest infection rates, with over 19% of the population affected based on cumulative case data.
- Europe and North America recorded the highest total deaths, underscoring regional disparities in pandemic outcomes.
- Several smaller nations displayed disproportionately high infection percentages relative to population size.
- The global case fatality rate remained below 3%, though it varied significantly across countries and continents.
- Rolling vaccination metrics revealed inconsistent deployment, with notable differences in vaccine coverage across regions.
- Time-series analysis highlighted multiple infection surges, particularly in countries like the U.S. and U.K., reflecting pandemic wave patterns.








