
Auto.num<-Auto[sapply(Auto,is.numeric)]
Auto.range<-lapply(Auto.num,range)
fun.c<-function(x){
        c(mean(x),sd(x))
}

Auto.mean.sd<-lapply(Auto.num,fun.c)
Auto.sub<-Auto.num[-(10:85),]
Auto.sub.mean.sd<-lapply(Auto.sub,fun.c)