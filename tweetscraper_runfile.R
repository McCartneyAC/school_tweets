##################################################
# Teacher and School Data Twitter Scraper        # 
##################################################

setwd("C:\\Users\\Andrew\\Desktop\\Statistics and Data Analysis\\R and R related\\teacher tweets")
# getwd()

library(tidyverse)
library(magrittr)
library(rtweet)
library(httpuv)
library(tidytext)
library(stringr)
################################################


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

# tweets_teacher<- search_tweets(q = '"my teacher"', n = 5000, include_rts = FALSE)
# tweets_school <- search_tweets(q = '"my school"', n = 5000, include_rts = FALSE)
tweets_professor <- search_tweets(q = '"my professor"', n = 5000, include_rts = FALSE)
tweets_university <- search_tweets(q = '"my university"', n = 3000, include_rts = FALSE)
# tweets_principal <- search_tweets(q = '"my principal"', n = 5000, include_rts = FALSE)
tweets_college <- search_tweets(q = '"my college"', n = 5000, include_rts = FALSE)
tweets_students <- search_tweets(q = '"my students"', n = 5000, include_rts = FALSE)


###################################################
#          Create Databases  (run once)           #
###################################################
# write_csv(tweets_professor, "professortweets.csv")
# write_csv(tweets_university, "universitytweets.csv")
# write_csv(tweets_college, "collegetweets.csv")
# write_csv(tweets_students, "studentstweets.csv")



###################################################
#          Append Databases                       #
###################################################

# write_csv(tweets_teacher, "teachertweets.csv", append = TRUE )
# write_csv(tweets_school, "schooltweets.csv", append = TRUE )
write_csv(tweets_professor, "professortweets.csv", append = TRUE )
write_csv(tweets_university, "universitytweets.csv", append = TRUE )
write_csv(tweets_college, "collegetweets.csv", append = TRUE )
write_csv(tweets_students, "studentstweets.csv", append = TRUE )
# write_csv(tweets_principal, "principaltweets.csv", append = TRUE )

