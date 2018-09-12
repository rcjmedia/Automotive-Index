DROP TABLE IF EXISTS car_models;
-- Create a new postgres user named `indexed_cars_user`
CREATE USER indexed_cars_user;
-- Create a new database named `indexed_cars`
DROP DATABASE IF EXISTS indexed_cars;
-- owned by `indexed_cars_user`
CREATE DATABASE indexed_cars OWNER = indexed_cars_user;
-- Run the provided `scripts/car_models.sql` script on the `indexed_cars` database
\c indexed_cars;
\i scripts/car_models.sql;
-- -- Run the provided `scripts/car_model_data.sql` script on the `indexed_cars` database **10 times** 
\i scripts/car_model_data.sql; 
\i scripts/car_model_data.sql;
\i scripts/car_model_data.sql; 
\i scripts/car_model_data.sql; 
\i scripts/car_model_data.sql; 
\i scripts/car_model_data.sql;
\i scripts/car_model_data.sql;
\i scripts/car_model_data.sql; 
\i scripts/car_model_data.sql; 
\i scripts/car_model_data.sql; 
--    _there should be **223380** rows in `car_models`_
CREATE INDEX 
  ON car_models(make_code, make_title, model_code, model_title, year);
-- Run a query to get a list of all `make_title` values from the `car_models` table where the `make_code` is `'LAM'`, without any duplicate rows, and note the time somewhere. (should have 1 result)
SELECT DISTINCT make_title
  FROM car_models
  WHERE make_code = 'LAM';
-- 33ms
-- Run a query to list all `model_title` values where the `make_code` is `'NISSAN'`, and the `model_code` is `'GT-R'` without any duplicate rows, and note the time somewhere. (should have 1 result)
SELECT DISTINCT model_title
  FROM car_models
  WHERE make_code = 'NISSAN'
  AND model_code = 'GT-R';
-- 37ms
-- Run a query to list all `make_code`, `model_code`, `model_title`, and year from `car_models` where the `make_code` is `'LAM'`, and note the time somewhere. (should have 1360 rows)
SELECT make_code, 
  model_code, 
  model_title, 
  year
  FROM car_models
  WHERE make_code = 'LAM';
-- 40ms
-- Run a query to list all fields from all `car_models` in years between `2010` and `2015`, and note the time somewhere (should have 78840 rows)
SELECT *
  FROM car_models
  WHERE year BETWEEN 2010 and 2015;
-- 472ms
-- Run a query to list all fields from all `car_models` in the year of `2010`, and note the time somewhere (should have 13140 rows)
SELECT *
  FROM car_models
  WHERE year = '2010';
-- 98ms
-- Given the current query requirements, "should get all make_titles", "should get a list of all model_titles by the make_code", etc.  
-- Create indexes on the columns that would improve query performance.

-- To add an index:

-- ```
-- CREATE INDEX [index name]
--   ON [table name] ([column name(s) index]);
-- ```

-- Record your index statements in `indexing.sql`

-- Write the following statements in `indexing.sql`
-- Create a query to get a list of all `make_title` values from the `car_models` table where the `make_code` is `'LAM'`, without any duplicate rows, and note the time somewhere. (should have 1 result)
CREATE INDEX indexMakeCode
  ON car_models(make_title);
SELECT DISTINCT make_title
  FROM car_models
  WHERE make_code LIKE '%LAM%';
-- 38ms 
-- Create a query to list all `model_title` values where the `make_code` is `'NISSAN'`, and the `model_code` is `'GT-R'` without any duplicate rows, and note the time somewhere. (should have 1 result)
CREATE INDEX indexMakeAndModelCode
	ON car_models (make_code, model_code) WHERE make_code = 'NISSAN' AND model_code = 'GT-R';
SELECT DISTINCT model_title
  FROM car_models
  WHERE make_code = 'NISSAN'
  AND model_code = 'GT-R';
-- 29ms
-- Create a query to list all `make_code`, `model_code`, `model_title`, and year from `car_models` where the `make_code` is `'LAM'`, and note the time somewhere. (should have 1360 rows)
CREATE INDEX indexMakeModelModelTitleYear
  ON car_models (make_code, model_code, model_title, year) 
  WHERE make_code = 'LAM';
SELECT make_code, 
       model_code,
       model_title, 
       year
  FROM car_models
  WHERE make_code LIKE '%LAM%'
-- 43ms
-- Create a query to list all fields from all `car_models` in years between `2010` and `2015`, and note the time somewhere (should have 78840 rows)
CREATE INDEX indexAllFields
  ON car_models (make_code, make_title, model_code, model_title, year) WHERE year BETWEEN 2010 AND 2015;
SELECT *
  FROM car_models
  WHERE year 
  BETWEEN 2010 and 2015;
-- 429ms
-- Create a query to list all fields from all `car_models` in the year of `2010`, and note the time somewhere (should have 13140 rows)
CREATE INDEX indexAllFields2010
	ON car_models (make_code, make_title, model_code, model_title, year) WHERE year = 2010;
SELECT *
  FROM car_models
  WHERE year = '2010';
-- 94ms