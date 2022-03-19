#Introduction to linear models
# This class will teach you to:
#1 assess the assumptions of a linear regression model:
  #normality, equal variance, independence, outliers, colinearity, linear relation
#2 run a lm
#3 interpret a lm
  #significanc, r^2, beta values, SE, 95% CI

library(ggplot2)
data(iris)

######################
#We want to predict petal length from petal width and species
#first we check normality of the response variable
hist(iris$Petal.Length)

#Remember the assumption of normality is actually that the response variable is normally distributed for a given value of the predictor variables
#so we plot seperate histograms for each value of predictor variable: species
ggplot(iris,aes(x=Petal.Length,fill=Species))+geom_density(alpha=0.5)

#check equal variance, outliers, and a linear relationship all at once
plot(iris$Petal.Width,iris$Petal.Length,col=iris$Species)

#Creat your model
#lm() is the function for a linear model
#what you are trying to predict comes first eg Petal.Length
# "~" means predicted by
i1<-lm(Petal.Length~Petal.Width,data=iris)
summary(i1)

#Now we have to check that our model worked
#If the model is correctly specified there should not be any trends in the residuals and the variance should be constant

#to check this we calculate the predicted values and the residuals
pred<-predict(i1)

#Residuals are how wrong your predictions were (real value - predicted value)
E<-resid(i1)
plot(E,iris$Petal.Length-pred)

#Double check the assumption of normality with the residuals
hist(E)

#plot the residuals against the predicted values and each explanatory variable in turn
plot(pred,E)
plot(iris$Petal.Width,E)
plot(iris$Species,E)
#for simple models plot() will do this and more for you
plot(i1)

#It looks like $Species is causing problems with your model
#Create a new model which includes $Species
i2<-lm(Petal.Length~Petal.Width+Species,data=iris)
plot(i2)

#Write your own code to check the model as before.
#Do you think the assumptions of the model are met?

#what does the summary tell us?
summary(i2)
#Residuals: are the difference between predicted and observed Petal:Length
#Coefficients: the parameters that we use to predict Petal.Length
#Standard errors are a measure of how close your values are to the true values
#R-squared is a measure of how well your model explains the data
#The final line gives the result of an f-test and it shows that this model is significantly better than the null model

#Is i2 better than i1? When comparing models like this they must be "nested"
anova(i1,i2,test="F")

#############
#Task 2
#Load the dataframe which comes with ggplot2
data(msleep)
#look at your data with str()
str(msleep)
#the data type chr (character) means its a string and not suitable for analysis

#We will predict sleep_total from body_wt, brain_wt and vore

#remove missing data
msleen<-msleep[which(!is.na(msleep$brainwt) & !is.na(msleep$vore)),]

#change msleep$vore into a factor
msleen$vore<-as.factor(msleen$vore)

levels(msleen$vore)
#reorder factor levels
msleen$vore<-relevel(msleen$vore,ref="omni")

#The assumption of normality applies only to the response variable
#Checking the distribution is a good start but the residuals must also be checked
hist(msleen$sleep_total)

#Plot each of the explanatory variables against the response variable in turn
#Check for a linear relation, equal variance and outliers
plot(msleen$bodywt,msleen$sleep_total)
plot(log(msleen$bodywt),msleen$sleep_total)

plot(msleen$brainwt,msleen$sleep_total)
plot(log(msleen$brainwt),msleen$sleep_total)

plot(msleen$vore,msleen$sleep_total)

ggplot(msleen,aes(x=log(bodywt),y=sleep_total,colour=vore))+geom_point()

s1<-lm(sleep_total~bodywt+brainwt+vore,data=msleen)
#plot() is a handy short hand but it doesnt work for more complex models
#So you will have to know how to do it by hand
plot(s1)
#has some big problems with outliers

#Often you would omit the outliers and refit the model but in this case we can just use log() because our data cover an enormous range (shrew-elephant)
s2<-lm(sleep_total~log(bodywt)+log(brainwt)+vore,data=msleen)
#what does this mean?
summary(s2)

plot(s2)

#check for covariance: This should be done before modeling but I saved it for dramatic effect
library(car)
vif(s2) #VIF scores above 2 are a little troubling, over 5 is a big problem
plot(log(msleen$bodywt),log(msleen$brainwt))
#They are highly colinear which can cause problems

#Colinearity means the model struggles to correctly partition the variance between the colinear terms.
#In short, it cannot tell which is important bodywt or brainwt
#We have to pick one to remove based on our knowledge of the system 
s3<-lm(sleep_total~log(brainwt)+vore,data=msleen)
summary(s3)
#Validate model: normality, equal variance, colinearity, independence

#Interpretation and significance of the model

#################
#Final tasks load the data(Baumann)
#predict post.test1 from group and pretest.1
#check all the assumptions of the test and interpret the model and assess the significance of predictor variables

##################

#Please send me any questions or feedback