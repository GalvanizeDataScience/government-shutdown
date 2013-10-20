label_subset <- function(x, newdate1, newdate2, olddate1, olddate2){
  if ((x > as.Date(newdate1)) & (x < as.Date(newdate2))){
    result = 1
  }else if ((x > as.Date(olddate1)) & (x < as.Date(olddate2))){
    result = 0
  }else{
    result = NA
  }
  return(result)
}

split_merge_diff <- function(top_item_wd, date1, date2, date3, date4){
  top_item_wd$recent <- sapply(top_item_wd$date, label_subset, newdate1 = date1, newdate2 = date2, 
                               olddate1 = date3, olddate2 = date4)
  recent_mask = top_item_wd$recent == 1
  recent_mask[is.na(recent_mask)] <- FALSE
  old_mask = top_item_wd$recent == 0
  old_mask[is.na(old_mask)] <- FALSE
  recent_agg <- aggregate(today~item, data = top_item_wd[recent_mask,], FUN = mean)
  old_agg <- aggregate(today~item, data = top_item_wd[old_mask,], FUN = mean)
  
  merged_agg = merge(x = recent_agg, y = old_agg, by.x = 'item', by.y = 'item', all.y = TRUE)
  names(merged_agg) = c('item', 'recent', 'history')
  merged_agg[is.na(merged_agg)]<- 0
  merged_agg$diff = merged_agg$history - merged_agg$recent
  ggplot(merged_agg) + aes(x = item, y = diff) + geom_bar(stat = 'identity') +
    theme(axis.text.x = element_text(angle = 90, hjust = 1)) + scale_y_log10()
  
  unzero_merged <- merged_agg[(merged_agg$recent > 0) & (merged_agg$history > 0),]
  
  # melted <- melt(data = unzero_merged, id = 'item')
  # levels = melted$item[melted$variable == 'diff'][order(melted$value[melted$variable == 'diff'])]
  # melted$item <- factor(melted$item, levels = levels)
  
  
  unzero_merge_sort <- unzero_merged[order(unzero_merged$diff),]
  unzero_merge_sort$abs <- sapply(unzero_merge_sort$diff, function(x) {if (x <= 0) 1 else 0})
  unzero_merge_sort$diff <- sapply(unzero_merge_sort$diff, function(x) {if (x <= 0) abs(x) else x})
  return(unzero_merge_sort)
}