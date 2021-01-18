library(dplyr)
library(ggplot2)
library(scales)
rm(list=ls())

db <- read.csv("https://data.cdc.gov/resource/vsak-wrfu.csv")
str(db)
df <- db %>% select(state,week_ending_date,sex,age_group,total_deaths,covid_19_deaths) 
colnames(df) <- c("State","Date","Sex","Age","Total","Covid19")
## Fix Date
df$Date <- substr(df$Date,1,10)
df$Date <- as.Date(df$Date)
## First Report
all_all <- df %>% filter(Sex =="All Sex" & Age =="All Ages")
all_all$Rate <- all_all$Covid19/all_all$Total
ggplot(all_all) + geom_line(aes(x=Date,y=Rate)) +
  scale_y_continuous(labels = percent) +
  labs(title="Covid19 Deaths as a Perent of Total Deaths",
       subtitle = "Total = All Diseases")

### Import complete CDC Data 
dat <- read.csv("./DATA/Weekly_by_Sex__Age.csv")
ggplot(dat) + geom_line(aes(x=Date,y=Percent))
