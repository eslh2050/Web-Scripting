library(dplyr)
library(hflights)

hflights <- tbl_df(hflights)
head(hflights)
?hflights
glimpse(hflights)

unique(hflights$UniqueCarrier)

#1
lut <- c("AA" = "American", "AS" = "Alaska", "B6" = "JetBlue", 
         "CO" = "Continental", "DL" = "Delta", "OO" = 
           "SkyWest", "UA" = "United", "US" = "US_Airways", 
         "WN" = "Southwest", "EV" = "Atlantic_Southeast", "F9" 
         = "Frontier", "FL" = "AirTran", "MQ" = "American_Eagle", 
         "XE" = "ExpressJet", "YV" = "Mesa")

hflights$UniqueCarrier <- lut[hflights$UniqueCarrier]
glimpse(hflights)

#2
#### filter, select and then summarize

#3
names(hflights)

select(hflights, ArrDelay, DepDelay)

#4
select(hflights, Origin:Cancelled)

#5
select(hflights, Year:DayOfWeek, ArrDelay:Diverted)

select(hflights, -5:10)

#6
select(hflights, matches("ArrDelay"),matches("DepDelay"))
select(hflights, ends_with("Delay"))

#7
select(hflights, UniqueCarrier, ends_with("Num"),starts_with("Cancell"))

#8

#9
names(hflights)
mutate(hflights, GroundTime = TaxiIn + TaxiOut)

#10

filter(hflights, Distance >3000)

#11
filter(hflights, UniqueCarrier %in% c("JetBlue","SouthWest","Delta"))

#12
filter(hflights, TaxiIn + TaxiOut > AirTime)

#13
filter(hflights, DepTime <500 | ArrTime >2200)

#14
filter(hflights, DepDelay >0, ArrDelay <0)

#15
head(hflights)
filter(hflights, Cancelled & DayOfWeek >5)

#16
arrange(hflights, UniqueCarrier, desc(DepDelay))

#17

#18
arrange(filter(hflights, Dest =="DFW", DepTime <800), desc(AirTime))

filter(hflights, Dest =="DFW", DepTime <800) %>%
  arrange(desc(AirTime))

#19

summarize(hflights, min_dist = min(Distance), max_dist=max(Distance))

#20

#21

#22
hflights %>%
  mutate(diff = (TaxiIn - TaxiOut))%>%
  filter(!is.na(diff)) %>%
  summarize(avg = mean(diff))

#23

#24
library(RMySQL)
my_db <- src_mysql(dbname ="dplyr",
                   host = "dplyr.csrrinzqubik.us-east-1.rds.amazonaws.com",
                   port = 3306, user = "dplyr", password ="dplyr")
nycflights <- tbl(my_db,"dplyr")

glimpse(nycflights)









