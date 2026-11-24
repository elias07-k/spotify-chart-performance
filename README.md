# Spotify Chart Performance & Music Trends Analysis

## Project Overview

This project analyzes daily Spotify chart data to explore song and artist chart appearances, Spotify popularity scores, country-level differences, and selected audio characteristics.

The analysis uses SQL for data exploration and aggregation, and Power BI to present the results in an interactive dashboard.

**Markets featured in the dashboard:** United States (US), Canada (CA), and Great Britain (GB).

## Dataset

- **Source:** [Top Spotify Songs in 73 Countries (Daily Updated) — Kaggle](https://www.kaggle.com/datasets/asaniczka/top-spotify-songs-daily-updated)
- **Original dataset size:** approximately 2.1 million rows
- **Coverage in the source data:** approximately October 2023 to June 2025
- **Dashboard subset:** US, Canada, and Great Britain
- **Relevant fields:** `spotify_id`, `name`, `artists`, `daily_rank`, `weekly_movement`, `country`, `snapshot_date`, `popularity`, `energy`, and `danceability`

The dataset contains chart records and Spotify audio/popularity attributes. It does **not** contain actual streaming counts, so this project does not claim to measure streams or streaming volume.

## Tools

- **SQLite / DB Browser for SQLite** — data exploration and SQL analysis
- **SQL** — filtering, grouping, aggregation, distinct counts, conditional classification, and sorting
- **Power BI Desktop** — KPI cards, charts, and interactive country filtering

## Business Questions

1. Which artist entries appear most frequently in the daily chart data?
2. Which song titles have the highest average Spotify popularity scores?
3. How do chart-entry counts and unique track counts differ by country?
4. How does average Spotify popularity compare across the US, Canada, and Great Britain?
5. Which records show the largest positive weekly chart movement?
6. How do average popularity scores compare across low-, medium-, and high-energy groups?
7. How do average popularity scores compare across low-, medium-, and high-danceability groups?

## Methodology

1. Imported the full CSV dataset into SQLite.
2. Explored the data structure and checked the record count.
3. Used SQL aggregations and filters to analyze artist appearances, song popularity, country-level chart records, weekly movement, and audio features.
4. Created a view, `spotify_three_markets`, filtering the data to US, CA, and GB.
5. Exported the three-market view and imported it into Power BI.
6. Built an interactive dashboard with KPI cards, bar/column charts, and a country slicer.

## Key Metrics and Definitions

- **Chart entries:** Number of chart rows. A track can appear repeatedly across dates and countries.
- **Unique songs:** Number of distinct `spotify_id` values.
- **Average popularity:** Average Spotify popularity score in the records being analyzed. This is not a stream count.
- **Artist chart appearances:** Number of rows grouped by the `artists` text field. Multiple credited artists in one field are treated as a combined entry.
- **Audio feature groups:** Energy and danceability are grouped into low, medium, and high categories using the thresholds in the SQL queries.

## Preliminary Observations

- The three-market dashboard contains repeated daily chart appearances, so total chart entries are higher than the number of unique track IDs.
- The same track can appear in more than one country's chart; country-level unique-song counts should not be added together to estimate a global total.
- In the exploratory energy grouping, the low-energy category returned the highest average popularity in the query results. This is an association in this dataset, not evidence that lower energy causes higher popularity.

Add or revise observations after checking the final dashboard values and results.

## Repository Structure

```text
spotify-chart-performance/
├── SQL/
│   └── spotify_analysis.sql
├── Dashboard/
│   └── Spotify_Chart_Performance_Analysis.pbix
├── Screenshots/
│   └── dashboard_overview.png
└── README.md
```

## Limitations

- The analysis is based on chart records and Spotify popularity scores, not actual stream counts.
- Grouping by song `name` can combine different tracks that share the same title. Using `spotify_id` is more reliable for track-level uniqueness.
- Artist credits containing multiple names are treated as one combined text value in the artist-appearance query.
- Differences between audio-feature groups are descriptive and do not establish causation.

## How to Reproduce

1. Download the source dataset from the Kaggle link above.
2. Import the CSV into SQLite as a table named `spotify`.
3. Run the queries in `SQL/spotify_analysis.sql`.
4. Create or retain the `spotify_three_markets` view for US, CA, and GB.
5. Export that view to CSV and load it into Power BI Desktop.
6. Open the `.pbix` file in the `Dashboard` folder.

## Author

Add your name and relevant portfolio links here.
