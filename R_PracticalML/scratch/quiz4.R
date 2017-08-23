# library(tidyverse);library(caret)
# library(ElemStatLearn)
# #Q1
# data(vowel.train)
# data(vowel.test)
# training<-vowel.train %>% mutate(y=as.factor(y))
# testing<-vowel.test %>% mutate(y=as.factor(y))
# set.seed(33833)
# rf.fit<-train(y~.,training,method='rf')
# gbm.fit<-train(y~.,training,method='gbm')
# rf.pred<-data.frame(y=predict(rf.fit,testing))
# gbm.pred<-data.frame(y=predict(gbm.fit,testing))
# conf.rf<-confusionMatrix(rf.pred$y,testing$y)
# conf.gbm<-confusionMatrix(gbm.pred$y,testing$y)
# testing2<-testing %>%
#         mutate(index=seq_len(nrow(testing)))
# rf.pred2<-rf.pred %>%
#         mutate(index=seq_len(nrow(rf.pred)))
# gbm.pred2<-gbm.pred %>%
#         mutate(index=seq_len(nrow(gbm.pred)))
# agree<-rf.pred2[rf.pred$y==gbm.pred$y,]
# testing_agree<-testing2[testing2$index %in% agree$index,]
# conf.agree<-confusionMatrix(agree$y,testing_agree$y)

# #Q2
# library(caret)
# 
# library(gbm)
# 
# set.seed(3433)
# 
# library(AppliedPredictiveModeling)
# 
# data(AlzheimerDisease)
# 
# adData = data.frame(diagnosis,predictors)
# 
# inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]
# 
# training = adData[ inTrain,]
# 
# testing = adData[-inTrain,]
# rf.fit<-train(diagnosis~.,training,method='rf')
# gbm.fit<-train(diagnosis~.,training,method='gbm')
# lda.fit<-train(diagnosis~.,training,method='lda')
# rf.pred<-predict(rf.fit,testing)
# gbm.pred<-predict(gbm.fit,testing)
# lda.pred<-predict(lda.fit,testing)
# set.seed(62433)
# rf.accu<-confusionMatrix(rf.pred,testing$diagnosis)$overall[[1]]
# gbm.accu<-confusionMatrix(gbm.pred,testing$diagnosis)$overall[[1]]
# lda.accu<-confusionMatrix(lda.pred,testing$diagnosis)$overall[[1]]
# comb<-data.frame(rf=rf.pred,gbm=gbm.pred,lda=lda.pred,
#                  diagnosis=testing$diagnosis)
# comb.fit<-train(diagnosis~.,comb,method='rf')
# comb.pred<-predict(comb.fit,comb)
# comb.accu<-confusionMatrix(comb.pred,testing$diagnosis)$overall[[1]]

#Q3
# set.seed(3523)
# 
# library(AppliedPredictiveModeling)
# 
# data(concrete)
# 
# inTrain = createDataPartition(concrete$CompressiveStrength, p = 3/4)[[1]]
# 
# training = concrete[ inTrain,]
# 
# testing = concrete[-inTrain,]
# set.seed(233)
# par(mfrow=c(1,1))
# grid<-10^seq(10,-2,length=100)
# lasso.x<-model.matrix(CompressiveStrength~.,training)[,-1]
# lasso.y<-training$CompressiveStrength
# lasso.fit<-glmnet(lasso.x,lasso.y,alpha=1,lambda=grid)

#Q4
# library(lubridate)
# dat<-read_csv('q4.csv')
# dat<-mutate(dat,date=mdy(date))
# training = dat[year(dat$date) < 2012,]
# testing = dat[(year(dat$date)) > 2011,]
# tstrain = ts(training$visitsTumblr)
# bats.fit<-bats(tstrain)
# tstest<-ts(testing)
# bats.pred<-forecast(bats.fit)


# Q5
# set.seed(3523)
# 
# library(AppliedPredictiveModeling)
# 
# data(concrete)
# 
# inTrain = createDataPartition(concrete$CompressiveStrength, p = 3/4)[[1]]
# 
# training = concrete[ inTrain,]
# 
# testing=concrete[-inTrain,]
# set.seed(325)
# svm.fit<-svm(CompressiveStrength~.,training)
# svm.pred<-predict(svm.fit,testing)