library(stringr)
contents <- readRDS("email.rds")

length(contents)
contents[1]

breaks <- str_locate(contents, "\n\n")
header <- str_sub(contents, end = breaks[, 1] - 1)
body <- str_sub(contents, start = breaks[, 2] + 1)

fruit <- c("apple", "banana", "peer", "pinapple")

str_detect(fruit, "a")
str_detect(fruit, "^a")
str_detect(fruit, "a$")
str_detect(fruit, "[aeiou]")
str_detect(fruit, "[a-d]")

#3
str_detect(fruit, "^a[a-z]*e$")

#4
phones = c("213 740 4826","213-340-4826","(213) 740 4826","340 4826", "325 2346 1234")
str_detect(phones, "^([(]?[0-9]{3}[)]?[ -])?[0-9]{3}[ -][0-9]{4}$")

#5
cat(contents[10])
cat(contents[18])

parser <-  "([(]?[0-9]{3}[)]?[ -])?[0-9]{3}[ -][0-9]{4}"

str_detect(body[10],parser)
str_locate_all(body[10], parser)
str_extract_all(body[10],parser)
cat(body[10])

nums <- str_extract_all(body[10],parser)

nums[[1]][1]

dates<- c("10/14/1979","60/20/1945","1/1/1905","5/5/5","12/65/2015")
str_detect(dates,"^[01]?\\d/[0-3]?[0-9]/\\d{1,4}")


