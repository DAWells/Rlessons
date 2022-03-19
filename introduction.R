#R lesson: introduction
#console is where your code is actually run and where you get answers
1+1
4==5
4!=5
9%%2
#you can use the up and down arrows to rerun previous lines of code

#Script files are a better place to write your code
#because you can edit and scroll through it more easily
#to run code from the script file press ctrl+r to run a whole line
#or a highlighted section

#assigning variables
x<-5
x*2
"x"
#print is a function. arguments go in the brackets
print(x)
print("x")
print(hello)

#viewing data
data(iris)
iris
head(iris)
tail(iris)
str(iris)

#saving and loading data
#you can reassign you data.frame to a new variable
data<-iris
head(data)
#to load or save data you need to check which folder you want to use
getwd()
setwd("C:/User/MyFolder")

#to save the iris data.frame in you new working directory
write.csv(iris,"my_iris_data.csv")
#to load a file from your new working directory
newdata<-read.csv("my_iris_data.csv")
#note that you can assign the data whatever name you want,
#not just "newdata"

#access your data
iris$Species
hist(iris$Petal.Length)

iris[7,]
iris[7,5]
iris[,5]

#access only the setosa data
which(iris$Species == "setosa")
iris[which(iris$Species == "setosa"),]

#data driven categories
#creat a new column for sepal length as a factor
iris$slf<-"M"
which(iris$Sepal.Length>6.5)
iris[which(iris$Sepal.Length>6.5),]
iris[which(iris$Sepal.Length>6.5),]$slf
iris[which(iris$Sepal.Length>6.5),]$slf<-"L"

iris[which(iris$Sepal.Length<5.5),]$slf<-"S"

#reordering your dataframe
iris<-iris[order(iris$Sepal.Length),]

names(iris)
names(iris)<-c("sl","sw","pl","pw","Species","slF")
names(iris)[5]<-"species"

#plot species against sepal length
#remmeber to use your new column names, use str() to look them up
plot(iris$species,iris$sl)


#Compare dataframes
#give you plants id numbers in a new column
#two numbers seperated by a colon creates a sequence between those numbers
iris$plantid<-1:150

#imagine you're given a second list
#of all the plants that have been eaten by slugs
slugs<-54:83

#add a new column saying whether they have been eaten by slugs or not
iris$slug<-FALSE
#match tells you if and where each item in the first list
#occurs in the second list
#it only returns the first occurance though!
match(slugs,iris$plantid)

iris[match(slugs,iris$plantid),]
iris[match(slugs,iris$plantid),]$slug
iris[match(slugs,iris$plantid),]$slug<-TRUE
#make iris$slug a factor for good plots
iris$slug<-as.factor(iris$slug)

plot(iris$species,iris$slug)

#*#Final Tasks#*#
#load the ChickWeight data using data()

#rename the columns so they're all lower case

#calculate average weight using mean()

#return the first row of the ChickWeight data

#calculate the average weigth for each diet seperately

#create a new column called group and set it to "M" for all chicks

#Edit the dataframe so that group is "L" if weight is greater than
#the average for diet 4


#please send any feed back, topic suggestions for future R workshops or questions
#to me: d.a.wells@2016.ljmu.ac.uk