
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


# Function process_raw_data -----------------------------------------------



