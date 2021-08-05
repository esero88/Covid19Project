SELECT * 
FROM Covid19Project..CovidDeaths
WHERE continent IS NOT NULL
ORDER BY 3,4;

SELECT * 
FROM Covid19Project..CovidVaccinations
WHERE continent IS NOT NULL
ORDER BY 3,4;

-- Select data that we're going to use it
SELECT location, date, total_cases, new_cases, total_deaths, population
FROM Covid19Project..CovidDeaths
WHERE continent IS NOT NULL
ORDER BY 1,2;

-- Looking at total cases vs. total deaths

ALTER TABLE CovidDeaths
ALTER COLUMN total_deaths FLOAT; -- It needs to be transform to FLOAT data type in order to execute the query below

ALTER TABLE CovidDeaths
ALTER COLUMN total_cases FLOAT; -- It needs to be transform to FLOAT data type in order to execute the query below

-- Shows likelihood of dying if you contract in your country
SELECT location, date, total_cases, total_deaths, (total_deaths / total_cases)*100 AS death_percentage
FROM Covid19Project..CovidDeaths
WHERE location = 'Turkey' AND continent IS NOT NULL
ORDER BY 1,2;

-- Looking at the total cases vs. population
-- Shows what percentage of population got covid

SELECT location, date, population, total_cases, (total_cases / population)*100 AS infect_percentage
FROM Covid19Project..CovidDeaths
WHERE location = 'Turkey' AND continent IS NOT NULL
ORDER BY 1,2;

--Looking at countries with highest infection rate compared to population

SELECT location, population, MAX(total_cases) AS highest_infection_count, MAX((total_cases / population))*100 AS infect_percentage
FROM Covid19Project..CovidDeaths
WHERE continent IS NOT NULL
GROUP BY location, population
ORDER BY infect_percentage DESC;

-- Showing countries with highest death count per population

SELECT location, MAX(total_deaths) AS total_death_count
FROM Covid19Project..CovidDeaths
WHERE continent IS NOT NULL
GROUP BY location
ORDER BY total_death_count DESC;

-- let's break things down by continent


--Showing continents with highest death count per population

SELECT continent, MAX(total_deaths) AS total_death_count
FROM Covid19Project..CovidDeaths
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY total_death_count DESC;

-- Global Numbers

ALTER TABLE CovidDeaths
ALTER COLUMN new_cases FLOAT;

SELECT SUM(new_cases) AS total_cases, SUM(CAST(new_deaths AS FLOAT)) AS total_deaths, SUM(CAST(new_deaths AS FLOAT))/SUM(new_cases) * 100 AS death_percentage
FROM Covid19Project..CovidDeaths
WHERE continent IS NOT NULL
ORDER BY 1,2;

-- Looking at total population vs. vaccinations

SELECT * 
FROM Covid19Project..CovidDeaths dea
JOIN Covid19Project..CovidVaccinations vac
	ON dea.location = vac.location
	AND dea.date = vac.date 