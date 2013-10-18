source('boilerplate.r')
library(scales)

t1$date <- as.Date(t1$date)
t1_subset <- subset(t1, account == 'Federal Reserve Account')
t1_subset <- subset(t1_subset, date )
# t1_subset[,'color'] <- NA
t1_subset$recent <- sapply(t1_subset$date, function(x){if (x > as.Date('2013-08-01')) 1 else 0})

initialplot <- ggplot(t1_subset) + aes(x = date, y = close_today, group = recent, color = factor(recent)) + geom_line()
print(initialplot)
str(t1_subset)

t2$date <- as.Date(t2$date)
withdrawals <-t2[(t2$transaction_type == 'withdrawal') & (t2$is_net == 0) & (t2$date > as.Date('2008-01-01')),]
top = names(sort(table(withdrawals$item), decreasing = TRUE)[1:20])
withdrawals$greatest = factor(withdrawals$item, levels = top)
top_item_wd <- withdrawals[withdrawals[,'item']%in%top,]
#with_great_freq <- withdrawals[withdrawals$item%in%withdrawals$greatest]
p1 <- ggplot(top_item_wd)
p1 <- p1 + aes(x = date, y = today, group = greatest, color = greatest) + geom_point(na.rm = TRUE)
p1 + scale_y_log10(labels = dollar)

top_item_wd$recent <- sapply(top_item_wd$date, function(x){if (x > as.Date('2013-08-01')) 1 else 0})
recent_mask = top_item_wd[,'recent'] == 1
old_mask = top_item_wd[,'recent'] == 0
recent_agg <- aggregate(today~item, data = top_item_wd[recent_mask,], FUN = mean)
old_agg <- aggregate(today~item, data = top_item_wd[old_mask,], FUN = mean)
merged_agg = data.frame(Expense = c(recent_agg$item, old_agg$item), 
                    Amount = c(recent_agg$today, old_agg$today),
                    recent = c(rep('During Showtown',dim(recent_agg)[1]), rep('Pre Shutdown',dim(old_agg)[1])))



p2 <- ggplot(merged_agg)
p2 <- p2 + aes(x = Expense, y = Amount, group = factor(recent), fill = factor(recent))  + geom_bar(position = 'dodge',stat = 'identity') +
  scale_y_log10(labels = dollar) + scale_x_discrete()

print(p2)