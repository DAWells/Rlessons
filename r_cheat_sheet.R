#load data
#put the file location and name in quotes. Remember that all the slashes must be /
data<-read.csv()
data<-read.table()

#subsetting data
	data[data$x>5,] #all rows of data where x is greater than 5
	data[data$y == "a",]$x #x values for all rows of data where x is a

#Plots
hist() #creates a histogram, just put the variable you want to plot in the brackets
plot(x,y) #Can do a variety of plots based on the data type. x variable in first seperated from the y variable by a comma.

#Which test for which question?
#differences between groups?
	#Is there a difference (in a continuous variable) between 2 groups?
	t.test()
	wilcox.test(y~x,data=data,paired=FALSE#Mann whitney U test (non parametric for 2 sample unpaired) (I know the naming is unhelpful)
	wilcox.test(group1,group2,paired=TRUE)#wilcoxon signed-rank test (non parametric 2 sample PAIRED)
	
	#Is there a difference (in a continuous variable) between >2 groups?
	aov() #ANOVA
	kruskal.test()#Kruskal-Wallis test (non parametric)

	#Does your group differ from a specified (continous) value?
	t.test() #one sample t-test

#Contiuous predictor variables?
	cor.test() #Checks for a correlation
	cor.test(,method="spearman") #non-parametric version
	lm() #linear regression
	glm() #general linear regression
	nls() #non linear regression
	drm() #s shaped curve for continuous data (DCeB)
#Predict a categorical from a categorical
	#chi squared contingency table
	#Alternatively (and more easily) use a glm
	
	
t.test()
#There are three kinds of t.test:
#one-sample t-test, compares one-sample to a specified value
t.test(y, mu=100, data=data) # are the y values of data different from 100?
#two-sample unpaired t-test, 
t.test(y~group,data=data) #do the 2 groups have different y values?
#two-sample paired t-test
t.test(a,b) #is group a different from group b? assumes that each sample in the group is paired to the sample at the same position in the other group. eg measuring blood sugar before (group a) and after lunch (group b) the nth individual in each group is the same individual

#By default R uses a "Welches t-test" which does not assume equal variance
#We still have to check that each group is normally distributed
qqnorm(data$x) #note that you must check the normaility of both groups seperately (see the section on subsetting data)

#############################################
#ANOVA
#analysis of variance: do more than 2 groups differ from each other?
#Cannot tell you which groups differ
aov(y~group,data =data)
#Check the usual assumptions: normality and equal variance using:
plot(model)

#to find out which groups differ we can use post hoc test. eg 
TukeyHSD(model)
#you can then plot this
plot(TukeyHSD(model))

#ANCOVA is really the same as a multiple linear regression with both categorical and continuous predictors

#############################################
#correlation test, are two variables correlated?
cor.test(data$x,data$y) #The sample estimate cor is the pearsons correlation coefficient, 0 means no correlation and 1 means the two variables are equal to each other

#linear regression
model<-lm(y~x,data=data)# predict y from x
summary(model) #(Intercept) is the predicted value of y when all the predictors are 0
#linear regression assumes:
	#y is "quantitative and on an interval scale", esentially y is a number
	#a linear relationship
	#normailty of the y value for all combinations of the predictors. check this with a qqplot and plots of the residuals and histogram of the residuals 
	plot(model)
	hist(resid(model))
	#equal variance (homoscedasticity), check this with plots of the residuals
	#independence, you have to know this from the experimental design
	plot() #will also allow you to check for outliers
#plotting a linear model if there is only one predictor
plot(x,y,data=data)
lines(x,predict(m))

#Is the model significantly better than the null model?
nullmodel<-lm(y~1)#create a null model
anova(model,nullmodel) #If there is only one predictor you dont have to create a null model

	#If you are doing multiple regression you must also check that the predictors do not correlate with each other.
	plot(x,z)
	cor(x,z)

#deletion testing for multiple linear regression
model<-lm(y~x+z*w)#there is an interaction between z and w
drop1(model, test="Chisq")# drops each predictor seperately and tests if the reduced model is significantly worse. test can be "Chisq" or "F"

#remember that if the interaction is important (ie its drop1 is significant) you cannot remove either of the terms it is made of

#Not all data is normal and we either cant or dont want to transform them
glm(y~x,data=data,family=)
#its very similar to lm() except for the family argument. some potential family values are. poisson, binomial.
#poisson is for counts eg y=birds in a tree, we might also use it for things that cannot be negative such as height (although as the mean of our distribution gets bigger poisson and normal are very similar
#binomial gives the probability of a certain number of successes out of n trials. eg 20 insects out of 32 were killed by the pesticide. can be used for 0/1 events like the above example except each insect is treated as its own trial 0 it survived, 1 it died. 

#There are two common types of binomial logit and probit. to specify probit use family=binomial("probit")
#get the dose that is predicted to yeild a specified proportion of the maximum response
dose.p(model,c(0.1,0.9))#gets the dose for 10% and 90% of the total response

#assumptions
#normality
#equal variance
#linear relation -- only for linear regression
#no colinearity -- only for multiple regression
#independence

hist()

#the model not the data
qqplot()

#when given a model it will allow you to assess the assumptions of the model
plot()


#Non-linear modelling when you are told which equiation to use (eg Michaelis-Menten)
#The equation is rate ~ Vm * conc/(K + conc)
#You are trying to predict the rate from the conc, Vm and K are parameters to estimate from the data.
#or it can be more complicated eg Vm and/or K may or may not differ depending on a seperate variable, state.
#If it were linear it would be rate~conc+state (where state is categorical)
#however we've been told it is not linear, but instead follows the equation above
nls(rate~Vm[state]*conc/(K[state]+conc),start=list(Vm=c(0.1,0.1),K=c(10,10)) #This estimates a seperate Vm and K for both states, that is why we have to supply 2 starting values for Vm and K
#To run a model with only one estimate of k or vm, simply delete the appropriate [state] and one of the starting values for k or vm respectively

#log logistic regression with the important values of the s curve (DCEb)
#This can also be used to predict continuous variables with an s curve
drm(y~x, fct=LL.4())
drm(y~x, fct=LL.3()) #without C
#if you wanted to estimate a seperate DCEb for each state just include the name of the state collumn like so
drm(y~x, state, fct=LL.4())
#calculate the dose to give you x% of the max response
ED(model,c(10,50) #gives you the dose to get 10% and 50%


#deletion testing
#for glm() models
drop1()
#Start with your maximal model then use the drop1() function to see which terms without making the model significantly worse. Choose the least significant one and make a new model without it then do drop1() again. repeat until all the terms remaining make the model significantly better. If they ask you to use the AIC values remember that a lower AIC is better

#some times you cant use drop1, just because it doesnt work
#then you have to create the model you are testing and the simplified version. and compare them with the anova function()
anova(model1,model2) #if it is significant the more complex model is better
#this doesnt always return a p-value, it depends on the type of model. then put the deviance and Df values (returned by the anova function) into the pchisq function and take the whole lot away from 1
1-pchisq(deviance, Df) #this gives you a pvalue


#Advanced plot
#multiple regression with one continuous variable and one categorical
#the response variable in the eg is bodywt, sleep_total is a continuous predictor, vore is a categorical predictor
install.packages("lattice")
library(lattice)
xyplot(bodywt~sleep_total|vore, data=msleep,panel=function(x,y){llines(x = x, y = fitted(lm(y ~ x))) + lpoints(x = x, y = y) })