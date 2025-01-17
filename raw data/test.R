# Install and load necessary packages
if (!require(RSQLite)) install.packages("RSQLite")
if (!require(tidyverse)) install.packages("tidyverse")
if (!require(DBI)) install.packages("DBI")
if (!require(data.table)) install.packages("data.table")
if (!require(here)) install.packages("here")
if (!require(vroom)) install.packages("vroom")
if (!require(readr)) install.packages("readr")

library(readr)
library(RSQLite)
library(tidyverse)
library(DBI)
library(data.table)
library(here)
library(vroom)



# data reading tests ------------------------------------------------------


# Connect to SQLite database
# con <- dbConnect(RSQLite::SQLite(), "./raw data/biodiversity-data/large_files_database.sqlite3")
db01 <- dbConnect(RSQLite::SQLite(), here("raw data/biodiversity-data", "large_csv_database.sqlite"))


library(RSQLite)
library(readr)


# occurence table ---------------------------------------------------------


# File paths
# csv_file <- "./raw data/biodiversity-data/occurence.csv"
csv_file <- here("raw data/biodiversity-data", "occurence.csv")
sqlite_db <- here("raw data/biodiversity-data", "large_csv_database.sqlite")

table_name <- "Occurence_table"

# Define chunk size (number of rows to read at a time)
chunk_size <- 500000  # 1 million rows per chunk; adjust based on memory
# Open SQLite connection
conn <- dbConnect(RSQLite::SQLite(), dbname = sqlite_db)


# This fuction takes a huge csv and puts it in a sqlite database 
# csv_file = location of a huge file,
# conn = location of sqlite database,
# table_name = name of the table to creat in the sqlite db,
# chunk_size = num of rows you want to be read at a time default = 500000

csv_to_sqlite = function(csv_file, conn, table_name, chunk_size = 500000)
  {
  # Open the CSV file for reading
  file_con <- file(csv_file, "r")
  header <- readLines(file_con, n = 1)  # Read header
  col_names <- strsplit(header, ",")[[1]]  # Parse column names
  
  # Process file in chunks
  repeat {
    # Read a chunk of lines
    lines <- readLines(file_con, n = chunk_size)
    
    # Break if no more lines
    if (length(lines) == 0) break
    
    # Convert lines to a data.table
    chunk <- fread(paste(c(header, lines), collapse = "\n"), header = TRUE)
    
    # Append chunk to SQLite database
    dbWriteTable(conn, table_name, chunk, append = TRUE, row.names = FALSE)
  }
  
}



# Open the CSV file for reading
file_con <- file(csv_file, "r")
header <- readLines(file_con, n = 1)  # Read header
col_names <- strsplit(header, ",")[[1]]  # Parse column names

# Process file in chunks
repeat {
  # Read a chunk of lines
  lines <- readLines(file_con, n = chunk_size)
  
  # Break if no more lines
  if (length(lines) == 0) break
  
  # Convert lines to a data.table
  chunk <- fread(paste(c(header, lines), collapse = "\n"), header = TRUE)
  
  # Append chunk to SQLite database
  dbWriteTable(conn, table_name, chunk, append = TRUE, row.names = FALSE)
}


# multimedia table --------------------------------------------------------


# File paths
csv_file <- here("raw data/biodiversity-data", "multimedia.csv")

table_name <- "Multimedia_table"

# Define chunk size (number of rows to read at a time)
chunk_size <- 500000  # 1 million rows per chunk; adjust based on memory

# Open the CSV file for reading
file_con <- file(csv_file, "r")
header <- readLines(file_con, n = 1)  # Read header
col_names <- strsplit(header, ",")[[1]]  # Parse column names

# Process file in chunks
repeat {
  # Read a chunk of lines
  lines <- readLines(file_con, n = chunk_size)
  
  # Break if no more lines
  if (length(lines) == 0) break
  
  # Convert lines to a data.table
  chunk <- fread(paste(c(header, lines), collapse = "\n"), header = TRUE)
  
  # Append chunk to SQLite database
  dbWriteTable(conn, table_name, chunk, append = TRUE, row.names = FALSE)
}




# Close file connection
close(file_con)

# Verify the data
print(dbListTables(conn))  # Should show the created table
print(dbGetQuery(conn, paste("SELECT COUNT(*) FROM", table_name)))  # Check row count

# Close SQLite connection
dbDisconnect(conn)


