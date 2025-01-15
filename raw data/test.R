# Install and load necessary packages
if (!require(RSQLite)) install.packages("RSQLite")
if (!require(tidyverse)) install.packages("tidyverse")
if (!require(DBI)) install.packages("DBI")
if (!require(data.table)) install.packages("data.table")
if (!require(here)) install.packages("here")
if (!require(vroom)) install.packages("vroom")

library(RSQLite)
library(tidyverse)
library(DBI)
library(data.table)
library(here)
library(vroom)

# Connect to SQLite database
# con <- dbConnect(RSQLite::SQLite(), "./raw data/biodiversity-data/large_files_database.sqlite3")
mydb <- dbConnect(RSQLite::SQLite(), here("raw data/biodiversity-data", "large_files_database.sqlite3"))


read_csv_chunked(here("raw data/biodiversity-data", "occurence.csv"), 
                 callback = function(chunk, dummy){
                   dbWriteTable(mydb, "occurence", chunk, append = T)}, 
                 chunk_size = 500000, col_types = "cddidddciiidd")

