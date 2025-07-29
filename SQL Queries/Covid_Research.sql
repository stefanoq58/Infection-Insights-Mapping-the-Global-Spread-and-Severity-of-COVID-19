SELECT *
  FROM [PortfolioProject].[dbo].[CovidDeaths]
  Where continent is not null
  order by 3,4

  --SELECT *
  --FROM [PortfolioProject].[dbo].[CovidVaccinations]
  --order by 3,4

  -- Select data that we are going to be using
  Select location, date, total_cases, new_cases, total_deaths, population
  FROM [PortfolioProject].[dbo].[CovidDeaths]
  order by 1,2

  --Looking at total cases vs total deaths
  --shows likelihood of dying based on country
 Select location, date, total_cases,total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
  FROM [PortfolioProject].[dbo].[CovidDeaths]
  where location like '%states%'
  and continent is not null
  order by 1,2


  -- looking at total cases vs population
  -- shows what % of population got covid
   Select location, date, population, total_cases, (total_cases/population)*100 as CovidPercentage
  FROM [PortfolioProject].[dbo].[CovidDeaths]
  where location like '%states%'
  and continent is not null
  order by 1,2


  -- Looking at Countries with highest infection rate compared to population
    Select location, population, MAX(total_cases) as HighestInfectionCount, MAX((total_cases/population))*100 as PercentPopulationInfected
  FROM [PortfolioProject].[dbo].[CovidDeaths]
  Group by location,population
  order by PercentPopulationInfected desc

  --Lets break down by continent
  Select location, MAX(cast(total_deaths as int)) as TotalDeathCount
  FROM [PortfolioProject].[dbo].[CovidDeaths]
  Where continent is null
  Group by location
  order by TotalDeathCount desc


  -- shows countries with highest death count per population
  Select Location, MAX(cast(total_deaths as int)) as TotalDeathCount
  FROM [PortfolioProject].[dbo].[CovidDeaths]
  Where continent is not null
  Group by Location
  order by TotalDeathCount desc


  --showing continents with highest death counts
  Select continent, MAX(cast(total_deaths as int)) as TotalDeathCount
  FROM [PortfolioProject].[dbo].[CovidDeaths]
  Where continent is not null
  Group by continent
  order by TotalDeathCount desc


  --Global Numbers by date
   Select date, SUM(new_cases)as total_cases, SUM(cast(new_deaths as int))as total_deaths,SUM(cast(new_deaths as int))/SUM(new_cases)*100 as DeathPercentage
  FROM [PortfolioProject].[dbo].[CovidDeaths]
  where continent is not null
  Group by date
  order by 1,2


  --Global Numbers in general
   Select SUM(new_cases)as total_cases, SUM(cast(new_deaths as int))as total_deaths,SUM(cast(new_deaths as int))/SUM(new_cases)*100 as DeathPercentage
  FROM [PortfolioProject].[dbo].[CovidDeaths]
  where continent is not null
  order by 1,2

  --looking at total population vs vaccinations
    -- USE CTE (temporary table)
  With PopvsVac (Continent, Location, Date, Population,new_vaccinations, RollingPeopleVaccinated)
  as
  (
  SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
  ,SUM(cast(vac.new_vaccinations as bigint)) OVER (Partition by dea.Location Order by dea.Date) as RollingPeopleVaccinated
  FROM PortfolioProject..CovidDeaths dea
  JOIN PortfolioProject..CovidVaccinations vac
	ON dea.location = vac.location
	AND dea.date = vac.date
  Where dea.continent is not null
  --order by 2,3
  )
  Select *, (RollingPeopleVaccinated/Population)*100
  From PopvsVac

 
 
 --TEMP TABLE
 --IN CASE U WANT TO MODIFY TABLE DROP TABLE IF EXISTS WILL DROP AND THEN CREATE THE NEW ONE W MODS
 DROP Table if exists #PercentPopulationVaccinated
 Create Table #PercentPopulationVaccinated
 (
 Continent nvarchar(255),
 Location nvarchar(255),
 Date datetime,
 Population numeric,
 New_vaccination numeric,
 RollingPeopleVaccinated numeric
 )

 Insert into #PercentPopulationVaccinated
 SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
  ,SUM(cast(vac.new_vaccinations as bigint)) OVER (Partition by dea.Location Order by dea.Date) as RollingPeopleVaccinated
  FROM PortfolioProject..CovidDeaths dea
  JOIN PortfolioProject..CovidVaccinations vac
	ON dea.location = vac.location
	AND dea.date = vac.date
  Where dea.continent is not null
  --order by 2,3
  
  Select *, (RollingPeopleVaccinated/Population)*100
  From #PercentPopulationVaccinated


  --Creating view to store data for later visualizations

  Create View PercentPopulationVaccinated as
  SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
  ,SUM(cast(vac.new_vaccinations as bigint)) OVER (Partition by dea.Location Order by dea.Date) as RollingPeopleVaccinated
  FROM PortfolioProject..CovidDeaths dea
  JOIN PortfolioProject..CovidVaccinations vac
	ON dea.location = vac.location
	AND dea.date = vac.date
  Where dea.continent is not null
  --order by 2,3

  Select *
  From PercentPopulationVaccinated