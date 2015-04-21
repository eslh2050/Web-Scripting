library(stringr)

print("\"")
cat("\"")

a <- ":-\\"
cat(a)
cat("(^_^\")")
cat("@_'-'")
cat("\\m/")

?str_locate
fruit <- c("apple", "banana", "pear", "pinapple")
str_locate(fruit, "a")

?str_sub

str_locate("great","a")
str_locate("fantastic","a")
str_locate("super","a")

fab <- c("great","fantastic","super")
loc <- str_locate(fab,"a")
loc[,1]


#5
str_sub("testing", 1,3)
str_sub("testing", 4,7)

#6.
input <- c("abc","defg")
str_sub(input,2)
str_sub(input,c(2,3))

#7.
emails <- readRDS("email.rds")
head(emails)

print(emails[1])
cat(emails[1])

#8. 
str_locate(emails[1], "\n\n\n\n")

#9. 
header1 <- str_sub(emails[1],end = 842)
cat(header1)
body1 <- str_sub(emails[1],start = 845)
cat(body1)

#10.

lines <- str_split(header1,"\n")[[1]]

#11
continued <- str_sub(lines,1, 1)%in%c("","\t")

groups <- cumsum(!continued)
groups

fields <- rep(NA, max(groups))

for(i in 1:length(fields)){
  
  fields[i] <- str_c(lines[groups == i],
                     collapse = "\n")
}

fields

#12
str_split("content: skjkf shdf",": ")[[1]]

splitField <- function(input,sep){
  
  str_split(input,sep)[[1]]
}

splitField(fields[14], ": ")[2]

library(wordcloud)

?wordcloud

wordcloud(emails)






