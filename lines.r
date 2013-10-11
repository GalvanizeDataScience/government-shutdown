library(sqldf)
library(ggplot2)
library(scales)
library(plyr)

if (!('d.full' %in% ls())) {
  d.full <- sqldf('select date, today, weekday, day, item, transaction_type from t2', dbname = 'treasury_data.db')
  d.full$date <- as.Date(d.full$date)
  d.full$weekday <- factor(d.full$weekday, levels = c('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday'))
  d.full$first.three.days <- factor(d.full$day <= 3, levels = c(TRUE, FALSE))
  levels(d.full$first.three.days) <- c('Yes', 'No')
}

d.subset <- subset(d.full,
  item == 'Labor Dept prgms ( excl unemployment )' |
  item == 'NASA programs' |
  item == 'Medicare' |
  item == 'Medicaid' )
d.subset <- subset(d.subset, transaction_type == 'withdrawal')
d.subset$item <- factor(d.subset$item)

p1 <- ggplot(d.subset) +
  aes(x = date, y = today, group = item) +
  aes(shape = weekday, color = item) +
  scale_y_log10('Amount') + scale_x_date('Date') +
  geom_line() + geom_point()

p2 <- ggplot(d.subset) +
  aes(x = date, y = today, group = item) +
  aes(shape = first.three.days, color = item) +
  scale_y_log10('Amount') + scale_x_date('Date') +
  scale_shape_discrete('Is it the first, second or third of the month?') +
  geom_line() + geom_point()

#m <- lm(today ~ day + item, data = d.subset)
plot(today ~ day + item, data = d.subset)
