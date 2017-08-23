test<-read.csv('../data/test.csv')
train<-read.csv('../data/train.csv')
test$Survived<-NA
combi<-rbind(train,test)
combi$Name<-as.character(combi$Name)
tmp<-combi$Name[1]
strsplit(tmp,split='[,.]')[[1]][2]
# This following is wrong!
# combi$Title<-strsplit(combi$Name,split='[,.]')[[1]][2]
combi$Title<-sapply(combi$Name,function(x){strsplit(x,split='[,.]')[[1]][2]})
combi$Title
combi$Title<-sub(' ','',combi$Title)
combi$Title
table(combi$Title)
combi$Title[combi$Title %in% c('Mlle','Mme')]<-'Mlle'
table(combi$Title)
combi$Title[combi$Title %in%  c('Capt', 'Don', 'Major', 'Sir')]<-'Sir'
combi$Title[combi$Title %in% c('Dona', 'Lady', 'the Countess', 'Jonkheer')]<-'Lady'
table(combi$Title)
combi$Title<-as.factor(combi$Title)
combi$family_size<-combi$SibSp+combi$Parch+1
combi$Surname<-sapply(combi$Name,function(x){strsplit(x,split='[,.]')[[1]][1]})
combi$FamilyId<-paste0(as.character(combi$family_size),combi$Surname)
combi$FamilyId[combi$family_size<=2]<-'small'
table(combi$FamilyId)
famIDs<-data.frame(table(combi$FamilyId))
View(famIDs)
famIDs<-famIDs[famIDs$Freq<=2,]
combi$FamilyId[combi$FamilyId %in% famIDs$Var1]<-'small'
table(combi$FamilyId)
combi$FamilyId<-as.factor(combi$FamilyId)
train<-combi[1:891,]
test<-combi[892:1309,]

fit <- rpart(Survived ~ Pclass + Sex + Age + SibSp + Parch + Fare + Embarked + Title + family_size+ FamilyId,
             data=train,method = 'class')

prediction<-predict(fit,test,type='class')

############################################################################################

age.fit<-rpart(Age ~ Pclass + Sex + SibSp + Parch + Fare + Embarked + Title + family_size,
               data=combi[!is.na(combi$Age),],method='anova')
combi$Age[is.na(combi$Age)]<-predict(age.fit,combi[is.na(combi$Age),])

summary(combi)
which(is.na(combi$Age))
combi$Embarked[which(combi$Embarked=='')]<-'S'
combi$Embarked<-as.factor(combi$Embarked)
combi$Fare[which(is.na(combi$Fare))]<-median(combi$Fare,na.rm = TRUE)

combi$FamilyId2<-as.character(combi$FamilyId)
combi$FamilyId2[combi$family_size<=3]<-'small'
combi$FamilyId2<-as.factor(combi$FamilyId2)
train<-combi[1:891,]
test<-combi[892:1309,]
library(randomForest)
set.seed(415)
rf.fit<-randomForest(as.factor(Survived) ~ Pclass + Sex + Age + SibSp + Parch + Fare +
                             Embarked + Title + family_size + FamilyId2,data=train,
                     importance=TRUE,ntree=2000)

varImpPlot(rf.fit)
library(party)
set.seed(123)
c.fit<-cforest(as.factor(Survived)~Pclass + Sex + Age + SibSp + Parch + Fare +
                       Embarked + Title + family_size + FamilyId,
               data = train, 
               controls=cforest_unbiased(ntree=2000, mtry=3))

Prediction <- predict(c.fit, test, OOB=TRUE, type = "response")
df4<-data.frame(PassengerId=test$PassengerId,Survived=Prediction)
write.csv(df4,'cforest.csv',row.names = FALSE)
