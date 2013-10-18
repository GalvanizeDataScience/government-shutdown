source('boilerplate.r')
t3c[1,]
t4[1,]
t2[1,]
t2[1,'item']
source('lines.r')
p3
source('lines.r')
dev.off()
t2[1,]
source('boilerplate.r')
t2[1,]
t2[c('today','mtd','fytd')]
t2[1,c('date','today','mtd','fytd')]
#t2[c('date','today','mtd','fytd')]
t2$date <- as.Date(t2$date)
#ggplot(t2[c('date','today','mtd','fytd')]) + aes(x = 
ggplot(t2) + aes(x = date, y = today) + geom_line()
library(reshape2)
ggplot(subset(t2, item == 'Medicaid')) + aes(x = date, y = today) + geom_line()
t2[1:10,c('date','today','mtd','fytd')]
t2.head <- t2[1:10,c('date','today','mtd','fytd')]
?melt(t2.head)
melt(t2.head, id.vars = 'date')
t2.head <- t2[1:3,c('date','today','mtd','fytd')]
t2.head
melt(t2.head, id.vars = 'date')
t2.head <- subset(t2, item == 'Medicaid')[1:3,c('date','today','mtd','fytd')]
t2.head
melt(t2.head, id.vars = 'date')
t2.molten <- melt(t2.head, id.vars = 'date')
ggplot(t2.molten) + aes(x = date, y = value, color = variable) + geom_line()
t2.molten
dcast(t2.molten, ~ variable)
dcast(t2.molten, ~ date)
dcast(t2.molten, . ~ date)
dcast(t2.molten, date ~)
dcast(t2.molten, date ~ .)
dcast(t2.molten, date ~ value)
dcast(t2.molten, value ~ .)
dcast(t2.molten, value ~ date)
dcast(t2.molten, date ~ .)
dcast(t2.molten, date ~ variable)
t2.molten
x ~ t
str(x ~ t)
x ~ a + b * c
dcast(t2.molten, date ~ variable)
t2.molten
t2.head
t2.head$today / t2.head$mtd
t2.head$new <- t2.head$today / t2.head$mtd
t2.head
t2.head
t2.head$new <- NULL
t2.head
t2.head$account <- 'Medicaid'
t2.head
t2.molten <- melt(t2.head, id.vars = 'date')
t2.molten
t2.molten <- melt(t2.head, id.vars = c('account','date'))
t2.molten
#install.packages('reshape2')
str(t2)
str(t2.head)
t2.head
t2.head$date
........ <- 3
........
........ = 3
........
a = 3
b <- 3
a
b
d <- 8989898 -> g
d
g
d = g = 123123
d  
g
t2.head$date
length(t2.head$date)
t2.head$date + 3
as.Date('2000-01-01') + 3
8 / 3
t2.head
t2.head / 2
t2.head[1:2] / 2
t2.head[2:3] / 2
t2.head[2:3]
t2.head[2:3] / 2
t2.head
t2.head[,]
t2.head[1,]
t2.head[2,]
t2.head[c(3,1),]
t2.head[c(1,2,3),]
c(1,2,3)
1:3
range(1,4)
1:10
t2.head[1:2,]
rownames(t2.head)
t2.head[41,]
t2.head['41',]
rownames(t2)[1:100]
t2.head
t2.head[c('41','101'),]
t2.head[1:2,]
t2.head[-3,]
t2.head[,]
t2.head[,'date']
t2.head[,c('date','today')]
t2.head[c('date','today')]
rownames(t2.head) <- t2.head$date
rownames(t2.head) <- c('a','b','c')
t2.head
rownames(t2.head) <- t2.head$date
t2.head
t2.head['2005-06-13',]
t2.head[c]
t2.head
t2.head[1:2]
t2.head[-4]
t2.head
t2.head[c(TRUE,FALSE,FALSE),]
t2.head[t2.head$mtd < 6000,]
t2.head[t2.head$mtd < 8000,]
t2.head[t2.head$mtd < 7000,]
t2.head$mtd < 7000
rownames(t2.head) <- t2.head$date
colnames(t2.hea)
colnames(t2.head)
colnames(t2.head)
item <- t2$item
barplot(item)
item[1:10]
table(item)
str(item)
str(item)
length(item)
table(item)
#factor(item)
#item <- t2$item
item.factor <_ factor(item)
item.factor <- factor(item)
item.factor[1:100]
levels(item.factor)
levels(item.factor)[139]
levels(item.factor)[139] <- 'coffee'
levels(item.factor)
item.factor[100:150]
ggplot(t2) + aes(x = item) + geom_bar()
#t2$item <- factor(t2$item, levels = )
table(t2$item)
sort(table(t2$item))
names(sort(table(t2$item)))
sort(table(t2$item))
names(sort(table(t2$item)))
t2$item <- factor(t2$item, levels =  names(sort(table(t2$item))))
ggplot(t2) + aes(x = item) + geom_bar()
not.factor <- c('a','b','c')
factor(not.factor)
factor(not.factor, levels = c('c','a','b'))
not.factor <- c('a','b','c', 'b','c','b','a')
factor(not.factor)
not.factor <- c('a','b','c', 'b','c','b','a')
factor(not.factor)
factor(not.factor, levels = c('c','a','b'))
one <- factor(not.factor)
two <- factor(not.factor, levels = c('c','a','b'))
sort(one)
sort(two)
