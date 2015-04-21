
install.packages(c("devtools","rjason","bit64,httr"))
library(devtools)
install_github("twitteR",username="geoffjentry")
library(twitteR)

api_key <- "WkmKlwY4KcMW1wESMXBvGC80j"
api_secret <- "5b3bbD1Ocg0qVRUCeU8RGXnPTzAV28I5GHZxIjcUXtIkfOSsAg"
access_token <- "270408448-53sWXLLvYHzmxrGv953rigSRTMQPdwo3lyown9TO"
access_token_secret <- "fqVU0padon7DO44N8ClWq7qBTtVpCtpoIDPPH2wmYaPVg"


setup_twitter_oauth(api_key,api_secret,access_token,access_token_secret)

##### What people talking about USC?

uscTweets <- searchTwitter("usc")
head(uscTweets)

dfTweet <- twListToDF(uscTweets)
head(dfTweet)
tweetText <- dfTweet$text

##### What is Abbass is tweeting about?
user <- getUser("abbass_sharif")
abbass <- userTimeline(user, n = 500)
abbassDF <- twListToDF(abbass)
abbassText <- abbassDF$text

head(abbassText)

# get the hashtags
library(stringr)
abbassHashTags <- str_extract_all(abbassText,"#\\w+")
abbassHashTags

freq <- table(unlist(abbassHashTags))
freq

install.packages("wordcloud")
library(wordcloud)

wordcloud(names(freq),freq,colors="red")
title("What is Abbass tweeting about?\n\n")



