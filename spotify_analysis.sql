-- Spotify Chart Performance & Music Trends Analysis
-- Dataset: Top Spotify Songs in 73 Countries (Daily Updated)
-- Database: spotify_analytics.db
--
-- Notes:
--   * spotify contains the full dataset.
--   * spotify_three_markets is a view filtered to US, Canada, and Great Britain.
--   * Chart entries count repeated daily chart appearances.
--   * Unique songs are counted using spotify_id.
--   * Spotify popularity is a 0-100 score, not a stream count.

-- ============================================================
-- 1. DATA EXPLORATION
-- ============================================================

-- Count all records in the full dataset.
SELECT COUNT(*)
FROM spotify;

-- Preview the first 10 records.
SELECT *
FROM spotify
LIMIT 10;


-- ============================================================
-- 2. ARTIST AND SONG PERFORMANCE
-- ============================================================

-- Top 10 artist entries by number of chart appearances.
-- Artists credited together in one field are treated as one entry.
SELECT artists, COUNT(*) AS chart_appearances
FROM spotify
GROUP BY artists
ORDER BY chart_appearances DESC
LIMIT 10;

-- Top 10 song titles by average Spotify popularity score.
-- Grouping by name may combine different tracks with the same title.
SELECT name, AVG(popularity) AS avg_popularity
FROM spotify
GROUP BY name
ORDER BY avg_popularity DESC
LIMIT 10;

-- Songs with an average popularity score above 90.
SELECT name, AVG(popularity) AS avg_popularity
FROM spotify
GROUP BY name
HAVING AVG(popularity) > 90
ORDER BY avg_popularity DESC;

-- Popularity range (minimum and maximum) for each song title.
SELECT
    name,
    MIN(popularity) AS lowest_popularity,
    MAX(popularity) AS highest_popularity
FROM spotify
GROUP BY name
LIMIT 10;

-- Explore chart records credited to Playboi Carti.
SELECT *
FROM spotify
WHERE artists = 'Playboi Carti'
LIMIT 20000;


-- ============================================================
-- 3. COUNTRY-LEVEL CHART ANALYSIS
-- ============================================================

-- Top 10 countries by total chart entries.
SELECT country, COUNT(*) AS chart_entries
FROM spotify
GROUP BY country
ORDER BY chart_entries DESC
LIMIT 10;

-- Top 10 songs by popularity score in Canada.
-- A song can appear more than once across different chart dates.
SELECT name, popularity
FROM spotify
WHERE country = 'CA'
ORDER BY popularity DESC
LIMIT 10;

-- Number of unique Spotify tracks in each country.
SELECT
    country,
    COUNT(DISTINCT spotify_id) AS unique_songs
FROM spotify
GROUP BY country
ORDER BY unique_songs DESC
LIMIT 10;

-- Compare unique songs with total chart entries by country.
SELECT
    country,
    COUNT(DISTINCT spotify_id) AS unique_songs,
    COUNT(*) AS total_entries,
    100.0 * COUNT(DISTINCT spotify_id) / COUNT(*) AS unique_song_percentage
FROM spotify
GROUP BY country
ORDER BY unique_song_percentage DESC;

-- Average Spotify popularity in the US, Canada, and Great Britain.
SELECT
    country,
    AVG(popularity) AS avg_popularity
FROM spotify
WHERE country IN ('US', 'CA', 'GB')
GROUP BY country
ORDER BY avg_popularity DESC;


-- ============================================================
-- 4. CHART MOVEMENT
-- ============================================================

-- Top 10 records with the largest positive weekly chart movement.
SELECT name, artists, weekly_movement
FROM spotify
ORDER BY weekly_movement DESC
LIMIT 10;


-- ============================================================
-- 5. AUDIO FEATURES AND POPULARITY
-- ============================================================

-- Compare average popularity across low-, medium-, and high-energy groups.
SELECT
    CASE
        WHEN energy < 0.4 THEN 'Low Energy'
        WHEN energy >= 0.4 AND energy < 0.7 THEN 'Medium Energy'
        WHEN energy >= 0.7 THEN 'High Energy'
    END AS energy_level,
    AVG(energy) AS avg_energy,
    AVG(popularity) AS avg_popularity
FROM spotify
GROUP BY energy_level
ORDER BY avg_popularity DESC;

-- Compare average popularity across low-, medium-, and high-danceability groups.
SELECT
    CASE
        WHEN danceability < 0.4 THEN 'Low'
        WHEN danceability >= 0.4 AND danceability < 0.7 THEN 'Medium'
        WHEN danceability >= 0.7 THEN 'High'
    END AS danceability_level,
    AVG(popularity) AS avg_popularity
FROM spotify
GROUP BY danceability_level
ORDER BY avg_popularity DESC;


-- ============================================================
-- 6. THREE-MARKET VIEW CHECK
-- ============================================================

-- Preview the view filtered to the US, Canada, and Great Britain.
SELECT *
FROM spotify_three_markets
LIMIT 10;
