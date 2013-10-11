library(sqldf)
library(ggplot2)
library(scales)
library(plyr)
library(MASS)
library(reshape)

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
d.subset$month.side <- d.subset$day <= 3 | d.subset$day >= 26

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

p3 <- function() {
  par(mfrow = 1:2)
  plot(today ~ day + item, data = d.subset)

  plot(today ~ month.side + item, data = d.subset)
}

p4 <- ggplot(d.subset) + aes(x = item, y = today, color = month.side) +
  geom_point(position = position_jitter(), alpha = 0.3)

# Ordinary least-squares regression
m <- lm(today ~ month.side * item, data = d.subset)

# Comparing OLS to robust regression
d.two <- subset(d.full, item == "Federal Crop Ins Corp" | item == "Pension Benefit Guaranty Corp")[c('date','item','today')]
d.two$month <- strftime(d.two$date, '%Y-%m')
d.two.cast <- cast(d.two, month ~ item, fun.aggregate = sum, value = 'today')
colnames(d.two.cast)[2:3] <- c('crop.ins','pension')

# plot(d.two.cast)
par(mfrow = c(2,2))

m1 <- lm(crop.ins ~ pension, data = d.two.cast)
plot(crop.ins ~ pension, data = d.two.cast, main = 'Linear model')
abline(m1)

m2 <- rlm(crop.ins ~ pension, data = d.two.cast)
plot(crop.ins ~ pension, data = d.two.cast, main = 'Robust linear model')
abline(m2)

d.two.cast[2:3] <- d.two.cast[2:3] + 1

m3 <- lm(log(crop.ins) ~ log(pension), data = d.two.cast)
plot(log(crop.ins) ~ log(pension), data = d.two.cast, main = 'Linear model, with additive smoothing')
abline(m3)

m4 <- rlm(log(crop.ins) ~ log(pension), data = d.two.cast)
plot(log(crop.ins) ~ log(pension), data = d.two.cast, main = 'Robust linear model, with additive smoothing')
abline(m4)

