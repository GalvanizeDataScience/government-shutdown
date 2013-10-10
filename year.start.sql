SELECT
  "date",
  "item",
  "today",
  "year"
FROM (SELECT * FROM "t2" ORDER BY "date" DESC)
WHERE
  "month" = 10 AND "day" <= 3 AND
  ("transaction_type" = 'deposit' OR "transaction_type" = 'withdrawal') AND
  "item" = 'Medicaid'
GROUP BY "year";
