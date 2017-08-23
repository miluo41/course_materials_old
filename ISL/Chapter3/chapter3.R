library(ISLR);library(tidyverse)
#1. Auto %>% ggplot(aes(mpg,horsepower))+geom_smooth(method='lm',se=FALSE)
# lm.fit1<-lm(mpg~horsepower,Auto)
# predict(lm.fit1,data.frame(horsepower=98),interval='confidence')

# 2. 
# pairs(Auto)
# cor(Auto[-9])
# lm.fit2<-lm(mpg~.-name,Auto)
# summary(lm.fit2)

# # 4.
# set.seed(1)
# x<-rnorm(100)
# y<-2*x+rnorm(100)
# # lm.fit4<-lm(y~x-1)
# plot(x,y)
# abline(lm.fit4)
# summary(lm.fit4)$sigma
# summary(lm.fit4)$r.sq
# summary(lm.fit4)$coefficients
# confint(lm.fit4)
# lm.fit4.1<-lm(x~y-1)
# summary(lm.fit4.1)$sigma
# summary(lm.fit4.1)$r.sq
# summary(lm.fit4.1)$coefficients
# confint(lm.fit4.1)

# 13
# x<-rnorm(100,0,1)
# y<--1+0.5*x+rnorm(100,0,0.5)
# lm.fit13<-lm(y~x)
# coef(lm.fit13)
# # plot(x,y)
# # abline(-1,0.5)
# lm.fit13.1<-lm(y~poly(x,2))

#14
# set.seed(1)
# x1<-runif(100)
# x2<-0.5*x1+rnorm(100)/10
# y<-2+2*x1+0.3*x2+rnorm(100)
# cor(x1,x2)
# plot(x1,x2)
# lm.fit14<-lm(y~x1+x2)
# lm.fit14.1<-lm(y~x1)
# lm.fit14.2<-lm(y~x2)
# x1<-c(x1,0.1)
# x2<-c(x2,0.8)
# y<-c(y,6)
# lm.fit14.3<-lm(y~x1+x2)

# 15
library(MASS)
head(Boston)
lm.fit15<-lm(crim~.,Boston)