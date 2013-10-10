DROP VIEW IF EXISTS "year_start";
CREATE VIEW "year_start" AS SELECT
  "date",
  "item",
  "today",
  "year"
FROM (SELECT * FROM "t2" ORDER BY "date" DESC)
WHERE
  "month" = 10 AND "day" <= 3 AND
  ("transaction_type" = 'deposit' OR "transaction_type" = 'withdrawal')
GROUP BY "item", "transaction_type", "year";
