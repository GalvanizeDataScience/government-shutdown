# Check that the database file is there.
if (!(file.exists('treasury_data.db'))) {
  print('You need to download the database; run this.')
  print('  wget http://api.treasury.io/cc7znvq/47d80ae900e04f2/http/treasury_data.db')
  quit()
}

# Load dependencies
library(ggplot2)
library(sqldf)

# Run this if the "library" commands fail.
# install.packages(c('ggplot2','sqldf'))


# Load all of the tables into R
.tables <- sqldf('SELECT tbl_name FROM sqlite_master', dbname = 'treasury_data.db')$tbl_name
for (.table in .tables) {
  if (!(.table %in% ls())) {
    .sql <- paste('SELECT * FROM', .table)
    assign(.table, sqldf(.sql, dbname = 'treasury_data.db'))
  }
}

sql <- '
SELECT
  "table",
  "date",
  "year_month",
  "year",
  "month",
  "day",
  "weekday",
  "account",
  "transaction_type",
  "parent_item",
  "is_total",
  "is_net",
  "item",
  "item_raw",
  "today",
  "mtd",
  "fytd",
  "url"
FROM "t2"
WHERE ("date" > \'2013-09-01\')
AND ("transaction_type" = \'deposit\' OR "transaction_type" = \'withdrawal\')
'

recent.transactions <- sqldf(sql)
p <- ggplot(subset(recent.transactions, is_total == 0)) +
  aes(x = date, group = transaction_type, color = transaction_type, y = today) +
  geom_line() + facet_wrap(~ item)
