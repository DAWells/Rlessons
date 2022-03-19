install.packages("ggplot2")
library(ggplot2)

data(iris)
head(iris)
str(iris)

#first thing you do when you get a data set is look at your distributions
#hist() is a quick easy way to get a histogram
hist(iris$Sepal.Length)

#but the package ggplot2 has lots of options and is easy to export
#the first step is to tell it what data to use and what for

ggplot(iris,aes(x=Sepal.Length))

#add the histogram
#within geom_histogram() change bins or binwidth
#e.g geom_histogram(bins=7)
ggplot(iris,aes(x=Sepal.Length))+geom_histogram()

ggplot(iris,aes(x=Sepal.Length,fill=Species))+geom_histogram()
ggplot(iris,aes(x=Sepal.Length,fill=Species))+geom_histogram(position="identity",alpha=0.4)
ggplot(iris,aes(x=Sepal.Length,fill=Species))+geom_density(alpha=0.4)


data(diamonds)
str(diamonds)
diamonds
#the data is in the form "tibble" not "data.frame"
#only prints the top 10 rows and states the data type

ggplot(diamonds, aes(x=price)) + geom_histogram()
ggplot(diamonds, aes(x=price,fill=cut)) + geom_histogram()

#bar plot
ggplot(diamonds, aes(x=cut))+geom_bar()
ggplot(diamonds, aes(x=cut,fill=cut))+geom_bar()

#Scatter plot#
ggplot(diamonds, aes(x=carat,y=price))
ggplot(diamonds, aes(x=carat,y=price))+geom_point()
ggplot(diamonds, aes(x=carat,y=price,colour=color))+geom_point()

#adding lines
data(Orange)
#make a scatter plot
ggplot(Orange, aes(x=age,y=circumference))+geom_point()

ggplot(Orange, aes(x=age,y=circumference))+geom_point()+geom_smooth()
ggplot(Orange, aes(x=age,y=circumference))+geom_point()+geom_smooth(method="lm")

#make a statisical model
mod<-glm(circumference~age, family="poisson",data=Orange)
summary(mod)

#prediction data
pd<-data.frame(age=0:1600)
pd$circumference<-predict(mod,pd,type="response")
ggplot(Orange, aes(x=age,y=circumference))+geom_point()+geom_line(data=pd)

#scrub up
ggplot(diamonds, aes(x=carat,y=price,colour=color))+geom_point()

ggplot(diamonds, aes(x=carat,y=price,colour=color))+geom_point()+
#change the labels
xlab("Diamond carat")+ylab("Price ($)")+labs(color="Diamond colour")+
#adjust the theme
theme(panel.background=element_rect(fill="white"),axis.line=element_line(colour="black",size=1))

#exporting graphs
#defaults to the last graph and current width
#svg wont become blurry
ggsave("diamond graph.svg")
#tiff will become blurry if you zoom but it is smaller
#you can use dpi to set resolution
ggsave("diamond graph.tiff",dpi=5)