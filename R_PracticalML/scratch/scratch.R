library(caret)
library(AppliedPredictiveModeling)
set.seed(3433)
data(AlzheimerDisease)
adData = data.frame(diagnosis,predictors)
inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]
training = adData[ inTrain,]
testing = adData[-inTrain,]

training<-training %>% select(starts_with('IL'),diagnosis)
glm.pca.fit<-train(diagnosis ~.,data=training,
                   trControl=trainControl(preProcOptions=list(thresh=0.8)),
                   preProcess='pca',method='glm')

glm.fit<-train(diagnosis ~.,data=training,method='glm')
glm.pca.pred<-predict(glm.pca.fit,testing)
glm.pred<-predict(glm.fit,testing)
confusionMatrix(glm.pca.pred,testing$diagnosis)
confusionMatrix(glm.pred,testing$diagnosis)

