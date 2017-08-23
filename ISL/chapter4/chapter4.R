#1
# library(ISLR);library(MASS);library(e1071);library(class)
# glm.fit<-glm(Direction ~ Lag1 + Lag2 +
#              Lag3 + Lag4 + Lag5 + Volume,family=binomial,data=Weekly)
# glm.prob<-predict(glm.fit,type='response')
# glm.pred<-rep('Down',nrow(Weekly))
# glm.pred[glm.prob>0.5]<-'Up'
# table(glm.pred,Weekly$Direction)
# mean(glm.pred==Weekly$Direction)
# train<-Weekly$Year<2009
# # glm.fit1<-glm(Direction ~ Lag2,data=Weekly,family=binomial,subset=train)
# # Weekly.test<-Weekly[!train,]
# # glm.prob1<-predict(glm.fit1,Weekly.test,type='response')
# # glm.pred1<-rep('Down',nrow(Weekly.test))
# # glm.pred1[glm.prob1>0.5]<-'Up'
# # table(glm.pred1,Weekly.test$Direction)
# # mean(glm.pred1==Weekly.test$Direction)
# results<-c(glm=0.625)
# 
# Weekly.train<-Weekly[Weekly$Year<2009,]
# Weekly.test<-Weekly[Weekly$Year>=2009,]
# lda.fit<-lda(Direction ~ Lag2,data=Weekly.train)
# lda.pred<-predict(lda.fit,Weekly.test)
# table(lda.pred$class,Weekly.test$Direction)
# mean(lda.pred$class==Weekly.test$Direction)
# results<-c(results,lda=0.625)
# 
# qda.fit<-qda(Direction ~ Lag2,Weekly.train)
# qda.pred<-predict(qda.fit,Weekly.test)
# mean(qda.pred$class==Weekly.test$Direction)
# results<-c(results,qda=0.586)
# 
# train.X<-matrix(Weekly.train$Lag2)
# train.Y<-matrix(Weekly.train$Direction)
# test.X<-matrix(Weekly.test$Lag2)
# knn.pred<-knn(train.X,test.X,train.Y,k=1)
# mean(knn.pred==Weekly.test$Direction)
# 
# results<-c(results,knn=0.509)

#2
# library(caret)
# mpg.median<-median(Auto$mpg)
# mpg01<-as.numeric(Auto$mpg>mpg.median)
# Auto1<-data.frame(Auto,mpg01)
# in_train<-createDataPartition(Auto1$mpg01,p=0.7,list=FALSE)
# Auto.train<-Auto1[in_train,]
# Auto.test<-Auto1[-in_train,]
# glm.fit<-glm(mpg01 ~ cylinders + displacement + horsepower +
#                      weight + acceleration + year +origin,
#              data=Auto1,family=binomial)
# lda.fit<-lda(mpg01 ~ year + weight,data=Auto.train)
# lda.pred<-predict(lda.fit,Auto.test)$class
# mean(lda.pred==Auto.test$mpg01)
# 
# qda.fit <-qda(mpg01 ~ year + weight,data=Auto.train)
# qda.pred<-predict(qda.fit,Auto.test)$class
# mean(qda.pred==Auto.test$mpg01)
# 
# train.X<-Auto.train[,c('year','weight')]
# test.X<-Auto.test[,c('year','weight')]
# train.Y<-Auto.train$mpg01
# knn.pred<-knn(train.X,test.X,train.Y,1)
# mean(knn.pred==Auto.test$mpg01)

# Power<-function(){
#         2^3
# }
# Power2<-function(x,a){
#         x^a
# }
# 
# Power3<-function(x,a){
#         results<-x^a
#         return(results)
# }
# PlotPower<-function(x,a){
#         y<-Power3(x,a)
#         plot(x,y)
# }
crim.mean<-mean(Boston$crim)
crim.stat<-rep('Above',nrow(Boston))
crim.stat[Boston$crim<crim.mean]<-'Below'
Boston2<-cbind(Boston,crim.stat)
in_train<-createDataPartition(Boston2$crim.stat,p=0.7,list=FALSE)
Boston.train<-Boston2[in_train,]
Boston.test<-Boston2[-in_train,]
glm.fit<-glm(crim.stat ~ . -crim -crim.stat -tax -chas,data=Boston.train,family=binomial)
glm.prob<-predict(glm.fit,Boston.test,type='response')
glm.pred<-rep('Below',nrow(Boston.test))
glm.pred[glm.prob<0.5]<-'Above'
mean(glm.pred==Boston.test$crim.stat)
table(glm.pred,Boston.test$crim.stat)

lda.fit<-lda(crim.stat ~ . -crim -crim.stat -tax -chas,data=Boston.train)
lda.pred<-predict(lda.fit,Boston.test)
mean(lda.pred$class==Boston.test$crim.stat)

train.X<-Boston.train[,!names(Boston.train) %in% c('crim.stat','crim','tax','chas')]
train.Y<-Boston.train[,'crim.stat']
test.X<-Boston.test[,!names(Boston.train) %in% c('crim.stat','crim','tax','chas')]
knn_tune<-function(k){
        results<-c()
        names<-1:10
        for(i in 1:k){
                knn.pred<-knn(train.X,test.X,train.Y,k)
                accuracy<-mean(knn.pred==Boston.test$crim.stat)
                results<-c(results,accuracy)
        }
        names(results)<-1:10
        plot(1:10,results)
        return(results)
}