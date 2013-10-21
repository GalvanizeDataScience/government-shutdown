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
top = names(sort(table(withdrawals$item), decreasing = TRUE)[1:100])
withdrawals$greatest = factor(withdrawals$item, levels = top)
top_item_wd <- withdrawals[withdrawals[,'item']%in%top,]

sorted_top_items <- top_item_wd[order(top_item_wd$today, decreasing = TRUE),]
most_expensive <- unique(sorted_top_items$item)[1:20]
subset_most_exp <- sorted_top_items[(sorted_top_items$item %in% most_expensive) &
                                      (sorted_top_items$today > 0),]
get_rid <- c("Public Debt Cash Redemp ( Table III B )","Total Federal Reserve Account" ,
             "Total Withdrawals ( excluding transfers )" ,"Interior", 'Total Other Withdrawals',
             'Net Change in Operating Cash Balance','Public Debt Cash Redemp ( Table III B )',
             'Total Withdrawals ( excluding transfers )','Total Federal Reserve Account',
             'Transfers to Federal Reserve Account Table V','Transfers to Depositaries')
final <- subset_most_exp[!(subset_most_exp$item %in% get_rid),]

p1 <- ggplot(final) + 
  aes(x = date, y= today, color = final$item)+
  geom_point() + 
  scale_y_log10(labels = dollar, name = 'Withdrawal Amount') +
  ggtitle('Which Government Programs Make the Most in Withdrawals?') +
  scale_x_date(name = "Date")+
  scale_color_hue(name = 'Government Program', h=c(0,400)) 
  
print(p1)

unzero_merge_sort1 <- split_merge_diff(top_item_wd = top_item_wd, date1 = as.Date('2012-09-15'),
                                       date2 = as.Date('2012-10-15'),
                                       date3 = as.Date('2011-09-15'),
                                       date4 = as.Date('2011-10-15'))[[1]]
unzero_merge_sort2 <- split_merge_diff(top_item_wd = top_item_wd, date1 = as.Date('2013-09-15'),
                                       date2 = as.Date('2013-10-15'),
                                       date3 = as.Date('2012-09-15'),
                                       date4 = as.Date('2012-10-15'))[[1]]
unzero_merge_sort3 <- split_merge_diff(top_item_wd = top_item_wd, date1 = as.Date('2011-09-15'),
                                       date2 = as.Date('2011-10-15'),
                                       date3 = as.Date('2010-09-15'),
                                       date4 = as.Date('2010-10-15'))[[1]]


p2 <- ggplot(unzero_merge_sort2[(!(unzero_merge_sort2$item %in% get_rid)&(unzero_merge_sort2$abs == 1)),]) +
  aes(x=factor(item, levels = unique(item)), y =diff, fill = recent_freq) + # group = abs, fill = factor(abs)) +
  geom_bar(stat = 'identity', position = 'dodge') + 
  ggtitle('Change in Average Withdrawal Amounts Between 2013 and 2012') + 
  scale_y_log10(breaks = c(10,100,1000,10000),labels = dollar, name = 
                  'Difference in Average Withdrawal') +
  scale_x_discrete(name = 'Program') +
  scale_fill_gradient('Total Number of\nWithdrawals This Year') + 
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
        legend.direction = 'horizontal',
        legend.position = c(.8,.8),
        legend.background = element_rect(fill = 'white'),
        panel.background = element_rect(fill = '990000'))
  print(p2)
  
  p3 <- ggplot(unzero_merge_sort1[(!(unzero_merge_sort1$item %in% get_rid)&(unzero_merge_sort1$abs == 1)),]) +
    aes(x=factor(item, levels = unique(item)), y =diff, fill = recent_freq) + # group = abs, fill = factor(abs)) +
    geom_bar(stat = 'identity', position = 'dodge') + 
    ggtitle('Change in Average Withdrawal Amounts Between 2012 and 2011') + 
    scale_y_log10(breaks = c(10,100,1000,10000),labels = dollar, name = 
                    'Difference in Average Withdrawal') +
    scale_x_discrete(name = 'Program') +
    scale_fill_gradient('Total Number of\nWithdrawals This Year') + 
    theme(axis.text.x = element_text(angle = 45, hjust = 1),
          legend.direction = 'horizontal',
          legend.position = c(.8,.8),
          legend.background = element_rect(fill = 'white'),
          panel.background = element_rect(fill = '990000'))
  print(p3)
  
  p4 <- ggplot(unzero_merge_sort3[(!(unzero_merge_sort3$item %in% get_rid)&(unzero_merge_sort3$abs == 1)),]) +
    aes(x=factor(item, levels = unique(item)), y =diff, fill = recent_freq) + # group = abs, fill = factor(abs)) +
    geom_bar(stat = 'identity', position = 'dodge') + 
    ggtitle('Change in Average Withdrawal Amounts Between 2012 and 2011') + 
    scale_y_log10(breaks = c(10,100,1000,10000),labels = dollar, name = 
                    'Difference in Average Withdrawal') +
    scale_x_discrete(name = 'Program') +
    scale_fill_gradient('Total Number of\nWithdrawals This Year') + 
    theme(axis.text.x = element_text(angle = 45, hjust = 1),
          legend.direction = 'horizontal',
          legend.position = c(.8,.8),
          legend.background = element_rect(fill = 'white'),
          panel.background = element_rect(fill = '990000'))
  print(p4)

ggsave(filename = 'p1.jpeg', plot = p1)
dev.off()
ggsave(filename = 'p2.jpeg', plot = p2)
dev.off()
ggsave(filename = 'p3.jpeg', plot = p3)
dev.off()