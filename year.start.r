library(sqldf)
library(ggplot2)
library(scales)

start.v.mean <- sqldf('select * from start_versus_mean', dbname = 'treasury_data.db')
"
molten <- melt(start.v.mean,
               id.vars = c('item','transaction_type','year','date'),
               measure.vars = c('today','mean'),
               variable.name = 'statistic', value.name = 'amount')
"

start.v.mean$difference <- start.v.mean$today / start.v.mean$mean
start.v.mean$item <- factor(start.v.mean$item,
  levels = unique(start.v.mean$item[order(start.v.mean$difference)]))

p <- ggplot(start.v.mean) +
  aes(x = item, group = transaction_type, color = transaction_type, y = difference) +
  geom_line() + coord_flip() +
  scale_y_log10('Amount for year start over mean amount for the year', labels = dollar)
