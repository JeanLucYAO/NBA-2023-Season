###############################################################
############ HELPER FUNCTIONS FOR NBA STATS GRAPHS ############
###############################################################


# Bar plot of selected team players for a specific stat
# 
# @param stat: a string, basically the name of a column in the data set
#              representing any statistics you want to plot
# 
# @return a ggplot object (bar graph)
# 
# @examples: `create_stat_plot("REB")` outputs a bar graph of the number
#            of rebounds per game of a selected player.
create_stat_plot <- function(stat) {
  
  # Identify which player is selected in order to highlight his bar in a 
  # different color, and order the players by stat
  df <- reactive({
    roster() %>% 
      mutate(PlayerSelected = if_else(PLAYER_NAME == input$players, 
                                      "Selected", "Not Selected"),
             stats = .data[[stat]]) %>%
      arrange(desc(stats)) %>% # order players from the highest to lowest stat
      mutate(PLAYER_NAME = factor(PLAYER_NAME, levels = rev(unique(PLAYER_NAME))))
  })
  
  # create the bar graph with ggplot
  ggplot(df(), aes(x = PLAYER_NAME, y = stats, fill = PlayerSelected)) +
    geom_bar(stat = "identity", alpha = .6, width = .5, show.legend = F) +
    scale_fill_manual(values = c("Selected" = "#6F263D", "Not Selected" = "#1d428a")) +
    coord_flip() + # flip the coordinates to make the names readable
    labs(x = NULL, y = NULL) +
    theme_minimal()
  
  # return(ggplotly(p, tooltip = "y"))
  # Create a reprex and open an issue on git hub for plotly not being consistent.
}

# Bar plot of conference teams for a specific stat
# 
# @param stat: a string, basically the name of a column in the data set
#              representing any statistics you want to plot
# 
# @return a ggplot object (bar graph)
# 
# @examples: `create_stat_plot("REB")` outputs a bar graph of the number
#            of rebounds per game of each team in a conf.
create_team_stat_plot <- function(stat) {
  
  # Identify which team is selected in order to highlight his bar in a 
  # different color, and order the players by stat
  df <- reactive({
    conf_df() %>% 
      mutate(teamSelected = if_else(TEAM_NAME == input$teams, 
                                      "Selected", "Not Selected"),
             stats = .data[[stat]]) %>%
      arrange(desc(stats)) %>% # order teams from the highest to lowest stat
      mutate(TEAM_NAME = factor(TEAM_NAME, levels = rev(unique(TEAM_NAME))))
  })
  
  # create the bar graph with ggplot
  ggplot(df(), aes(x = TEAM_NAME, y = stats, fill = teamSelected)) +
    geom_bar(stat = "identity", alpha = .6, width = .5, show.legend = F) +
    scale_fill_manual(values = c("Selected" = "#6F263D", "Not Selected" = "#1d428a")) +
    coord_flip() + # flip the coordinates to make the names readable
    labs(x = NULL, y = NULL) +
    theme_minimal()
  
  # return(ggplotly(p, tooltip = "y"))
  # Create a reprex and open an issue on git hub for plotly not being consistent.
}

# Bar plot of the top 10 players for a specific stat
# 
# @param stat: a numeric vector, basically a column in the players 
#              data set representing any statistics you want to plot
# 
# @return a ggplotly object (an interactive bar graph)
# 
# @examples: `create_top_10("REB")` outputs a bar graph of the top 10 players 
#            leading the NBA in number of rebounds per game 
create_top_10 <- function(stat) {
  
  # order the players by stat, and take the 10 first
  df <- reactive({
    players %>% 
      mutate(stats = .data[[stat]]) %>%
      arrange(desc(stats)) %>% 
      mutate(PLAYER_NAME = factor(PLAYER_NAME, levels = rev(unique(PLAYER_NAME)))) %>% 
      slice_head(n = 10)
  })
  
  # create the bar graph with ggplot
  q <- ggplot(df(), aes(x = PLAYER_NAME, y = stats)) +
    geom_bar(stat = "identity", fill = "#1d428a", alpha = .6, width = .5, show.legend = F) +
    coord_flip() + # flip the coordinates to make the names readable
    labs(x = NULL, y = NULL) +
    theme_minimal() 
  
  # make the plot interactive, display the value of stat when hovering a bar
  return(ggplotly(q, tooltip = "y"))
}

# Bar plot of the teams standings for a specific conference
# 
# @param conf: a dataframe, representing the teams of a conference
#              
# 
# @return a ggplotly object (an interactive bar graph)
# 
# @examples: `create_ranking(east)` outputs a bar graph of the current standing 
#            in the eastern conference
create_ranking <- function(conf) { 
  
  # rank teams by win percentage, and categorize them between who will make the 
  # playoffs, the play-in tournament, and eliminated for playoffs contention
  df <- reactive({
    conf %>% 
      arrange(W_PCT) %>% 
      mutate(TeamSelected = case_when(row_number() %in% c(1:5) ~ "Eliminated",
                                      row_number() %in% c(6:9) ~ "Play-in",
                                      row_number() %in% c(10:15) ~ "Playoffs"),
             TEAM_NAME = factor(TEAM_NAME, levels = TEAM_NAME))
  })
  
  # create the bar graph with ggplot
  t <- ggplot(df(), aes(x = TEAM_NAME, y = W_PCT, fill = TeamSelected)) +
    geom_bar(stat = "identity", alpha = .6, width = .5, show.legend = F) +
    scale_fill_manual(values = c("Playoffs" = "#1d428a", 
                                 "Play-in" = "#6F263D", 
                                 "Eliminated" = "#212121")) +
    coord_flip() +
    labs(x = NULL, y = "Win Percentage") +
    theme_minimal() 
  
  # make the plot interactive, display the win percentage when hovering a bar
  return(ggplotly(t, tooltip = "y"))
}