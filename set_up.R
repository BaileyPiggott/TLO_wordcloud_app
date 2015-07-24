# set up text files
# source: https://georeferenced.wordpress.com/2013/01/15/rwordcloud/

library(shiny)
library(ggplot2)
library(tidyr)
library(dplyr)
library(magrittr)
library(tm) 
library(wordcloud) 
library(SnowballC) 
library(RColorBrewer)  # load libraries


# transform data frame into one long string
tlo <- read.csv("TLO_data_2015.csv",  stringsAsFactors=FALSE)
tlo_eng <- tlo %>% filter(grepl('APSC', course)) # engineering courses

#separate by level:

om <- tlo_eng %>% mutate(Average = Motivation.average) %>% select(Year, Average, contains("X.OM5")) #motivation
lb <- tlo_eng %>% mutate(Average = Learning.Belief.average) %>% select(Year,Average, contains("X.LB5")) #learning belief
se <- tlo_eng %>% mutate(Average = Self.Efficacy.average) %>% select(Year, Average, contains("X.SE5")) #self efficacy
tr <- tlo_eng %>% mutate(Average = Transfer.average) %>% select(Year, Average, contains("X.TR5"))  #transfer
org <- tlo_eng %>% mutate(Average = Organization.average)%>% select(Year, Average, contains("X.O5"))  #organization

