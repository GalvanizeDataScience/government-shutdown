library(sqldf)
library(ggplot2)
library(scales)
library(plyr)

start.v.mean <- sqldf('select * from start_versus_mean', dbname = 'treasury_data.db')
"
molten <- melt(start.v.mean,
               id.vars = c('item','transaction_type','year','date'),
               measure.vars = c('today','mean'),
               variable.name = 'statistic', value.name = 'amount')
"

start.v.mean$difference <- start.v.mean$today / start.v.mean$mean

item.medians <- ddply(start.v.mean, 'item', function(df) {
  c(median = median(df$difference))
})

start.v.mean$item <- factor(start.v.mean$item,
  levels = item.medians$item[order(item.medians$median)])

p <- ggplot(start.v.mean) +
  aes(x = item, color = year == 2013, shape = transaction_type, y = difference) +
  geom_point(alpha = 0.5) + coord_flip() +
  scale_y_log10('Amount for year start over mean amount for the year', labels = comma)

hist(log(start.v.mean$difference))
wilcox.test(log(start.v.mean$difference))                                         


# plot(log(mean) ~ log(today), data = na.omit(start.v.mean))

