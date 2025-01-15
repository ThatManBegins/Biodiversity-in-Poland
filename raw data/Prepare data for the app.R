# here I prepare the data used in the app
# Install and load necessary packages
if (!require(RSQLite)) install.packages("RSQLite")
if (!require(tidyverse)) install.packages("tidyverse")
if (!require(DBI)) install.packages("DBI")
if (!require(dbplyr)) install.packages("dbplyr")
if (!require(data.table)) install.packages("data.table")
if (!require(here)) install.packages("here")
if (!require(vroom)) install.packages("vroom")

library(RSQLite)
library(tidyverse)
library(DBI)
library(dbplyr)
library(data.table)
library(here)
library(vroom)
library(dplyr)

# sourcing the functions 
source("./raw data/Function for raw data.R")

# downloading the data from google drive
downloaded_data = download_raw_data()

# extracting the downloaded data
untar(downloaded_data, exdir = "./raw data")

# Connect to SQLite database
# con <- dbConnect(RSQLite::SQLite(), "./raw data/biodiversity-data/large_files_database.sqlite3")
mydb = dbConnect(RSQLite::SQLite(), here("raw data/biodiversity-data", "large_files_database.sqlite3"))

# source: https://www.michaelc-m.com/manual_posts/2022-01-27-big-CSV-SQL.html
# here we read the massive 19.5gb occurence.csv and put it in a table called "occurence" in large_file_database.sqlite3
read_csv_chunked(here("raw data/biodiversity-data", "occurence.csv"), 
                 callback = function(chunk, dummy){
                   dbWriteTable(mydb, "occurence", chunk, append = T)}, 
                 chunk_size = 500000, col_types = "ccccccccccccccccccccccccccc")


# here we read the 1,3gb multimedia.csv and put it in a table called "multimedia" in large_file_database.sqlite3
read_csv_chunked(here("raw data/biodiversity-data", "multimedia.csv"), 
                 callback = function(chunk, dummy){
                   dbWriteTable(mydb, "multimedia", chunk, append = T)}, 
                 chunk_size = 500000, col_types = NULL)



# processing the data -----------------------------------------------------
Occurence_table = tbl(mydb, "occurence") %>%
  filter(country == "Poland") %>%
  collect()

Multimedia_table = tbl(mydb,"multimedia") %>%
  collect()
  
Multimedia_table = Multimedia_table %>%
  filter(
    CoreId %in% Occurence_table$id
  )




# saving the prepared data in Rdata format --------------------------------

save(
  Occurence_table,
  Multimedia_table,
  
  file = "./Biodiversity-in-Poland/data/prepared_data.RData"
)
