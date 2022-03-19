data(iris)
head(iris)
str(iris)

#first thing you do when you get a data set is look at your distributions
#hist() is a quick easy way to get a histogram
hist(iris$Sepal.Length)
#you can set colour with col 
#try colour names eg "red" or hexidecimal eg "#f9d33c"

#get data by Species
iris[iris$Species=="setosa",]
iris[iris$Species=="setosa",]$Sepal.Length

hist(iris[iris$Species=="setosa",]$Sepal.Length,col=rgb(1,0,1,0.4),
xlim=c(4,8),ylim=c(0,15),breaks=7)
hist(iris[iris$Species=="versicolor",]$Sepal.Length,col=rgb(1,1,0,0.4),add=TRUE,breaks=10)
hist(iris[iris$Species=="virginica",]$Sepal.Length,col=rgb(0,1,1,0.4),add=TRUE,breaks=12)

data(ChickWeight)
head(ChickWeight)

#make another histogram using the ChickWeight data
#of weight and coloured by diet
hist(ChickWeight[ChickWeight$Diet==1,]$weight,col=rgb(1,0,0,0.4))
hist(ChickWeight[ChickWeight$Diet==2,]$weight,col=rgb(0,1,0,0.4),add=T)
hist(ChickWeight[ChickWeight$Diet==3,]$weight,col=rgb(1,0,1,0.4),add=T)
hist(ChickWeight[ChickWeight$Diet==4,]$weight,col=rgb(1,1,0,0.4),add=T)

#boxplot
#if you put a factor along the x axis, R knows to plot it as a box plot
plot(x=ChickWeight$Diet,y=ChickWeight$weight)

#scatterplot
plot(x=ChickWeight$Time,y=ChickWeight$weight)
plot(x=ChickWeight$Time,y=ChickWeight$weight,col=ChickWeight$Diet)
plot(x=ChickWeight$Time,y=ChickWeight$weight,col=ChickWeight$Diet,pch=16,cex=1.4)

#adding trend lines
data(Orange)
head(Orange)

#make a scatter plot age vs circumference
plot(x=Orange$age,y=Orange$circumference)

#make a statisical model
mod<-glm(circumference~age, family="poisson",data=Orange)
summary(mod)

#prediction data
pd<-data.frame(age=0:1600)
pd$circumference<-predict(mod,pd,type="response")
lines(pd)

#scrub up
plot(x=Orange$age,y=Orange$circumference,xlab="Orange tree age",
ylab="Orange tree circumference",main="Orange tree growth")
lines(pd)

#change font size with cex.lab, cex.axis and cex.main

svg("orange.svg",width=5,height=4)
dev.off()

ppi<-150
png("orange.png",width=5*ppi,height=4*ppi)
dev.off()


