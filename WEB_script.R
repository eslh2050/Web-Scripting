
### Load XML library

library(XML)

url1 <- "http://www.nfl.com/stats/categorystats?tabSeq=0&statisticCategory=PASSING&conference=null&season=2012&seasonType=PRE&d-447263-s=PASSING_YARDS&d-447263-o=2&d-447263-n=1"
url2 <- "http://www.nfl.com/stats/categorystats?tabSeq=0&season=2012&seasonType=PRE&d-447263-n=1&d-447263-o=2&d-447263-p=2&conference=null&statisticCategory=PASSING&d-447263-s=PASSING_YARDS"
url3 <- "http://www.nfl.com/stats/categorystats?tabSeq=0&season=2012&seasonType=PRE&d-447263-n=1&d-447263-o=2&conference=null&statisticCategory=PASSING&d-447263-p=3&d-447263-s=PASSING_YARDS"

table1 <- readHTMLTable(url1,which=1,stringsAsFactors = F)
table2 <- readHTMLTable(url2,which=1,stringsAsFactors = F)
table3 <- readHTMLTable(url3,which=1,stringsAsFactors = F)

nflData <- rbind(table1,table2, table3)

names(nflData)

# clean the data column names 
library(stringr)

?str_sub
names(nflData) <- str_replace_all(names(nflData),"\n","")
names(nflData)

str(nflData)

#### change the types of variables
classes <- c("numeric", rep("character",2),"factor",rep("numeric",16))
classes

### reread the data
url1 <- "http://www.nfl.com/stats/categorystats?tabSeq=0&statisticCategory=PASSING&conference=null&season=2012&seasonType=PRE&d-447263-s=PASSING_YARDS&d-447263-o=2&d-447263-n=1"
url2 <- "http://www.nfl.com/stats/categorystats?tabSeq=0&season=2012&seasonType=PRE&d-447263-n=1&d-447263-o=2&d-447263-p=2&conference=null&statisticCategory=PASSING&d-447263-s=PASSING_YARDS"
url3 <- "http://www.nfl.com/stats/categorystats?tabSeq=0&season=2012&seasonType=PRE&d-447263-n=1&d-447263-o=2&conference=null&statisticCategory=PASSING&d-447263-p=3&d-447263-s=PASSING_YARDS"

table1 <- readHTMLTable(url1,colClasses = classes,which=1,stringsAsFactors = F)
table2 <- readHTMLTable(url2,colClasses = classes,which=1,stringsAsFactors = F)
table3 <- readHTMLTable(url3,colClasses = classes,which=1,stringsAsFactors = F)

nflData <- rbind(table1,table2, table3)

names(nflData)

# clean the data column names 
library(stringr)

?str_sub
names(nflData) <- str_replace_all(names(nflData),"\n","")
names(nflData)

str(nflData)

### plot a dotchart that shows the top15 players based on the "rate" variable in deceding order

indexes <- order(nflData$Rate, decreasing = T)
top15 <- indexes[1:15]

library(ggplot2)

ggplot(nflData[top15,],aes(reorder(Player,Rate), Rate)) + geom_point() + coord_flip() +
  xlab("Rating") +
  ylab("Player") +
  theme_bw()

url4 <- "http://en.wikipedia.org/wiki/List_of_countries_and_dependencies_by_population"
popdata <- readHTMLTable(url4,which=1,stringsAsFactors = F)
str(popdata)
classes= c("integer","character","FormattedNumber","character","character","Percent","character")
popdata <- readHTMLTable(url4,which=1,stringsAsFactors = F,colClasses = classes)
sum(popdata$Population)

install.packages("lubridate")
library(lubridate)
popdata$Date <- mdy(popdata$Date)








