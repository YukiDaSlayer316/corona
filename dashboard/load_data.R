# -------------------------- Dependencies -----------

library(dplyr)
library(tidyverse)
library(nCov2019)
library(coronavirus)
library(xts)

# ------------ import csv file from kaggle (04-11-2020)-------------

df_confirmed <- read.csv2(file = "data/time_series_covid_19_confirmed.csv", sep = ",")
df_confirmed_US <- read.csv2(file = "data/time_series_covid_19_confirmed_US.csv", sep = ",")
df_deaths <- read.csv2(file = "data/time_series_covid_19_deaths.csv", sep = ",")
df_deaths_US <- read.csv2(file = "data/time_series_covid_19_deaths_US.csv", sep = ",")
df_recovered <- read.csv2(file = "data/time_series_covid_19_recovered.csv", sep = ",")

# ---------------- Reformat Global Dataset: by countries ----------------------------------

deaths <- df_deaths %>% 
  select(-c(Province.State, Lat, Long)) %>%
  gather( "Date", "deaths", -Country.Region) %>% 
  rename(Country = Country.Region) %>% 
  mutate(Date = substring(Date, 2)) %>% 
  mutate(Date = gsub("\\.", "-", Date)) %>% 
  mutate(Date = as.Date(Date, "%m-%d-%y")) %>% 
  group_by(Date, Country ) %>% 
  summarise(deaths = sum(deaths))%>% 
  as.data.frame()


confirmed <- df_confirmed %>% 
  select(-c(Province.State, Lat, Long)) %>%
  gather( "Date", "confirmed", -Country.Region) %>% 
  rename(Country = Country.Region) %>% 
  mutate(Date = substring(Date, 2)) %>% 
  mutate(Date = gsub("\\.", "-", Date)) %>% 
  mutate(Date = as.Date(Date, "%m-%d-%y")) %>%
  group_by(Date, Country ) %>% 
  summarise(confirmed = sum(confirmed))%>% 
  as.data.frame()

recovered <- df_recovered %>% 
  select(-c(Province.State, Lat, Long)) %>%
  gather( "Date", "recovered", -Country.Region) %>% 
  rename(Country = Country.Region) %>% 
  mutate(Date = substring(Date, 2)) %>% 
  mutate(Date = gsub("\\.", "-", Date)) %>% 
  mutate(Date = as.Date(Date, "%m-%d-%y")) %>%
  group_by(Date, Country) %>% 
  summarise(recovered = sum(recovered))%>% 
  as.data.frame()
  
# -------------------- Combine global datasets by countries -----------

world <- confirmed %>% 
  full_join(deaths) %>% 
  full_join(recovered)  %>% 
  as.data.frame()
# %>% 
#   mutate(
#     total_confirmed = lag(confirmed, default = 1) ,
#     total_deaths = lag(deaths, default = 1) ,
#     total_recovered = lag(recovered, default = 1) 
#   )

test <- world %>% mutate(
  total_confirmed = confirmed-lag(confirmed, n=1) 
)

test %>% 
  filter(Date=="2020-03-20")





# -------------------- Convert global dataset into a time series -----------

# ---------------- Reformat Global Dataset: by cities ----------------------------------

# note: use lat and long to classify
df_recovered %>% 
  select(-c(Province.State, Country.Region)) %>%
  gather( "Date", "recovered", -Lat, -Long) %>% 
  mutate(Date = substring(Date, 2)) %>% 
  mutate(Date = gsub("\\.", "-", Date)) %>% 
  mutate(Date = as.Date(Date, "%m-%d-%y")) %>%
  group_by(Lat, Long, Date) %>% 
  summarise(recovered = sum(recovered)) %>% 
  head()

# ------------------------ Reformat US Datasets --------------------

confirmed_US <- df_confirmed_US %>% 
  select(-c(UID, iso2, iso3, FIPS, code3, Country_Region, Combined_Key)) %>% 
  rename(Long=Long_, State=Province_State, City=Admin2) %>% 
  gather("Date", "Confirmed", -Lat, -Long, -State, -City) %>% 
  mutate(Date = substring(Date, 2)) %>% 
  mutate(Date = gsub("\\.", "-", Date)) %>% 
  mutate(Date = as.Date(Date, "%m-%d-%y")) %>%
  group_by(State, City, Date, Lat, Long) %>% 
  summarise(Confirmed = sum(Confirmed))

deaths_US <- df_deaths_US %>% 
  select(-c(UID, iso2, iso3, FIPS, code3, Country_Region, Combined_Key)) %>% 
  rename(Long=Long_, State=Province_State, City=Admin2) %>% 
  gather("Date", "Deaths", -Lat, -Long, -State, -City) %>% 
  mutate(Date = substring(Date, 2)) %>% 
  mutate(Date = gsub("\\.", "-", Date)) %>% 
  mutate(Date = as.Date(Date, "%m-%d-%y")) %>%
  group_by(State, City, Date, Lat, Long) %>% 
  summarise(Deaths = sum(Deaths))

