## for more details, 
## https://sites.google.com/site/miningtwitter/questions/sentiment/analysis

library(twitteR)
library(plyr)
library(stringr)

# function score.sentiment
score.sentiment = function(sentences, pos.words, neg.words, .progress='none')
{
  # Parameters
  # sentences: vector of text to score
  # pos.words: vector of words of postive sentiment
  # neg.words: vector of words of negative sentiment
  # .progress: passed to laply() to control of progress bar
  
  # create simple array of scores with laply
  scores = laply(sentences,
                 function(sentence, pos.words, neg.words)
                 {
                   # remove punctuation
                   sentence = gsub("[[:punct:]]", "", sentence)
                   # remove control characters
                   sentence = gsub("[[:cntrl:]]", "", sentence)
                   # remove digits?
                   sentence = gsub('\\d+', '', sentence)
                   
                   # define error handling function when trying tolower
                   tryTolower = function(x)
                   {
                     # create missing value
                     y = NA
                     # tryCatch error
                     try_error = tryCatch(tolower(x), error=function(e) e)
                     # if not an error
                     if (!inherits(try_error, "error"))
                       y = tolower(x)
                     # result
                     return(y)
                   }
                   # use tryTolower with sapply 
                   sentence = sapply(sentence, tryTolower)
                   
                   # split sentence into words with str_split (stringr package)
                   word.list = str_split(sentence, "\\s+")
                   words = unlist(word.list)
                   
                   # compare words to the dictionaries of positive & negative terms
                   pos.matches = match(words, pos.words)
                   neg.matches = match(words, neg.words)
                   
                   # get the position of the matched term or NA
                   # we just want a TRUE/FALSE
                   pos.matches = !is.na(pos.matches)
                   neg.matches = !is.na(neg.matches)
                   
                   # final score
                   score = sum(pos.matches) - sum(neg.matches)
                   return(score)
                 }, pos.words, neg.words, .progress=.progress )
  
  # data frame with scores for each sentence
  scores.df = data.frame(text=sentences, score=scores)
  return(scores.df)
}


# import positive and negative words
pos = readLines("positive_words.txt")
neg = readLines("negative_words.txt")


# tweets with drinks
wine_tweets = searchTwitter("wine", n=500, lang="en")
beer_tweets = searchTwitter("beer", n=500, lang="en")
cofe_tweets = searchTwitter("coffee", n=500, lang="en")
soda_tweets = searchTwitter("soda", n=500, lang="en")

# get text
wine_txt = sapply(wine_tweets, function(x) x$getText())
beer_txt = sapply(beer_tweets, function(x) x$getText())
cofe_txt = sapply(cofe_tweets, function(x) x$getText())
soda_txt = sapply(soda_tweets, function(x) x$getText())

# how many tweets of each drink
nd = c(length(wine_txt), length(beer_txt), length(cofe_txt), length(soda_txt))

# join texts
drinks = c(wine_txt, beer_txt, cofe_txt, soda_txt) 


# apply function score.sentiment
scores = score.sentiment(drinks, pos, neg, .progress='text')

# add variables to data frame
scores$drink = factor(rep(c("wine", "beer", "coffee", "soda"), nd))
scores$very.pos = as.numeric(scores$score >= 2)
scores$very.neg = as.numeric(scores$score <= -2)

# how many very positives and very negatives
numpos = sum(scores$very.pos)
numneg = sum(scores$very.neg)

# global score
global_score = round( 100 * numpos / (numpos + numneg) )

# colors
cols = c("#7CAE00", "#00BFC4", "#F8766D", "#C77CFF")
names(cols) = c("beer", "coffee", "soda", "wine")

library(ggplot2)
# boxplot
ggplot(scores, aes(x=drink, y=score, group=drink)) +
  geom_boxplot(aes(fill=drink)) +
  scale_fill_manual(values=cols) +
  geom_jitter(colour="gray40",
              position=position_jitter(width=0.2), alpha=0.3)+ 
  ggtitle("Boxplot - Drink's Sentiment Scores")


# barplot of average score
meanscore = tapply(scores$score, scores$drink, mean)
df = data.frame(drink=names(meanscore), meanscore=meanscore)
df$drinks <- reorder(df$drink, df$meanscore)

ggplot(df, aes(x = drinks, y=meanscore, fill = drinks)) +
  geom_bar(stat = "identity") +
  scale_fill_manual(values=cols[order(df$meanscore)]) + 
  ggtitle("Average Sentiment Score")


# barplot of average very positive
drink_pos = ddply(scores, .(drink), summarise, mean_pos=mean(very.pos))
drink_pos$drinks <- reorder(drink_pos$drink, drink_pos$mean_pos)

ggplot(drink_pos, aes(y=mean_pos, x=drinks, fill=drinks)) +
  geom_bar(stat = "identity") +
  scale_fill_manual(values=cols[order(drink_pos$mean_pos)]) +
  ggtitle("Average Very Positive Sentiment Score")


# barplot of average very negative
drink_neg = ddply(scores, .(drink), summarise, mean_neg=mean(very.neg))
drink_neg$drinks <- reorder(drink_neg$drink, drink_neg$mean_neg)

ggplot(drink_neg, aes(y=mean_neg, x=drinks, fill=drinks)) +
  geom_bar(stat = "identity") +
  scale_fill_manual(values=cols[order(drink_neg$mean_neg)]) +
  ggtitle("Average Very Negative Sentiment Score")