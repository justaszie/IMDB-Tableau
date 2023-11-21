-- 1. Splitting the raw IMDB dataset into fact and dimensions - starting with Movie fact table. Also renaming some columns to make them easier to understand. 
CREATE TABLE `phrasal-brand-398306.imdb_top_250.Movie`
AS (
  SELECT DISTINCT
  TRIM(IMDBlink) as imdb_id,
  TRIM(Title) as title,
  r.Date as release_year,
  RunTime,
  Rating as imdb_rating,
  Votes as imdb_num_votes,
  Score as metascore,
  Gross as revenue
  FROM `phrasal-brand-398306.imdb_top_250.imdb_top_250_raw` r
);

-- 2. Creating a MovieRanking dimension which stores the position of a movie in the ranking on a given year.
CREATE TABLE `phrasal-brand-398306.imdb_top_250.MovieRanking`
AS (
  SELECT DISTINCT
  TRIM(IMDBlink) as imdb_id,
  IMDBYear as ranking_year,
  Ranking
  FROM `phrasal-brand-398306.imdb_top_250.imdb_top_250_raw` r
);

-- 3. Creating a MovieGenre dimension which stores all the genres that a movie is associated with.
CREATE TABLE `phrasal-brand-398306.imdb_top_250.MovieGenre` 
AS (
  SELECT DISTINCT
  TRIM(IMDBLink) AS imdb_id
  ,TRIM(genre_new) AS genre
  ,(genre_index + 1) AS genre_index -- We add index value to preserve the order in which the genres were listed, in case it is important for analysis.
  FROM `phrasal-brand-398306.imdb_top_250.imdb_top_250_raw`,
  UNNEST(SPLIT(genre, ',')) AS genre_new WITH OFFSET AS genre_index -- We split the values to create an array and unnest that array to store the genre values in rows.
);

-- 4. Creating a MovieDirector dimension which stores all the directors who worked on a movie.
CREATE TABLE `phrasal-brand-398306.imdb_top_250.MovieDirector` 
AS (
  SELECT DISTINCT
  TRIM(IMDBLink) AS imdb_id
  ,TRIM(director_new) AS director
  ,(dir_index + 1) AS director_index
  FROM `phrasal-brand-398306.imdb_top_250.imdb_top_250_raw`,
  UNNEST(REGEXP_EXTRACT_ALL(director, r'([^,]+)')) AS director_new WITH OFFSET AS dir_index -- Practicing REGEXP instead of SPLIT as it's supposed to have better performance
);

-- 5. Creating a MovieCast dimension which stores up to 4 main actors casted for a movie.
CREATE TABLE `phrasal-brand-398306.imdb_top_250.MovieCast` 
AS (
  SELECT DISTINCT
  TRIM(IMDBLink) AS imdb_id
  ,TRIM(cast_member) as cast_member
  ,CAST(REPLACE(cast_index,'cast','') AS INT) as cast_index -- We add index value to preserve the order in which the actors were listed, in case it is important for analysis.
  FROM `phrasal-brand-398306.imdb_top_250.imdb_top_250_raw`
  UNPIVOT(cast_member FOR cast_index IN (cast1, cast2, cast3, cast4)) -- Using UNPIVOT function to transform the actor values from 4 different columns into a row for each actor.
);

-- 6.1 Updating Movie fact table with data from TMDB raw dataset.
UPDATE `phrasal-brand-398306.imdb_top_250.Movie` m
SET is_adult = t.adult,
tagline = t.tagline,
tmdb_score = t.vote_average,
tmdb_votes_count = CAST(t.vote_count as INTEGER),
tmdb_popularity = t.popularity,
original_language = t.original_language,
budget = t.budget,
revenue = t.revenue  --TMDB data source has the correct value here. IMDB dataset only had domestic BO Revenue number.
FROM `phrasal-brand-398306.imdb_top_250.tmdb_details_raw` t
WHERE m.imdb_id = CONCAT('/title/', t.imdb_id, '/'); -- Unifying the format of the IMDB ID between the 2 datasets.

-- 6.2 Updating budget and revenue data to make it clear that 0 means budget is not available and not that a movie generated 0 revenue.
UPDATE `phrasal-brand-398306.imdb_top_250.Movie`
SET revenue = null
WHERE revenue = 0;

UPDATE `phrasal-brand-398306.imdb_top_250.Movie`
SET budget = null
WHERE budget = 0;

-- 7. Create a MovieProductionCompany dimension which stores the id and the name of the companies that produced a movie. Using convenient BigQuery JSON function to deal with columns that contain JSON string values.
CREATE TABLE `phrasal-brand-398306.imdb_top_250.MovieProductionCompany` 
AS (
  SELECT CONCAT('/title/', imdb_id, '/') as imdb_id,
  JSON_EXTRACT_SCALAR(company_row, '$.id') as company_id,
  JSON_EXTRACT_SCALAR(company_row, '$.name') as company_name
  FROM `phrasal-brand-398306.imdb_top_250.tmdb_details_raw`,
  UNNEST(JSON_EXTRACT_ARRAY(REPLACE(production_companies, 'None', 'null'),'$')) as company_row -- Note when TMDB data was stored in csv using pandas, None was used to represent null values in the columns containing json string. We have to replace it to null so that BigQuery JSON function can parse it properly.
);

-- 8. Create a MovieProductionCountry dimension which stores the country code and name of the countries where the movie was produced (the values are based on where the production companies were registered).
CREATE TABLE `phrasal-brand-398306.imdb_top_250.MovieProductionCountry` 
AS (
  SELECT CONCAT('/title/', imdb_id, '/') as imdb_id,
  JSON_EXTRACT_SCALAR(country_row, '$.iso_3166_1') as country_code,
  JSON_EXTRACT_SCALAR(country_row, '$.name') as country_name
  FROM `phrasal-brand-398306.imdb_top_250.tmdb_details_raw`,
  UNNEST(JSON_EXTRACT_ARRAY(REPLACE(production_countries, 'None', 'null'),'$')) as country_row
);

-- 9  Updating the movies where the same title was used for different movies (released in different years)
SELECT Title, COUNT(*) 
FROM `phrasal-brand-398306.imdb_top_250.Movie`
GROUP BY 1
ORDER BY 2 DESC;

UPDATE `phrasal-brand-398306.imdb_top_250.Movie`
SET Title = CONCAT(Title, ' (', release_year, ')')
WHERE Title IN ('Beauty and the Beast', 'Drishyam');
