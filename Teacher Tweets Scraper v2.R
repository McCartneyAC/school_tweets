##################################################
# Teacher and School Data Twitter Scraper        # 
##################################################

setwd("C:\\Users\\mccar\\Desktop\\")
# getwd()

library(tidyverse)
library(magrittr)
library(rtweet)
library(httpuv)
library(tidytext)
library(stringr)
library(wesanderson)
library(ggthemes)
###################################################
# Connect to Twitter's API                        #
###################################################

appname <- "pogocentchar"

## api key 
key <- "jO4ts17oinXReTjBhKSLbaQQp"
## api secret key
secret <- "8Sd8bQHtk8noSxu0Wcp7fiC0HZXP4882OHgNx2ja8Hj6kVFsYG"

twitter_token <- create_token(
  app = appname,
  consumer_key = key,
  consumer_secret = secret, cache=TRUE)
###################################################
#         Access Tweets                           #
################################################### 


tweets <- search_tweets(q = '"my teacher"', n = 3000, include_rts = FALSE)
# weets_df <- tbl_df(map_df(tweets, as.data.frame))
write.csv(tweets, "teachertweets.csv")


###################################################
#  read the data back in as CSV tibble            #
###################################################

teachers<-read_csv("teachertweets.csv")
teachers
tweets<-teachers$text
summary(tweettext)
ts_plot(tweets)
#####################################################
# following the procedures at 
url<-"http://varianceexplained.org/r/trump-tweets/"

# remove these school words from sentiment analysis

schoolwords<-c("school", "professor", "teacher", "library", "college", "university",
               "faculty", "don", "haven", "lesson", "education", "educational", "teach",
               "principal", "excel", "educated", "tutor", "adviser")
# sentiments
nrc <- sentiments %>%
  filter(lexicon == "nrc") %>%
  dplyr::select(word, sentiment)%>%
  dplyr::filter(!word %in% schoolwords)

nrc
str(tweets$text)

View(teachers)


# David Robinson's code for cleaning text into individual words, minus stops
reg <- "([^A-Za-z\\d#@']|'(?![A-Za-z\\d#@]))"
tweet_words <- teachers %>%
  filter(!str_detect(text, '^"')) %>%
  mutate(text = str_replace_all(text, "https://t.co/[A-Za-z\\d]+|&amp;", "")) %>%
  unnest_tokens(word, text, token = "regex", pattern = reg) %>%
  filter(!word %in% stop_words$word,
         str_detect(word, "[a-z]"))

tweet_words$word
View(tweet_words)


tweet_words %>%
  count(word, sort = TRUE) %>%
  head(20) %>%
  mutate(word = reorder(word, n)) %>%
  ggplot(aes(word, n)) +
  geom_bar(stat = "identity") +
  ylab("Occurrences") +
  coord_flip()


#  sentiments
sources <- tweet_words %>%
  group_by(source) %>%
  mutate(total_words = n()) %>%
  ungroup() %>%
  distinct(status_id, source, total_words)

by_source_sentiment <- tweet_words %>%
  inner_join(nrc, by = "word") %>%
  count(sentiment, X1) %>%
  ungroup() %>%
  complete(sentiment, X1, fill = list(n = 0)) %>%
  inner_join(sources) %>%
  group_by(source, sentiment, total_words) %>%
  summarize(words = sum(n)) %>%
  ungroup()

#########################################
# back to teacher sentiments
#########################################

sentimental<-tweet_words %>%
  inner_join(nrc, by = "word") %>%
  count(sentiment, sort=TRUE) 
sentimental
wp7 <- wesanderson::wes_palette("FantasticFox",10, type="continuous")




teachsent<-ggplot(sentimental, aes(sentiment,  n, fill=sentiment))+geom_col()+coord_flip()
teachsent +
  scale_fill_manual(values = vangogh) + 
  theme_wsj() +
  labs( x="Sentiments", subtitle = "July 2017",
        y = "Word Counts", 
        title="Sentiments in tweets containing 'my teacher'")
