# Check that the database file is there.
if (!(file.exists('treasury_data.db'))) {
  cat('You need to download the database; run this.\n')
  cat('  wget http://api.treasury.io/cc7znvq/47d80ae900e04f2/http/treasury_data.db\n')
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


# Querying
t3a_head <- sqldf('SELECT * FROM t3a LIMIT 100;')

print(sqldf('SELECt sum(today) FROM t3a_head'))


# Plotting
#
# There are a lot of syntaxes you can use with ggplot.
# This one is probably the most verbose format you can get,
# but it makes the different components quite clear.
p1 <- ggplot(t3a_head) + aes(x = date, y = today) + geom_point()
p2 <- ggplot(t3a_head) + aes(x = today) +
  stat_bin(binwidth = 1e5, geom = 'area')
print(p)
