DROP VIEW IF EXISTS "year_start";
CREATE VIEW "year_start" AS SELECT
  "item",
  "transaction_type",
  "year",
  "date",
  "today"
FROM (SELECT * FROM "t2" ORDER BY "date" DESC)
WHERE
  "month" = 10 AND "day" <= 3 AND
  ("transaction_type" = 'deposit' OR "transaction_type" = 'withdrawal')
GROUP BY "item", "transaction_type", "year";

DROP VIEW IF EXISTS "year_mean";
CREATE VIEW "year_mean" AS SELECT
  "item",
  "transaction_type",
  "year",
  sum("today")/count("today") AS 'mean'
FROM "t2"
WHERE "transaction_type" = 'deposit' OR "transaction_type" = 'withdrawal'
GROUP BY "item", "transaction_type", "year";

DROP VIEW IF EXISTS "start_versus_mean";
CREATE VIEW "start_versus_mean" AS
SELECT year_start.item, year_start.transaction_type, year_start.year, year_start."date", year_start.today, year_mean.mean
FROM year_start JOIN year_mean
ON year_start.item = year_mean.item AND
   year_start.transaction_type = year_mean.transaction_type AND
   year_start.year = year_mean.year;
