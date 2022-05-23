#libraries

import dateutil.parser
import requests
import pandas as pd
import os

import csv

from vaderSentiment.vaderSentiment import SentimentIntensityAnalyzer

import time


os.environ['TOKEN'] = 'your personal token here '

def auth():
    return os.getenv('TOKEN')

## create headers
def create_headers(bearer_token):
    headers = {"Authorization": "Bearer {}".format(bearer_token)}
    return headers

#create url

def create_url(keyword, start_date, end_date, max_results = 10):
    search_url = "https://api.twitter.com/2/tweets/search/all" #full search endpoint

    #parameter set up
    query_params = {'query': keyword,
                    'start_time': start_date,
                    'end_time': end_date,
                    'max_results': max_results,
                    'expansions': 'author_id',
                    'tweet.fields': 'author_id,created_at,text',
                    'next_token': {}
                    }
    return (search_url, query_params)

def connect_to_endpoint(url, headers, params, next_token = None):
    params['next_token'] = next_token
    response = requests.request("GET", url, headers = headers, params=params)
    print("Endpoint Response Code: " + str(response.status_code))
    if response.status_code != 200:
        raise Exception(response.status_code, response.text)
    return response.json()

#append to csv function
def append_to_csv(json_response, fileName):
    #counter
    counter = 0

    #open/create target csv file
    csvFile = open(fileName, "a", newline="", encoding= 'utf-8')
    csvWriter = csv.writer(csvFile)

    #loop through each tweet
    for tweet in json_response["data"]:

        #create variable for each

        #1 author_id
        author_id = tweet['author_id']

        #2 time created
        created_at = dateutil.parser.parse(tweet['created_at'])

        #3 Tweet ID
        tweet_id = tweet['id']

        #4 Tweet text
        text = tweet['text']

        # Assemble all the Data
        res = [author_id, created_at, tweet_id, text]

        #Append to CSV file
        csvWriter.writerow(res)
        counter += 1

    #close csv file when done..
    csvFile.close()

    #print the number of tweets from this iteration

    print(counter, "tweets added from this response")

bearer_token = auth()
headers = create_headers(bearer_token)
keyword = "your search term here"#Put search therm that you want tu use here,
start_list = "your start date here"#start data here in []
end_list = "your end date here"# End data here in []
max_results = 100  #max amount per request

#total amount of tweets we collected from the loop
total_tweets = 0

#create file
csvFile = open("file.csv", "a", newline = "", encoding = "utf-8") #your file name here.
csvWriter = csv.writer(csvFile)

#set up headers

csvWriter.writerow(['author_id', 'created_at', 'tweet_id', 'text'])
csvFile.close()

for I in range(0, len(start_list)):

    #input
    count = 0 # count per time period
    max_count = 100000  #max amount of tweets you want to retrieve
    flag = True
    next_token = None

    #check for flag true
    while flag is True:
        #max count reached
        if count >= max_count:
            break
        print('-----------')
        print("Token:", next_token)
        url = create_url(keyword, start_list[I], end_list[I], max_results)
        json_response = connect_to_endpoint(url[0], headers, url[1], next_token)
        result_count = json_response['meta']['result_count']

        if 'next_token' in json_response['meta']:
            #save token to use for the next call
            next_token = json_response['meta']['next_token']
            print("Next_Token: ", next_token)
            if result_count is not None and result_count > 0 and next_token is not None:
                print("Start_Date: ", start_list[I])
                append_to_csv(json_response, "yourfilenamehere.csv")      #insert the filename here
                count += result_count
                total_tweets += result_count
                print("Total # of Tweets added: ", total_tweets)
                print('-----------')
                time.sleep(2) # careful not to overrun request max

        #if there is no next token
        else:
            if result_count is not None and result_count > 0:
                print('-----------')
                print("Start Date: ", start_list[I])
                append_to_csv(json_response, "yourfilenamehere.csv")                                                     #DATAFILE name HERE
                count += result_count
                total_tweets += result_count
                print("total # of tweets added: ", total_tweets)
                print('-----------')
                time.sleep(4)

            # final request, turn flag to false to move to the next time period
            flag = False
            next_token = None
        time.sleep(2)
print('total number of results: ', total_tweets)

# Vader sentiment lexicon
def sentiment_Vader(text):
    over_all_polarity = sid.polarity_scores(text)
    if over_all_polarity['compound'] >= 0.05:
        return "positive"
    elif over_all_polarity['compound'] <= -0.05:
        return "negative"
    else:
        return "neutral"

sid = SentimentIntensityAnalyzer()

data_file = pd.read_csv("yourfilenamehere.csv")     #your filename here

data_file['Sentiment_Vader'] = data_file['text'].apply(lambda x: sentiment_Vader(x))

csv_data = data_file.to_csv('yourfilenamehere .csv')    #your filename here