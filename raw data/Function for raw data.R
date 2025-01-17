
# Function download_raw_data ----------------------------------------------

#' Download a file from Google Drive
#'
#' This function downloads a publicly available file from Google Drive using its file ID.
#' The file is saved in the current working directory with its original name and extension.
#'
#' @param file_id A character string. The ID of the Google Drive file to download. by default is set to the raw data provided
#' @param save_in A character string. the name if the folder in the current directory to save the downloaded file in. by default set to raw data folder
#'
#' @return A character string. The local path of the downloaded file if successful, or NULL if an error occurs.

download_raw_data = function(file_id = "1l1ymMg-K_xLriFv1b8MgddH851d6n2sU" , 
                              save_in = "raw data") {
  # Check if googledrive package is installed, if not, install it
  if (!require(googledrive)) {
    install.packages("googledrive")
    library(googledrive)
  }
  
  # Deauthorize to access public files without authentication
  drive_deauth()
  
  tryCatch({
    # Get file information
    file_info = drive_get(as_id(file_id))
    
    # Download the file to the current directory, preserving name and extension
    download_result = drive_download(
      file_info,
      path = paste0("./",save_in,"/",file_info$name),
      overwrite = TRUE
    )
    
    print(paste("File successfully downloaded to:", download_result$local_path))
    return(download_result$local_path)
  }, error = function(e) {
    print(paste("Error downloading file:", e$message))
    return(NULL)
  })
}


# Function to convert large csv to sqlite -----------------------------------------------


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
  
  # Close file connection
  close(file_con)
  
}


