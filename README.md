![imdb_logo](https://github.com/justaszie/IMDB-Tableau/assets/1820805/ebada95a-2e11-4ae2-a5fd-df51691b6359)

# Analyzing IMDB Top 250 Movies using Tableau
## 1. Project Summary 

The goal of this project was to practice using **Tableau** for exploratory analysis and visualizations. I did this analysis using the data about movies featured in IMDB's [Top 250 Movies chart](https://www.imdb.com/chart/top/) from 1996 to 2021.

During this project, I also had a chance to practice **extracting data from public APIs using Python** and **transforming the data for analysis using SQL**. 

## 2. Tableau Dashboards

There were many possible approaches to the analysis because the final dataset had many interesting attributes about the movies: IMDB rating, genres, evolution in rankings, budget, etc. (see **3.1 Final Dataset**). I decided to approach the analysis from a few different angles and the outcome was a set of 4 different dashboards:
  1. [Interactive exploratory dashboard](https://public.tableau.com/views/IMDBTop250-Overview/MoviesinIMDBTop250?:language=en-US&:display_count=n&:origin=viz_share_link). It presents an overview of the movies in the chart for a selected year. 
  2. [Financial Dashboard](https://public.tableau.com/views/IMDBTop250-Financials/Financials?:language=en-US&:display_count=n&:origin=viz_share_link). It presents insights into the financial aspect of the movies: budgets, revenues, profitability, etc. 
  3. [Ratings Dashboard](https://public.tableau.com/views/IMDBTop250_16980672361840/Ratings?:language=en-US&:display_count=n&:origin=viz_share_link). It contains insights into what drives the IMDB user ratings.
  4. [Evolution Dashboard](https://public.tableau.com/views/IMDBTop250-Evolution/EvolutionoverTime?:language=en-US&:display_count=n&:origin=viz_share_link). It presents insights into how the movie industry has evolved from 1996 (the chart's first year) to 2021.

## 3. Data Preparation

**TODO: Mention somewhere what the data is about on a high level (movies with rankings)**
**TODO: Maybe add links to 2 sources here? Since we will refer to them in the final dataset description (original source) **


I went through the following steps to get the raw data ready for analysis in Tableau:
1. Download a dataset of the IMDB Top 250 movies from 1996 to 2021 from Kaggle
2. Write a Python script to download additional details about those movies from The Movie Database (TMDB) API.
3. Merge the datasets and perform some cleanup
4. Transform the data into Fact and Dimensions using a Star-like model.
5. Download the transformed data as multiple .csv files to be joined using Tableau data modeling features.

In this section, you can access the final dataset used in Tableau, the raw source data, and the details of the cleanup and transformation, including the code that was run.

### 3.1 Final Dataset

All the data used for the analysis is available in the [Data folder](Data/Final/). It is a set of 10 .csv files:
1. Main data about movies that loosely follows the Star model:
  1. One Movie fact table with the main details about a movie
  2. 7 dimension tables with additional data about movies, including their position in the Top 250 ranking over the years.
2. Helper table that maps the language codes to respective names
3. Separate table that provides more details about the position of a movie in the rankings.

See below for more details about these files.

| File | Description |
|---|---|
| IMDB_Movie.csv | Movie fact table which contains the main attributes of a movie |
| IMDB_MovieGenre.csv | Contains the genres that the movie was tagged with by IMDB users. There can be multiple genre rows for each movie. |
| IMDB_MovieCategory.csv | Contains the category (high-level genre) of a movie. There is one category value for each movie. |
| IMDB_MovieProductionCompany.csv | Contains the details of the companies that produced a movie. There can be multiple company rows for each movie. |
| IMDB_MovieProductionCountry.csv | Contains the countries where a movie was produced (based on the address of the production companies). There can be multiple country rows for each movie. |
| IMDB_MovieCast.csv | Contains up to 4 main cast members who appeared in a movie. There can be up to 4 cast member rows for each movie.  |
| IMDB_MovieDirector.csv | Contains the directors who worked on a movie. There can be multiple director rows for each movie.  |
| IMDB_MovieRanking.csv | Contains the position in the Top 250 ranking for a movie and on a given year. There are 250 rows (1 for each position in the ranking) for each year (26 years from 1996 to 2021 included) |
| Language_codes_wikipedia.csv | Contains the mapping of world languages: language name with associated 2-character code (ISO 639-1) |
| IMDB_MovieRankingWithHistory.csv | Contains the same data as the MovieRanking file but has 3 additional attributes that allow to analyze the evolution of the ranking: new entry flag, previous year's ranking, and number of places gained. |

**TODO: Add more detailed description for each file with format (sample data in columns only)**

#### 3.1.1 Movie fact table

| **Column** | **Description** | **Format** | **Sample Data** | **Original Source** |
|---|---|---|---|---|
| imdb_id | Primary key. The part of the IMDB URL which points to the movie | String | /title/tt0115956/ <br/> (Full URL would be https://www.imdb.com/title/tt0060196/) | IMDB Top 250 Kaggle Dataset |
| title | Title of the movie | String | Courage Under Fire | IMDB Top 250 Kaggle Dataset |
| release_year | Year when the movie was released | Integer | 1996 | IMDB Top 250 Kaggle Dataset |
| RunTime | How long the movie is (in minutes) | Integer | 116 | IMDB Top 250 Kaggle Dataset |
| imdb_rating | IMDB Score of the movie (as of 2021 - the last year of the dataset) | Float | 6.6 | IMDB Top 250 Kaggle Dataset |
| imdb_num_votes | Number of votes for the movie on the IMDB website (as of 2021) | Integer | 53398 | IMDB Top 250 Kaggle Dataset |
| metascore | Score of the movie on the Metacritic website (as of 2021) | Float | 77 | IMDB Top 250 Kaggle Dataset |
| revenue | Box Office revenue generated by the movie (in Millions) | Float | 100860818 | TMDB API |
| budget | Budget of the movie | Float | 46000000 | TMDB API |
| is_adult | Defines if the film is only for adult viewers | Boolean | FALSE | TMDB API |
| tagline | Tagline of the movie | String | A medal for honor. A search for justice. A battle for truth. | TMDB API |
| tmdb_score | Score of the movie on TMDB website | Float | 6.463 | TMDB API |
| tmdb_votes_count | Number of votes for the movie on TMDB website | Integer | 818 | TMDB API |
| tmdb_popularity | Popularity score of the movie on TMDB website (on day of extraction) | Float | 17.482 | TMDB API |
| original_language | The original language of the movie | String | en | TMDB API |

#### 3.1.2 Movie dimensions

**Genre**

**Category**

**Production Company**

**Production Country**

**Cast**
For cast, director, genre, add screenshots where the data is coming from 
**Director**



**Ranking**


Format table for each dimension

#### 3.1.2 Other
1) language
2) ranking 


### 3.2 Raw source Data

To complete the analysis, I collected the data from 2 sources and merged them: ranking data from a Kaggle dataset and additional movie details from The Movie Database (TMDB) API.

**TODO: Review this summary: explain in a few points: downloaded Kaggle dataset, decided to enrich with TMDB, then merged and did transformation.**

#### 3.2.1 Main Dataset from Kaggle

The main source of data was a [Kaggle dataset](https://www.kaggle.com/datasets/mustafacicek/imdb-top-250-lists-1996-2020) containing the basic attributes of all movies featured in the IMDB Top 250 chart from 1996 to 2021 and respective ranking of the movie each year. You can download the .csv file from [Data folder](Data/Raw/IMDB/). 

There was a single table and each row of the table was a pair of movie details + movie ranking for a given year. There were 26 years of ranking and the chart features 250 movies, so the dataset has 6500 (26 x 250) rows.

Each row had the following attributes: 

| **Column** | **Description** | **Format** | **Sample data** |
|---|---|---|---|
| Ranking | Position of the movie in the chart | Integer | 3 |
| IMDBYear | The year of the Top 250 chart | Integer | 2001 |
| IMDBLink | Part of the IMDB URL which points to the movie | String | /tt0060196/ <br/> (Full URL would be https://www.imdb.com/title/tt0060196/) |
| Title | Title of the movie | String | The Good, the Bad and the Ugly |
| Date | Year when the movie was released | Integer | 1966 |
| RunTime | How long the movie is (in minutes) | Integer | 145 |
| Genre | A string listing all the genres associated with the movie (this data is entered by IMDB users) | String | Comedy, Crime, Drama |
| Rating | IMDB Score of the movie (as of 2021 - the last year of the dataset) | Float | 8.64 |
| Score | Score of the movie on the Metacritic website (as of 2021) | Integer | 64 |
| Votes | Number of votes for the movie on the IMDB website (as of 2021) | Integer | 105400 |
| Gross | Box Office revenue generated by the movie (in Millions). It seems that it only contains the **domestic** BO revenue | Float | 905.14 |
| Director | String containing the list of the names of the directors of the movie | String | Charles Crichton,  John Cleese |
| Cast1 | Name of the cast member appearing first on the movie webpage on the IMDB site. | String | Mel Gibson |
| Cast2 | Name of the cast member appearing second (if there is one) on the movie webpage on the IMDB site. | String | Julia Sawalha |
| Cast3 | Name of the cast member appearing third (if there is one) on the movie webpage on the IMDB site. | String | Phil Daniels |
| Cast4 | Name of the cast member appearing fourth (if there is one) on the movie webpage on the IMDB site. | String | Lynn Ferguson |

You can see a sample of this file in the [Data folder](Data/Raw/IMDB/imdbTop250-Raw.csv)

#### 3.2.2 Enriching with TMDB API

I decided to enrich the Kaggle dataset because it had a few issues:
  1. Based on a few samples, the revenue data was not reliable at all.
  2. There was no data on the budgets. I wanted to analyze the profitability.
  3. TMDB data had some additional attributes such as language, country of production, etc., which Kaggle data didn't have.

The Movie Database (TMDB) platform has a convenient API that is free for the registered users. I wrote a Python script to connect to this API and collect the data about the movies listed in my original dataset.

The Python script and the results csv file are available in the [Data folder](Data/Raw/TMDB).  **Please note** that the Python code is very hacky because I haven't properly looked into  Python data structures yet. 

The TMDB API provided various attributes for each movie but for my analysis, I focused on the following:

| Column | Description | Format | Sample data |
|---|---|---|---|
| adult | Defines if the film is only for adult viewers | Boolean | FALSE |
| tagline | Tagline of the movie | String | The Original Bad Boys. |
| vote_average | Score of the movie on TMDB website | Float | 5.2 |
| vote_count | Number of votes for the movie on TMDB website | Integer | 168 |
| popularity | Popularity score of the movie on TMDB website (on day of extraction) | Float | 7.949 |
| revenue | Box Office revenue of the movie | Integer | 23920048 |
| budget | Budget of the movie | Integer | 0 |
| original_language | The original language of the movie  | String | en |
| production_companies | Details of the companies that produced the movie | JSON String | [{'id': 2, 'logo_path': '/wdrCwmRnLFJhEoH8GSfymY85KHT.png', 'name': 'Walt Disney Pictures', 'origin_country': 'US'}, {'id': 134923, 'logo_path': None, 'name': 'Painted Fence Productions', 'origin_country': ''}] |
| production_countries | List of countries where the movie was produced (based on where the production companies are registered) | JSON String | [{'iso_3166_1': 'US', 'name': 'United States of America'}] |
| imdb_id | The ID of the movie in IMDB data - it allows to link the IMDB and TMDB datasets | String | tt0112302 |

### 3.3 Cleanup and Transformation

After collecting the data from both sources, some transformation was needed so that the data can be easily analyzed using Tableau. The table below details the issues with original sources that limited the analysis. It also lists the describes the transformation steps used to solve them. The transformation was completed using SQL on BigQuery as I have not yet studied data processing using Python or other languages. 

**Please note** that the data model used here may not fit the actual definition of Star schema but it's good enough for the purpose of this Taleau project. I plan to study the proper data modeling techniques later. 

| Issue | Solution | Details |
|---|---|---|
| IMDB raw dataset had duplicated movie data because one row was a pair of (movie, ranking year) values. | The main dataset was split using Star schema: Movie (fact table) and MovieRanking (dimension table)  | See [transform_star.sql](SQL/transform_star.sql) |
| IMDB raw dataset had multiple genre values, split by a comma. | The values were split into different rows and stored in a different dimension table MovieGenre | See [transform_star.sql](SQL/transform_star.sql) |
| IMDB raw dataset had multiple director values, split by a comma. | The values were split into different rows and stored in a different dimension table MovieDirector | See [transform_star.sql](SQL/transform_star.sql) |
| IMDB raw dataset had multiple cast member values, stored in separate columns. | The values were split into rows using Unpivot function and stored in a different dimension table MovieCast  | See [transform_star.sql](SQL/transform_star.sql) |
| IMDB and TMDB raw datasets had to be merged. | The Movie fact table was updated using attributes from the TMDB raw dataset. | See [transform_star.sql](SQL/transform_star.sql) |
| TMDB raw dataset had multiple production country values, stored in JSON string format | The production countries column was processed using JSON functions, split into rows, and stored in a separate dimension table MovieProductionCountry  | See [transform_star.sql](SQL/transform_star.sql) |
| TMDB raw dataset had multiple production company values, stored in JSON string format | The production companies column was processed using JSON functions, split into rows, and stored in a separate dimension table MovieProductionCompany  | See [transform_star.sql](SQL/transform_star.sql) |
| A few movies in the IMDB dataset had the same title but were released in different years | The titles were updated by concatenating the title and release year value to differentiate the 2 movies | See [transform_star.sql](SQL/transform_star.sql) |
| IMDB ranking data needed transformation to make it easier to analyze year-to-year changes in the chart (e.g. plotting the number of new entries by ranking year) | Calculated new fields using SQL and extracted the Movie Rankings with history in a separate .csv  | See [ranking_history_calc.sql](SQL/ranking_history_calc.sql) |
| TMDB raw dataset used codes to describe the movie language (ISO 639-1). It is not useful when presenting visualizations. | Downloaded dataset mapping codes to full names from Wikipedia (https://en.wikipedia.org/wiki/List_of_ISO_639-1_codes) | Language mapping .csv included in the final data (ADD URL)  |
| There are 23 different genres which makes it difficult to analyze using this dimension. | Group movies with specific genres into categories using a custom logic (in the defined order) (in the defined order): <br/> 1. Any movie that is tagged as comedy (no matter other genres) → Comedy <br/> 2. Movie not in (1) and which is tagged as either action or adventure → Action/Adventure <br/> 3. Movie that is not in (1) or (2) and which is tagged as ‘Drama’ (e.g. Drama and Thriller and War) → Drama <br/> 4. Movie that doesn’t fall under (1), (2), or (3) (e.g. Sports and Biography) → Other  | See [transform_star.sql](SQL/transform_star.sql) |
|  |  |  |

## 4. Future Improvements and Lessons Learned 
**TODO**

