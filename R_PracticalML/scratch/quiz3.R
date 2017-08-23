# #Q1
# library(AppliedPredictiveModeling);library(pryr)
# data(segmentationOriginal)
# library(caret)
# Seg<-segmentationOriginal
# training<-Seg[Seg$Case=='Train',]
# testing<-Seg[Seg$Case=='Test',]
# set.seed(125)
# cart.fit<-train(Class~.,method='rpart',data=training)
# # 
# # A<-data.frame(TotalIntench2=23000,iberWidthCh1 = 10,PerimStatusCh1=2)
# print(cart.fit$finalModel)

#Q3
# library(tidyverse)
# tree.fit<-train(Area~.,data=olive,method='rpart')
# predict(tree.fit,newdata = as.data.frame(t(colMeans(olive))))

#Q4
# library(ElemStatLearn)
# data(SAheart)
# set.seed(8484)
# train = sample(1:dim(SAheart)[1],size=dim(SAheart)[1]/2,replace=F)
# trainSA = SAheart[train,]
# testSA = SAheart[-train,]
# set.seed(1234)
# trainSA<-subset(trainSA,select=-c(sbp,adiposity,famhist))
# glm.fit<-train(chd~.,data=trainSA,method='glm',family='binomial')
# train.pred<-predict(glm.fit,trainSA)
# train.val<-trainSA$chd
# test.pred<-predict(glm.fit,testSA)
# test.val<-testSA$chd
# missClass <- function(values,prediction){
#         sum(((prediction > 0.5)*1) != values)/length(values)
# }
# missClass(train.val,train.pred)
# missClass(test.val,test.pred)

#Q5
library(ElemStatLearn)
data(vowel.train)
data(vowel.test)
vowel.train<-vowel.train %>% mutate(y=as.factor(y))
vowel.test<-vowel.test %>% mutate(y=as.factor(y))
set.seed(33833)
rf.caret<-train(y~.,data=vowel.train,method='rf')
rf.rf<-randomForest(y~.,data=vowel.train)
