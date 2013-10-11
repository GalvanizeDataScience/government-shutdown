library(sqldf)
library(ggplot2)
library(scales)
library(plyr)

d.full <- sqldf('select date, today, weekday, item from t2', dbname = 'treasury_data.db')
d.full$date <- as.Date(d.full$date)

d.subset <- subset(d,
  item == 'Labor Dept prgms ( excl unemployment )' |
  item == 'NASA programs' |
  item == 'Medicare' |
  item == 'Medicaid' )
