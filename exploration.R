setwd("~/Zipfian/week5/government-shutdown")
source('boilerplate.r')
rm('t3a', 't3a_head', 't3b', 't3c', 't4', 't5', 't6')
library(scales)
library(plyr)
library(reshape2)

t1$date <- as.Date(t1$date)
t1_subset <- subset(t1, account == 'Federal Reserve Account')
t1_subset <- subset(t1_subset, date )
# t1_subset[,'color'] <- NA
t1_subset$recent <- sapply(t1_subset$date, function(x){if (x > as.Date('2013-08-01')) 1 else 0})

initialplot <- ggplot(t1_subset) + 
  aes(x = date, y = close_today, group = recent, color = factor(recent)) + geom_line()
print(initialplot)
str(t1_subset)

t2$date <- as.Date(t2$date)
withdrawals <-t2[(t2$transaction_type == 'withdrawal') & (t2$is_net == 0) & (t2$date > as.Date('2008-01-01')),]
withdrawals$recent <- sapply(withdrawals$date, function(x){if (x > as.Date('2013-08-15')) 1 else 0})
top = names(sort(table(withdrawals$item), decreasing = TRUE)[1:50])
withdrawals$greatest = factor(withdrawals$item, levels = top)
top_item_wd <- withdrawals[withdrawals[,'item']%in%top,]
#with_great_freq <- withdrawals[withdrawals$item%in%withdrawals$greatest]
p1 <- ggplot(top_item_wd)
p1 <- p1 + aes(x = date, y = today, group = greatest, color = greatest) + geom_point(na.rm = TRUE)
p1 + scale_y_log10(labels = dollar) 

top_item_wd$recent <- sapply(top_item_wd$date, function(x){if (x > as.Date('2013-07-15')) 1 else 0})
recent_mask = top_item_wd[,'recent'] == 1
old_mask = top_item_wd[,'recent'] == 0
recent_agg <- aggregate(today~item, data = top_item_wd[recent_mask,], FUN = mean)
old_agg <- aggregate(today~item, data = top_item_wd[old_mask,], FUN = mean)
added_agg = data.frame(Expense = c(recent_agg$item, old_agg$item), 
                    Amount = c(recent_agg$today, old_agg$today),
                    recent = c(rep('During Showtown',dim(recent_agg)[1]), rep('Pre Shutdown',dim(old_agg)[1])))



p2 <- ggplot(added_agg)
p2 <- p2 + aes(x = Expense, y = Amount, group = factor(recent), fill = factor(recent))  + 
  geom_bar(position = 'dodge',stat = 'identity') +
  scale_y_log10(labels = dollar) + labs(title = "Average Goverment Program Withdrawals") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))

print(p2)

merged_agg = merge(x = recent_agg, y = old_agg, by.x = 'item', by.y = 'item', all.y = TRUE)
names(merged_agg) = c('item', 'recent', 'history')
merged_agg[is.na(merged_agg)]<- 0
merged_agg$diff = merged_agg$history - merged_agg$recent
ggplot(merged_agg) + aes(x = item, y = diff) + geom_bar(stat = 'identity') +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) + scale_y_log10()

unzero_merged <- merged_agg[(merged_agg$recent > 0) & (merged_agg$history > 0),]
melted <- melt(data = unzero_merged, id = 'item')
levels = melted$item[melted$variable == 'diff'][order(melted$value[melted$variable == 'diff'])]
melted$item <- factor(melted$item, levels = levels)
p3 <- ggplot(melted[melted$variable == 'diff',],) +
  aes(x=item, y =value, group = variable, fill = variable) +
  geom_bar(stat = 'identity', position = 'dodge') + 
  scale_y_log10(breaks = c(10,100,1000,10000),labels = dollar) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))
print(p3)


unzero_merge_sort <- unzero_merged[order(unzero_merged$diff),]
unzero_merge_sort$abs <- sapply(unzero_merge_sort$diff, function(x) {if (x <= 0) 1 else 0})
unzero_merge_sort$diff <- sapply(unzero_merge_sort$diff, function(x) {if (x <= 0) abs(x) else x})
p3 <- ggplot(unzero_merge_sort) +
  aes(x=item, y =diff, group = abs, fill = factor(abs)) +
  geom_bar(stat = 'identity', position = 'dodge') + 
  scale_y_log10(breaks = c(10,100,1000,10000),labels = dollar) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))
print(p3)


pos_names = merged_agg[merged_agg$diff > 0,'item']
neg_names = merged_agg[merged_agg$diff <= 0,'item']
pos_subset = top_item_wd[top_item_wd[,'item']%in%pos_names,]
neg_subset = top_item_wd[top_item_wd[,'item']%in%neg_names,]
ggplot(neg_subset[neg_subset[,'date']>as.Date('2013-9-01'),]) + 
  aes(x = date, y = today, group = item, color = item) + geom_bar() +
  scale_y_continuous(labels = dollar)

ggplot(withdrawals)

#ggsave(filename='shutdown_bar.jpg', plot = p2)
#ggsave(filename='shutdown_point.jpg', plot = p1)
