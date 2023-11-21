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
)

-- 2. Creating a Ranking dimension which stores the position of the movie in the ranking on a given year.
CREATE TABLE `phrasal-brand-398306.imdb_top_250.MovieRanking`
AS (
  SELECT DISTINCT
  TRIM(IMDBlink) as imdb_id,
  IMDBYear as ranking_year,
  Ranking
  FROM `phrasal-brand-398306.imdb_top_250.imdb_top_250_raw` r
)


