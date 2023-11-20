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

### 3.1 Final Dataset

All the data used for the analysis is available in the [Data folder](Data/Final/). It is a set of XXXX .csv files. 

**TODO: ** Add some explanation about the final dataset (if not yet explained in other sections): list files, and their purpose, format, and sample of each file. 

### 3.2 Source Data

To complete the analysis, I collected the data from 2 sources and merged them: ranking data from a Kaggle dataset and additional movie details from The Movie Database (TMDB) API.

#### 3.2.1 Kaggle Dataset

The main source of data was a [Kaggle dataset](https://www.kaggle.com/datasets/mustafacicek/imdb-top-250-lists-1996-2020) containing the basic attributes of all movies featured in the IMDB Top 250 chart from 1996 to 2021 and respective ranking of the movie each year. 

There was a single table and each row of the table was a combination of movie details + movie ranking for a given year (movie x year). There were 26 years of ranking and the chart features 250 movies, so the dataset has 6500 (26 x 250) rows.

Each row had the following attributes: 

| **Column** | **Description** | **Format** | Sample data |
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
| Gross | Box Office revenue generated by the movie (in Millions) | Float | 905.14 |
| Director | String containing the list of the names of the directors of the movie | String | Charles Crichton,  John Cleese |
| Cast1 | Name of the cast member appearing first on the movie webpage on the IMDB site. | String | Mel Gibson |
| Cast2 | Name of the cast member appearing second (if there is one) on the movie webpage on the IMDB site. | String | Julia Sawalha |
| Cast3 | Name of the cast member appearing third (if there is one) on the movie webpage on the IMDB site. | String | Phil Daniels |
| Cast4 | Name of the cast member appearing fourth (if there is one) on the movie webpage on the IMDB site. | String | Lynn Ferguson |

See sample of the data below
| Ranking | IMDByear | IMDBlink | Title | Date | RunTime | Genre | Rating | Score | Votes | Gross | Director | Cast1 | Cast2 | Cast3 | Cast4 |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| 168 | 2000 | /title/tt0120630/ | Chicken Run | 2000 | 84 | Animation, Adventure, Comedy | 7 | 88 | 185939 | 106.83 | Peter Lord,  Nick Park | Mel Gibson | Julia Sawalha | Phil Daniels | Lynn Ferguson |
| 239 | 2001 | /title/tt0120630/ | Chicken Run | 2000 | 84 | Animation, Adventure, Comedy | 7 | 88 | 185939 | 106.83 | Peter Lord,  Nick Park | Mel Gibson | Julia Sawalha | Phil Daniels | Lynn Ferguson |
| 203 | 1998 | /title/tt0120780/ | Out of Sight | 1998 | 123 | Comedy, Crime, Drama | 7 | 85 | 90519 | 37.56 | Steven Soderbergh | George Clooney | Jennifer Lopez | Ving Rhames | Steve Zahn |
| 211 | 1997 | /title/tt0055614/ | West Side Story | 1961 | 153 | Crime, Drama, Musical | 7.5 | 86 | 107792 | 43.66 | Jerome Robbins,  Robert Wise | Natalie Wood | George Chakiris | Richard Beymer | Russ Tamblyn |
| 205 | 1998 | /title/tt0055614/ | West Side Story | 1961 | 153 | Crime, Drama, Musical | 7.5 | 86 | 107792 | 43.66 | Jerome Robbins,  Robert Wise | Natalie Wood | George Chakiris | Richard Beymer | Russ Tamblyn |

#### 3.2.2 TMDB API


### 3.3 Cleanup and Transformation
Todo

## 4. Future Improvements and Lessons Learned 

Todo

