import requests
from bs4 import BeautifulSoup as bs
import pandas as pd
from time import sleep

Dataset_January = pd.DataFrame()
for x in range(1,32): # Add in the correct amount of days for the month
    headers = {'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/15.3 Safari/605.1.15'}
    url = f'https://www.the-numbers.com/home-market/netflix-daily-chart/2021/01/' # use the correct link here, change months
    req = requests.get(url+str(x), headers=headers)
    soup = bs(req.text, "html.parser")
    Data_table = soup.find('table', {'align':'center'})
    #tableheader
    tableheader = [[c.text for c in row.find_all('th')] for row in Data_table('tr')][0]
    #tabledata
    tabledata = [[c.text for c in row.find_all('td')] for row in Data_table('tr')][1:]
    #combine the data
    combined = [dict(zip(tableheader, t)) for t in tabledata]
    #append dataframe
    Dataset_July = Dataset_January.append(combined)
    sleep(2)

print(len(Dataset_January))
Dataset_January.to_csv('01_Jan_Netflix_data.csv')
print("finished")
