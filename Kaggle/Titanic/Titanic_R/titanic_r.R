library(tidyverse);library(caret);library(modelr)
library(ModelMetrics)
train_set<-read.csv('../data/train.csv')
test_set<-read.csv('../data/test.csv')

training_presplit<-train_set %>% select(-PassengerId,-Name,-Ticket,-Cabin) %>%
        mutate(Survived=as.factor(Survived),Pclass=as.factor(Pclass))
testing<-test_set %>% select(-PassengerId,-Name,-Ticket,-Cabin) %>% 
        mutate(Pclass = as.factor(Pclass))

in_train<-createDataPartition(training_presplit$Survived,p=0.8,list=FALSE)
training<-training_presplit[in_train,]
validation<-training_presplit[-in_train,]

preprocess.mod<-preProcess(training[-1],method=c('center','scale','BoxCox'))
training_processed<-predict(preprocess.mod,training[-1])
validation_processed<-predict(preprocess.mod,validation[-1])
testing_processed<-predict(preprocess.mod,testing)
training_full<-cbind(Survived=training$Survived,training_processed)
validation_full<-cbind(Survived=validation$Survived,validation_processed)

# sapply(training_f,function(x) mean(is.na(x)))
na_to_zero<-function(x){
        if (is.numeric(x)){
                x[is.na(x)]<-0
                return(x)}
        else{
                return(x)
        }
}
train_df<-as.data.frame(lapply(training_full,na_to_zero))
val_df<-as.data.frame(lapply(validation_full,na_to_zero))
test_df<-as.data.frame(lapply(testing_processed,na_to_zero))
# sapply(training_f,function(x) mean(is.na(x)))

ctrl<-trainControl(method='repeatedcv',repeats = 2,number=10)

# nearZeroVar(training_f,saveMetrics = TRUE)

### logistic regression
glm.fit<-train(Survived ~ .,data=train_df,method='glm',trControl=ctrl,
               tuneLength=10)
glm.pred<-predict(glm.fit,val_df)
glm.accu<-mean(glm.pred==val_df$Survived)

##gbm

gbm.fit<-train(Survived ~ .,data=train_df,method='gbm',trControl=ctrl,
               tuneLength=10,trace=FALSE)
gbm.pred<-predict(gbm.fit,val_df)
gbm.accu<-mean(gbm.pred==val_df$Survived)
### svm
svm.fit<-train(Survived ~.,data=train_df,
               method='svmRadial',
               trControl = ctrl,
               tuneLength=5,
               na.action = na.pass)
svm.pred<-predict(svm.fit,val_df)
svm.accu<-mean(svm.pred==val_df$Survived)


### rf
rf.fit<-train(Survived ~.,data=train_df,
                       method='rf',
                       trControl = ctrl,
                       tuneLength=9,
                       na.action = na.pass)
rf.pred<-predict(rf.fit,val_df)
rf.accu<-mean(rf.pred==val_df$Survived)

### lda
lda.fit<-train(Survived ~.,data=train_df,
               method='lda',
               trControl=ctrl,
               tuneLength=5,
               na.action=na.pass)
lda.pred<-predict(lda.fit,val_df)
lda.accu<-mean(lda.pred==val_df$Survived)

val_compile<-data.frame(glm=glm.pred,rf=rf.pred,lda=lda.pred,svm=svm.pred,
                          Survived=val_df$Survived)

create_compile_matrix<-function(df,training_set){
        ctrl<-trainControl(method='repeatedcv',repeats = 2,number=10)
        glm.fit<-train(Survived ~ .,data=training_set,
                       method='glm',
                       trControl=ctrl,
                       tuneLength=5)
        glm.pred<-predict(glm.fit,df)
        
        svm.fit<-train(Survived ~.,data=training_set,
                       method='svmRadial',
                       trControl = ctrl,
                       tuneLength=5,
                       na.action = na.pass)
        svm.pred<-predict(svm.fit,df)
        
        rf.fit<-train(Survived ~.,data=training_set,
                      method='rf',
                      trControl = ctrl,
                      tuneLength=5,
                      na.action = na.pass)
        rf.pred<-predict(rf.fit,df)
        
        lda.fit<-train(Survived ~.,data=training_set,
                       method='lda',
                       trControl=ctrl,
                       tuneLength=5,
                       na.action=na.pass)
        lda.pred<-predict(lda.fit,df)
        
        output<-data.frame(glm=glm.pred,svm=svm.pred,
                           rf=rf.pred,lda=lda.pred)
        output
}

train_compile=create_compile_matrix(train_df,train_df)
train_compile<-cbind(train_compile,train_df)
compile.fit<-train(Survived~., train_compile,
                   method='rf',
                   trControl=ctrl,
                   tuenLength=5,
                   na.action=na.pass)
val_compile<-create_compile_matrix(val_df,train_df)
val_compile<-cbind(val_compile,val_df)
compile.pred<-predict(compile.fit,val_compile)
compile.accu<-mean(compile.pred==val_df$Survived)

test_compile<-create_compile_matrix(test_df,train_df)
test_compile<-cbind(test_compile,test_df)

test.pred<-predict(compile.fit,test_compile)
outfile<-data.frame(PassengerID=test_set$PassengerId,Survived=test.pred)
write.csv(outfile,'titanic_pred.csv')

