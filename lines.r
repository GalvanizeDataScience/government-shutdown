library(sqldf)
library(ggplot2)
library(scales)
library(plyr)

if (!('d.full' %in% ls())) {
  d.full <- sqldf('select date, today, weekday, item, transaction_type from t2', dbname = 'treasury_data.db')
  d.full$date <- as.Date(d.full$date)
}

d.subset <- subset(d.full,
  item == 'Labor Dept prgms ( excl unemployment )' |
  item == 'NASA programs' |
  item == 'Medicare' |
  item == 'Medicaid' )
d.subset <- subset(d.subset, transaction_type == 'withdrawal')

p <- ggplot(d.subset) +
  aes(x = date, y = today, group = item) +
  aes(shape = weekday, color = item) +
  geom_line() +
  scale_y_log10('Amount')
