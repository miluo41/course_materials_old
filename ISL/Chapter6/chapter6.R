library(ISLR)
library(leaps)
library(pls)
library(glmnet)
#1
# set.seed(1)
# X<-rnorm(100)
# e<-rnorm(100)
# b0<-1
# b7<-7
# df<-data.frame(X7=X^7,Y=b0+b7*X^7+e)
# 
# # reg.fit<-regsubsets(Y~.,df)
# # reg.summary<-summary(reg.fit)
# # reg.fwd<-regsubsets(Y~.,df,method='forward')
# # fwd.summary<-summary(reg.fwd)
# # reg.bac<-regsubsets(Y~.,df,method='backward')
# # bac.summary<-summary(reg.bac)
# # reg.seq<-regsubsets(Y~.,df,method='seqrep')
# # seq.summary<-summary(reg.seq)
# # X<-model.matrix(Y~.,df)[,-1]
# # Y<-df$Y
# # grid<-10^seq(10,-2,length.out = 100)
# # lasso.mod<-glmnet(X,Y,alpha=1,lambda=grid)
# # cv.out<-cv.glmnet(X,Y,alpha=1)
# # plot(cv.out)
# # best.lambda<-cv.out$lambda.min
# # lasso.pred<-predict(lasso.mod,s=best.lambda,newx=X)
# # lasso.mse<-mean((lasso.pred-df$Y)^2)

#2
