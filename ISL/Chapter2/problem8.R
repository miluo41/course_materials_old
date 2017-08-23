library(tidyverse);library(GGally)
college<-read.csv('college.csv')
rownames(college)<-college[,1]
college<-college[,-1]
# college %>% ggplot()+geom_boxplot(aes(Private,Outstate))
Elite<-rep('No',nrow(college))
Elite[college$Top10perc>50]<-'Yes'
college<-add_column(college,Elite)
college %>% ggplot()+geom_boxplot(aes(Elite,Outstate))