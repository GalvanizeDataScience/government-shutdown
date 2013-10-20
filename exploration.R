setwd("~/Zipfian/week5/government-shutdown")
source('boilerplate.r')
source('functions.r')
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
#withdrawals$recent <- sapply(withdrawals$date, function(x){if (x > as.Date('2013-08-15')) 1 else 0})
top = names(sort(table(withdrawals$item), decreasing = TRUE)[1:100])
withdrawals$greatest = factor(withdrawals$item, levels = top)
top_item_wd <- withdrawals[withdrawals[,'item']%in%top,]
#with_great_freq <- withdrawals[withdrawals$item%in%withdrawals$greatest]
p1 <- ggplot(top_item_wd)
p1 <- p1 + aes(x = date, y = today, group = greatest, color = greatest) + geom_point(na.rm = TRUE)
p1 + scale_y_log10(labels = dollar)

unzero_merge_sort1 <- split_merge_diff(top_item_wd = top_item_wd, date1 = as.Date('2012-08-15'),
                                       date2 = as.Date('2012-09-15'),
                                       date3 = as.Date('2011-08-15'),
                                       date4 = as.Date('2011-09-15'))[[1]]
unzero_merge_sort2 <- split_merge_diff(top_item_wd = top_item_wd, date1 = as.Date('2013-08-15'),
                                       date2 = as.Date('2013-09-15'),
                                       date3 = as.Date('2012-08-15'),
                                       date4 = as.Date('2012-09-15'))[[1]]
unzero_merge_sort3 <- split_merge_diff(top_item_wd = top_item_wd, date1 = as.Date('2011-08-15'),
                                       date2 = as.Date('2011-09-15'),
                                       date3 = as.Date('2010-08-15'),
                                       date4 = as.Date('2010-09-15'))[[1]]

get_rid <- c("Public Debt Cash Redemp ( Table III B )","Total Federal Reserve Account" ,
             "Total Withdrawals ( excluding transfers )" ,"Interior", 'Total Other Withdrawals',
             'Net Change in Operating Cash Balance','Public Debt Cash Redemp ( Table III B )',
             'Total Withdrawals ( excluding transfers )','Total Federal Reserve Account',
             'Transfers to Federal Reserve Account Table V','Transfers to Depositaries')

unzero_merge_sort1[(!(unzero_merge_sort1$item %in% get_rid)&(unzero_merge_sort1$abs == 1))]

p5 <- ggplot(unzero_merge_sort3[!(unzero_merge_sort3$item %in% get_rid),]) +
  aes(x=factor(item, levels = unique(item)), y =diff, group = abs, fill = factor(abs)) +
  geom_bar(stat = 'identity', position = 'dodge') + 
  scale_y_log10(breaks = c(10,100,1000,10000),labels = dollar) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))
print(p5)

p3 <- ggplot(unzero_merge_sort1[(!(unzero_merge_sort1$item %in% get_rid)&(unzero_merge_sort1$abs == 1)),]) +
  aes(x=factor(item, levels = unique(item)), y =diff) + #group = abs, fill = factor(abs)) +
  geom_bar(stat = 'identity', position = 'dodge') + 
  scale_y_log10(breaks = c(10,100,1000,10000),labels = dollar) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))
print(p3)

p4 <- ggplot(unzero_merge_sort2[(!(unzero_merge_sort2$item %in% get_rid)&(unzero_merge_sort2$abs == 1)),]) +
  aes(x=factor(item, levels = unique(item)), y =diff, fill = recent_freq) + # group = abs, fill = factor(abs)) +
  geom_bar(stat = 'identity', position = 'dodge') + 
  ggtitle('What Did the Government Deem \'Unnecessary\'?') + 
  scale_y_log10(breaks = c(10,100,1000,10000),labels = dollar, name = 
                  'Difference in Average Withdrawal\n(between this and last year)') +
  scale_x_discrete(name = 'Program') +
  scale_fill_gradient('Total Number of\nWithdrawals This Year') + 
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
        legend.direction = 'horizontal',
        legend.position = c(.8,.8),
        legend.background)
print(p4)


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
