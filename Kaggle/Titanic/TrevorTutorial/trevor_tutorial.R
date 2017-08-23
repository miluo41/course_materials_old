library(tidyverse)
training=read.csv('../data/train.csv')
testing=read.csv('../data/test.csv')
summary(training$Sex)
table(training$Sex)
table(training$Sex,training$Survived)
prop.table(table(training$Sex,training$Survived))
prop.table(table(training$Sex,training$Survived),1)
prop.table(table(training$Sex,training$Survived),2)
dim(testing)
testing$Survivial<-rep(0,dim(testing)[1])
testing$Survivial[testing$Sex=='female']<-1
df<-data.frame(PassengerId=testing$PassengerId,Survived=testing$Survivial)
write.csv(df,'gender_model.csv',row.names = FALSE)

summary(training$Age)
training$Child<-0
training$Child[training$Age<18]<-1
aggregate(Survived ~ Child + Sex, data=training, FUN=sum)
aggregate(Survived ~ Child + Sex, data=training, FUN=length)
aggregate(Survived ~ Child + Sex, data=training, FUN=mean)
aggregate(Survived ~ Child + Sex, data=training, FUN=function(x){sum(x)/length(x)})

range(training$Fare)
summary(training$Fare)
training$Fare2<-'30+'
training$Fare2[training$Fare>20 & training$Fare<=30]<-'20-30'
training$Fare2[training$Fare>10 & training$Fare<=20]<-'10-20'
training$Fare2[training$Fare<=10]<-'<=10'

aggregate(Survived ~ Fare2 + Pclass + Sex, data=training, 
          FUN=function(x){c(mean=mean(x),count=length(x))})

testing$Survivial<-0
testing$Survivial[testing$Sex=='female']<-1
testing$Survival[testing$Sex=='female' & testing$Pclass==3 & testing$Fare>=20]<-0

df2=data.frame(PassengerId=testing$PassengerId,Survived=testing$Survivial)
write.csv(df2,'gender_class_model.csv',row.names = FALSE)