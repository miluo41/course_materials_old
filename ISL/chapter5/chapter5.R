library(ISLR)
# 1
# set.seed(1)
# in_train<-sample(10000,5000)
# default.train<-Default[in_train,]
# default.test<-Default[-in_train,]
# 
# glm.fit<-glm(default ~ balance + income +student, data=default.train, family=binomial)
# glm.prob<-predict(glm.fit,default.test,type='response')
# glm.pred<-rep('No',nrow(default.train))
# glm.pred[glm.prob>0.5]<-'Yes'
# mean(glm.pred==default.test$default)
# #2
# library(boot)
# glm.fit<-glm(default ~ income + balance, data=Default, family=binomial)
# boot.fn<-function(data,index){
#         glm.mod<-glm(default ~ income + balance, data, family=binomial,subset=index)
#         return(coef(glm.mod))        
# }
# 
# boot(Default,boot.fn,R=100)

# #3
# 
# set.seed(1)
# y<-rnorm(100)
# x<-rnorm(100)
# y<-x-2*x^2+rnorm(100)
# df<-data.frame(x,y)
# cv.err<-NULL
# for (i in 1:4){
#         glm.fit<-glm(y~poly(x,i),data=df)
#         cv.err[i]<-cv.glm(df,glm.fit)$delta[1]
# }

#4
# library(MASS)
# boot.fn1<-function(data,index){
#         return(mean(data$medv[index]))
# }
# boot(Boston,boot.fn1,R=1000)
# 
# boot.fn2<-function(data,index){
#         return(median(data$medv[index]))
# }
# boot(Boston,boot.fn2,R=1000)
# 
# boot.fn3<-function(data,index){
#         return(quantile(data$medv[index],probs=0.9))
# }
# boot(Boston,boot.fn3,R=1000)