library(ROAuth)
library(twitteR)

consumer_key = "dIBjmjCvDg0AiURwYvKtpq3g1"
consumer_secret = "BOBe05evjnQiy7RbFhakh0w1GojTjDt3u0CvYW2OfmWndskyO8"
access_token = "3247883653-hJZDTRJHoO5Bz4te9nVxQjRD355reTypgbMhnaz"
access_secret = "9G5ZTeuQe1x6P2S1SS7MIOtRbZrJxBqZlVE4BAWzgiJHT"
setup_twitter_oauth(consumer_key ,consumer_secret, access_token,  access_secret )
cred = OAuthFactory$new(consumerKey = consumer_key, consumerSecret = consumer_secret,requestURL='https://api.twitter.com/oauth/request_token',accessURL='https://api.twitter.com/oauth/access_token',authURL='https://api.twitter.com/oauth/authorize')

search.tweets = searchTwitter("@realDonaldTrump", n=100)

sample = NULL
for (tweet in search.tweets)
  sample = c(sample,tweet$getText())

df = do.call("rbind", lapply(search.tweets, as.data.frame))

df$text = sapply(df$text,function(row) iconv(row, "latin1", "ASCII", sub=""))
df$text = gsub("(f|ht)tp(s?)://(.*)[.][a-z]+", "", df$text)
sample = df$text

pos = scan('assets/positive.txt', what='character', comment.char=';')
neg = scan('assets/negative.txt', what='character', comment.char=';')
