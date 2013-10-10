library(sqldf)

start.v.mean <- sqldf('select * from start_versus_mean', dbname = 'treasury_data.db')
molten <- melt(start.v.mean,
               id.vars = c('item','transaction_type','year','date'),
               measure.vars = c('today','mean'),
               variable.name = 'statistic', value.name = 'amount')
