-- Dataset: World
-- Table: world
-- Columns used: name, population, GDP, continent

-- Question 1:
-- List each country name where the population is larger than that of 'Russia'.

SELECT 
    name
FROM world
WHERE population > (
        SELECT population 
        FROM world 
        WHERE name = 'Russia'
);

-- Question 2:
-- Show the countries in Europe with a per capita GDP greater than 'United Kingdom'.

SELECT 
    name
FROM world
WHERE gdp/population > (
        SELECT gdp/population 
        FROM world 
        WHERE name = 'United Kingdom'
) 
    AND continent = 'Europe';

-- Question 3:
-- List the name and continent of countries in the continents containing either Argentina or Australia. Order by name of the country.

SELECT 
    name,
    continent
FROM world
WHERE continent IN (
        SELECT continent 
        FROM world 
        WHERE name IN ('Australia', 'Argentina')
)
ORDER BY name;

-- Question 4: 
-- Which country has a population that is more than United Kingdom but less than Germany? Show the name and the population.

SELECT 
    name,
    population
FROM world
WHERE population > (
        SELECT population 
        FROM world 
        WHERE name = 'United Kingdom'
    ) 
    AND population < (
        SELECT population 
        FROM world 
        WHERE name = 'Germany'
);

-- Question 5:
-- Show the name and the population of each country in Europe. Show the population as a percentage of the population of Germany.

SELECT 
    name,
    CONCAT(
        ROUND(
            100.0 * population / (
                SELECT population 
                FROM world
                WHERE name = 'Germany'
            )
        ),
        '%'
    ) AS percentage
FROM world
WHERE continent = 'Europe';

-- Question 6:
-- Which countries have a GDP greater than every country in Europe? Give the name only.

SELECT 
    name
FROM world
WHERE GDP > (
        SELECT MAX(GDP)
        FROM world
        WHERE continent = 'Europe'
);

-- Question 7:
-- Find the largest country (by area) in each continent, show the continent, the name and the area.

SELECT 
    continent,
    name,
    area
FROM world AS w1
WHERE area = (
    SELECT MAX(area) 
    FROM world AS w2
    WHERE w2.continent = w1.continent
);

-- Question 8:
--

SELECT 
    continent,
    name
FROM world AS w1
WHERE name = (
    SELECT MIN(name)
    FROM world AS w2
    WHERE w2.continent = w1.continent
);

-- Question 9:
-- Find the continents where all countries have a population <= 25000000. Then find the names of the countries associated with these continents. Show name, continent and population.

SELECT 
    name, 
    continent, 
    population
FROM world AS w1
WHERE 25000000 >= ALL(
    SELECT population 
    FROM world AS w2 
    WHERE w2.continent = w1.continent
);

-- Question 10:
-- Some countries have populations more than three times that of all of their neighbours (in the same continent). Give the countries and continents.

SELECT 
    name,
    continent
FROM world as w1
WHERE w1.population > ALL(
    SELECT 3 * population
    FROM world as w2
    WHERE w1.continent = w2.continent
    AND w1.name <> w2.name
);