# uncomment the lines below to install packages
#install.packages("twitteR")
#install.packages("stringr")
#install.packages("dplyr")
#install.packages("syuzhet")
#install.packages("sentimentr")

library(twitteR)
library(stringr)
library(dplyr)
library(tm)
library(ggplot2)
library(wordcloud)
library(sentimentr)
library(RCurl)
library(syuzhet)


consumerKey <- "HRn1l4ebeiXRqVdwVqUBS6zRG"
consumerSecret <- "EFCJecDJImgeTpjkHYuvkkHg3fF7H2yEDK6wr11l7K9UoU4MNL"
accessToken <- "1020242133884649472-1i5f13Ap5lq3mG3SBxj63fRAW4AAdp"
accessTokenSecret <- "jkyir3IcTcJrd7vSX4nWT08jkshCFBoPLrQP7BnSuACVM"
handle <- "@Ankit65261956"

setup_twitter_oauth(consumerKey, consumerSecret, accessToken, accessTokenSecret)



tweets_data <- searchTwitter("#rahulgandhi",n=2000, since ="2016-11-10", lang = "en")
tweets_data

timeline_list <- sapply(tweets_data, function(x) x$getText())
corpus <- Corpus(VectorSource(timeline_list))
library(wordcloud)

corpus <- tm_map(corpus, content_transformer(removePunctuation))
corpus <- tm_map(corpus, content_transformer(removeNumbers))
corpus <- tm_map(corpus, content_transformer(function(x) removeWords(x, stopwords())))

plal<- brewer.pal(8,"Dark2")

wordcloud(corpus, min.freq=7, ma.words=Inf, width =1000, height=1000, random.order=FALSE, color= pal)


#syuzet give the 
#get_nrc_sentiment 

#for senetiment analysis
# how this function works

get_nrc_sentiment("I bought an iphone a few days ago. it is such anice
                  nice phone, although little large. THe touch screen is
                  cool. The voice quality is clear too. I simply love it")
mysentiment<- get_nrc_sentiment(corpus)
sentimentscores <- data.frame(colSums(mysentiment[,]))
names(sentimentScores) <- NULL


ggplot(data = SentimentScores, aes(x = sentiment, y = Score)) 
+ geom_bar(aes(fill = sentiment), stat = "identity") + theme(legend.position = "none") 
+ xlab("sentiment") + ylab("scores") + ggtitile("Total Sentiment Score Based on  Tweetsm"))
