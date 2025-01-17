# here I prepare the data used in the app
# Install and load necessary packages
if (!require(RSQLite)) install.packages("RSQLite")
if (!require(tidyverse)) install.packages("tidyverse")
if (!require(DBI)) install.packages("DBI")
if (!require(dbplyr)) install.packages("dbplyr")
if (!require(data.table)) install.packages("data.table")
if (!require(here)) install.packages("here")
if (!require(vroom)) install.packages("vroom")
if (!require(readr)) install.packages("readr")

library(readr)
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

# preparing a SQLite database from the extracted data
# Connect to SQLite database
conn_sql <- dbConnect(RSQLite::SQLite(), here("raw data/biodiversity-data", "large_csv_database.sqlite"))

# writing Occurence Table
csv_to_sqlite(csv_file = here("raw data/biodiversity-data", "occurence.csv"),
              conn = conn_sql,
              table_name = "Occurence_table")

# writing Multimedia Table
csv_to_sqlite(csv_file = here("raw data/biodiversity-data", "multimedia.csv"),
              conn = conn_sql,
              table_name = "Multimedia_table")


# Verify the data
print(dbListTables(conn_sql))  # Should show the created table
print(dbGetQuery(conn_sql, paste("SELECT COUNT(*) FROM", table_name)))  # Check row count

# processing the data -----------------------------------------------------


Occurence_table = tbl(conn_sql, "Occurence_table") %>%
  filter(country == "Poland",
         !is.na(kingdom),
         taxonRank == "species"
         ) %>%
  collect()

Occurence_table_prep = Occurence_table %>%
  mutate(eventDate = as.Date(eventDate, origin = "1970-01-01"),
         eventDate = ymd(eventDate),
         longitudeDecimal = as.numeric(longitudeDecimal),
         latitudeDecimal = as.numeric(latitudeDecimal)
         )

Occurence_table_prep$coordinateUncertaintyInMeters

Multimedia_table = tbl(conn_sql,"Multimedia_table") %>%
  collect()
  
Multimedia_table_prep = Multimedia_table %>%
  filter(
    CoreId %in% Occurence_table$id
  )




# saving the prepared data in Rdata format --------------------------------

save(
  Occurence_table_prep,
  Multimedia_table_prep,
  
  file = "./Biodiversity-in-Poland/data/prepared_data.RData"
)
