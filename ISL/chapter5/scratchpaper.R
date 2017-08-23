# library(ISLR)
# dim(Auto)
# set.seed(1)
# in_train<-sample(392,196)
# lm.fit<-lm(mpg ~ poly(horsepower,1),data=Auto,subset=in_train)
# lm.pred<-predict(lm.fit,Auto[-in_train,])
# MSE.lm<-mean((Auto[-in_train,]$mpg-lm.pred)^2)
# 
# in_train<-sample(392,196)
# lm.fit2<-lm(mpg ~ poly(horsepower,2),data=Auto,subset=in_train)
# lm.pred2<-predict(lm.fit2,Auto[-in_train,])
# MSE.lm2<-mean((Auto[-in_train,]$mpg-lm.pred2)^2)
# 
# c(MSE.lm,MSE.lm2)
# 
# set.seed(2)
# in_train<-sample(392,196)
# lm.fit_new<-lm(mpg ~ poly(horsepower,2),data=Auto,subset=in_train)
# lm.pred_new<-predict(lm.fit_new,Auto[-in_train,])
# MSE_new<-mean((Auto[-in_train,]$mpg-lm.pred_new)^2)
# library(boot)
# cv.err<-NULL
# for (i in 1:10){
#         glm.fit<-glm(mpg ~ poly(horsepower,i),data=Auto)
#         cv.err[i]<-cv.glm(Auto,glm.fit,K=10)$delta[1]
# }

# alpha.fn<-function(data,index){
#         X<-data$X[index]
#         Y<-data$Y[index]
#         return((var(Y)-cov(X,Y))/(var(X)+var(Y)-2*cov(X,Y)))
# }
# boot(Portfolio,alpha.fn,R=1000)

# boot.fn<-function(data,index){
#         return(coef(lm(mpg ~ horsepower,data=Auto,subset=index)))
# }
# boot(Auto,boot.fn,R=1000)