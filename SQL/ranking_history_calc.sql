-- Creating a table that adds the following attributes to the ranking value for a given year: ranking value on previous year's chart, number of places gained compared to previous year, and a boolean value if the entry is new on a given year (was not on previous year's chart)
-- I downloaded this data as a separate .csv for the chart changes analysis. 
WITH rankings_with_previous 
AS (
  SELECT ranking_year, m.imdb_id, Title, ranking,
  LAG(ranking, 1, 0) OVER (PARTITION BY m.imdb_id ORDER BY ranking_year ASC) AS previous_ranking, -- Ranking of the movie on previous year's chart (0 default value)
  (ranking - LAG(ranking, 1, 0) OVER (PARTITION BY m.imdb_id ORDER BY ranking_year ASC)) * -1 AS places_gained, -- How many places has the movie gained compared to previous year's chart (0 default value)
  LAG(ranking, 1, 0) OVER (PARTITION BY m.imdb_id ORDER BY ranking_year ASC) = 0 AS new_entry -- Boolean value that specifies if the movie is a new entry (was not present on previous year's chart)
  FROM `phrasal-brand-398306.imdb_top_250.MovieRanking` mr
  JOIN `phrasal-brand-398306.imdb_top_250.Movie` m ON m.imdb_id = mr.imdb_id
  ORDER BY 1 DESC, 4 ASC
)

SELECT ranking_year, imdb_id, Title, ranking, previous_ranking, new_entry,
CASE WHEN new_entry THEN 0 ELSE places_gained END AS places_gained
FROM rankings_with_previous
