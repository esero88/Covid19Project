
-- Selecting all the fields in the CovidDeaths table (1)
SELECT * 
FROM Covid19Project..CovidDeaths
WHERE continent IS NOT NULL
ORDER BY 3,4;

-- Selecting all the fields in the CovidVaccinations table (2)
SELECT * 
FROM Covid19Project..CovidVaccinations
WHERE continent IS NOT NULL
ORDER BY 3,4;

-- Select data that we're going to use it from CovidDeaths table (3)
SELECT location, date, total_cases, new_cases, total_deaths, population
FROM Covid19Project..CovidDeaths
WHERE continent IS NOT NULL
ORDER BY 1,2;

-- Looking at total cases vs. total deaths

ALTER TABLE CovidDeaths 
ALTER COLUMN total_deaths FLOAT; -- Data type needs to be transform to FLOAT data type in order to execute the query below (*)

ALTER TABLE CovidDeaths
ALTER COLUMN total_cases FLOAT; -- Data type needs to be transform to FLOAT data type in order to execute the query below (*)

-- Shows likelihood of dying in Turkey (4)
SELECT location, date, total_cases, total_deaths, (total_deaths / total_cases)*100 AS death_percentage
FROM Covid19Project..CovidDeaths
WHERE location = 'Turkey' AND continent IS NOT NULL
ORDER BY 1,2;

-- Looking at the total cases vs. population

-- Shows what percentage of population got covid (5)

SELECT location, date, population, total_cases, (total_cases / population)*100 AS infect_percentage
FROM Covid19Project..CovidDeaths
WHERE location = 'Turkey' AND continent IS NOT NULL
ORDER BY 1,2;

--Looking at countries with highest infection rate compared to population (6)

SELECT location, population, MAX(total_cases) AS highest_infection_count, MAX((total_cases / population))*100 AS infect_percentage
FROM Covid19Project..CovidDeaths
WHERE continent IS NOT NULL
GROUP BY location, population
ORDER BY infect_percentage DESC;

-- Showing countries with highest death count per population (7)

SELECT location, MAX(total_deaths) AS total_death_count
FROM Covid19Project..CovidDeaths
WHERE continent IS NOT NULL
GROUP BY location
ORDER BY total_death_count DESC;

--Showing continents with highest death count per population (8)

SELECT continent, MAX(total_deaths) AS total_death_count
FROM Covid19Project..CovidDeaths
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY total_death_count DESC;

-- Global Numbers (9)

ALTER TABLE CovidDeaths -- Data type needs to be transform to FLOAT data type in order to execute the query below (*)
ALTER COLUMN new_cases FLOAT;

SELECT SUM(new_cases) AS total_cases, SUM(CAST(new_deaths AS FLOAT)) AS total_deaths, SUM(CAST(new_deaths AS FLOAT))/SUM(new_cases) * 100 AS death_percentage
FROM Covid19Project..CovidDeaths
WHERE continent IS NOT NULL
ORDER BY 1,2;

-- Looking at total population vs. vaccinations (10)

SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
SUM(CONVERT(FLOAT, vac.new_vaccinations)) OVER(PARTITION BY dea.location ORDER BY dea.location, dea.date) AS rolling_people_vaccinated
FROM Covid19Project..CovidDeaths dea
JOIN Covid19Project..CovidVaccinations vac
	ON dea.location = vac.location
	AND dea.date = vac.date
WHERE dea.continent IS NOT NULL AND dea.location = 'Turkey'
ORDER BY 2,3;

-- Use CTE (11)

WITH pop_vs_vac (continent, location, date,  population, new_vaccinations, rolling_people_vaccinated) AS
(
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
SUM(CONVERT(FLOAT, vac.new_vaccinations)) OVER(PARTITION BY dea.location ORDER BY dea.location, dea.date) AS rolling_people_vaccinated
FROM Covid19Project..CovidDeaths dea
JOIN Covid19Project..CovidVaccinations vac
	ON dea.location = vac.location
	AND dea.date = vac.date
WHERE dea.continent IS NOT NULL AND dea.location = 'Turkey'
)
SELECT *, (rolling_people_vaccinated/population)*100 AS percentage_of_vaccinated_people
FROM pop_vs_vac

-- Temp table (12)
ALTER TABLE CovidDeaths -- Data type needs to be transform to NUMERIC data type in order to execute the query below (*)
ALTER COLUMN population NUMERIC

DROP TABLE IF EXISTS #percent_population_vaccinated 
CREATE TABLE #percent_population_vaccinated 
continent nvarchar(255),
location nvarchar(255),
date datetime,
population numeric,
new_vaccinations numeric,
rolling_people_vaccinated numeric
)

INSERT INTO #percent_population_vaccinated
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
SUM(CONVERT(FLOAT, vac.new_vaccinations)) OVER(PARTITION BY dea.location ORDER BY dea.location, dea.date) AS rolling_people_vaccinated
FROM Covid19Project..CovidDeaths dea
JOIN Covid19Project..CovidVaccinations vac
	ON dea.location = vac.location
	AND dea.date = vac.date
WHERE dea.continent IS NOT NULL --AND dea.location = 'Turkey'

SELECT *, (rolling_people_vaccinated/population)*100 AS percentage_of_vaccinated_people
FROM #percent_population_vaccinated

-- Creating View (13)

CREATE VIEW percent_population_vaccinated AS
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
SUM(CONVERT(FLOAT, vac.new_vaccinations)) OVER(PARTITION BY dea.location ORDER BY dea.location, dea.date) AS rolling_people_vaccinated
FROM Covid19Project..CovidDeaths dea
JOIN Covid19Project..CovidVaccinations vac
	ON dea.location = vac.location
	AND dea.date = vac.date
WHERE dea.continent IS NOT NULL --AND dea.location = 'Turkey'

SELECT *
FROM percent_population_vaccinated


-- Stored Procedure (14)

CREATE PROCEDURE Turkey_Death
AS
SELECT location, date, total_cases, total_deaths, (total_deaths / total_cases)*100 AS death_percentage
FROM Covid19Project..CovidDeaths
WHERE location = 'Turkey' AND continent IS NOT NULL
ORDER BY location, date;

EXEC Turkey_Death

