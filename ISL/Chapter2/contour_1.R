# ggplot
# x<-seq(-pi,pi,length=50)
# y<-x
# z<-function(x,y){cos(y)/(1+x^2)}
# gg<-expand.grid(x=x,y=y)
# gg$z<-with(gg,z(x,y))
# ggplot(data=gg,aes(x=x,y=y,z=z))+
#         geom_raster(aes(fill=z))+
#         geom_contour(bins=20,color='black')

# base plot
x<-seq(-pi,pi,length=50)
y<-x
f<-outer(x,y,function(x,y)cos(y)/(1+x^2))
contour(x,y,f,nlevels=45)
fa<-(f-t(f))/2
# contour(x,y,fa,nlevels=15)
# image(x,y,fa)
persp(x,y,fa)
persp(x,y,fa,theta=30,phi=20,r=sqrt(3))