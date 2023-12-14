############################################################
############### SCRAPPING NBA STATS DATA ###################
############################################################

import requests
import pandas as pd

## Some wizardry to get data
headers  = {
    'Connection': 'keep-alive',
    'Accept': 'application/json, text/plain, */*',
    'x-nba-stats-token': 'true',
    'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.130 Safari/537.36',
    'x-nba-stats-origin': 'stats',
    'Sec-Fetch-Site': 'same-origin',
    'Sec-Fetch-Mode': 'cors',
    'Referer': 'https://stats.nba.com/',
    'Accept-Encoding': 'gzip, deflate, br',
    'Accept-Language': 'en-US,en;q=0.9',
}
## Seasons available 
season_list = ['2023-24']

## Headers of players' dataframe
heads = ["PLAYER_ID", "PLAYER_NAME", "NICKNAME", "TEAM_ID", "TEAM_ABBREVIATION", "AGE", "GP", "W", "L","W_PCT","MIN","FGM","FGA","FG_PCT","FG3M","FG3A","FG3_PCT","FTM","FTA","FT_PCT","OREB","DREB","REB","AST","TOV","STL","BLK","BLKA","PF","PFD","PTS","PLUS_MINUS","NBA_FANTASY_PTS","DD2","TD3","GP_RANK","W_RANK","L_RANK","W_PCT_RANK","MIN_RANK","FGM_RANK","FGA_RANK","FG_PCT_RANK","FG3M_RANK","FG3A_RANK","FG3_PCT_RANK","FTM_RANK","FTA_RANK","FT_PCT_RANK","OREB_RANK","DREB_RANK","REB_RANK","AST_RANK","TOV_RANK","STL_RANK","BLK_RANK","BLKA_RANK","PF_RANK","PFD_RANK","PTS_RANK","PLUS_MINUS_RANK","NBA_FANTASY_PTS_RANK","DD2_RANK","TD3_RANK","CFID","CFPARAMS"]

## Players' url
a = 'https://stats.nba.com/stats/leaguedashplayerstats?College='
b = '&Conference=&Country=&DateFrom=&DateTo=&Division=&DraftPick=&DraftYear='
c = '&GameScope=&GameSegment=&Height=&LastNGames=0&LeagueID=00&Location=&MeasureType=Base&Month=0'
d = '&OpponentTeamID=0&Outcome=&PORound=0&PaceAdjust=N&PerMode=PerGame&Period=0&PlayerExperience='
e = '&PlayerPosition=&PlusMinus=N&Rank=N&Season='
f = '&SeasonSegment=&SeasonType=Regular+Season&Shot'
g = 'ClockRange=&StarterBench=&TeamID=0&TwoWay=0&VsConference=&VsDivision=&Weight='

## Headers of teams' dataframe
team_head = ["TEAM_ID", "TEAM_NAME", "GP", "W", "L", "W_PCT", "MIN", "FGM", "FGA", "FG_PCT", "FG3M", "FG3A", "FG3_PCT", "FTM", "FTA", "FT_PCT", "OREB", "DREB", "REB", "AST", "TOV", "STL", "BLK", "BLKA", "PF", "PFD", "PTS", "PLUS_MINUS", "GP_RANK", "W_RANK", "L_RANK", "W_PCT_RANK", "MIN_RANK", "FGM_RANK", "FGA_RANK", "FG_PCT_RANK", "FG3M_RANK", "FG3A_RANK", "FG3_PCT_RANK", "FTM_RANK", "FTA_RANK", "FT_PCT_RANK", "OREB_RANK", "DREB_RANK", "REB_RANK", "AST_RANK", "TOV_RANK", "STL_RANK", "BLK_RANK", "BLKA_RANK", "PF_RANK", "PFD_RANK", "PTS_RANK", "PLUS_MINUS_RANK"]

## Teams' url
h = "https://stats.nba.com/stats/leaguedashteamstats?Conference="
i = "&DateFrom=&DateTo=&Division=&GameScope=&GameSegment=&Height=&ISTRound=" 
j = "&LastNGames=0&LeagueID=00&Location=&MeasureType=Base&Month=0&OpponentTeamID=0"
k = "&Outcome=&PORound=0&PaceAdjust=N&PerMode=PerGame&Period=0&PlayerExperience="
l = "&PlayerPosition=&PlusMinus=N&Rank=N&Season="
m = "&SeasonSegment=&SeasonType=Regular%20Season&ShotClockRange=&StarterBench=&TeamID=0&TwoWay=0&VsConference=&VsDivision="



for season in season_list :
    
    ## Build the player data url for the season
    url = a + b + c + d + e + season + f + g

    ## Get data as a json file
    response = requests.get(url=url, headers=headers)
    response.raise_for_status()
    data = response.json()['resultSets'][0]['rowSet']

    ## Transform data as a pandas dataframe
    data = pd.DataFrame(data)
    data.columns = heads

    ## Save as csv file
    name = 'Data/Players_'+season+'.csv'
    data.to_csv(name)
    print("\n")
    print("Players' data " + season + " done.")

    ## Build the team data url for the season
    url = h + i + j + k + l + season + m

    ## Get data as a json file
    response = requests.get(url=url, headers=team_head)
    response.raise_for_status()
    data = response.json()['resultSets'][0]['rowSet']

    ## Transform data as a pandas dataframe
    data = pd.DataFrame(data)
    data.columns = heads

    ## Save as csv file
    name = 'Data/Teams_'+season+'.csv'
    data.to_csv(name)
    print("\n")
    print("Teams' data " + season + " done.")
    
