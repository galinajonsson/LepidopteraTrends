# Function to summarise whether or not all occupancy estimates throughout the time series have converged (based on Rhat-values)
# Input can be either a directory with .rds files (default; is.list=FALSE) or a list of occDet elements (specify is.list=TRUE)
# This function reads in and summarises convergence based on Rhat values (threshold 1.1) for the occupancy estimates
summarise_Rhat <-  function(input, verbose = TRUE, is.list=FALSE) {
  
  # Load required libraries
  library(reshape2)
  require(dplyr)
  
  ### If input is a directory, not a list of occDet elements
  if(isFALSE(is.list(input))){
    
    # get files from the input directory & list of the files to loop through
    files <- list.files(path = paste(input), ignore.case = TRUE, pattern = '\\.rds$') 
  
    # sense check these file names
    if(length(files) == 0) stop('No .rds files found in ', input)
    if(length(files) < length(list.files(path = input))) warning('Not all files in ', input, ' are .rds files, other file types have been ignored')
  }
  
    
    
  # create a function to read in the data we want from these .rds files
  read_Rhat <- function(input_file){
    
    # If input is a directory
    if(isFALSE(is.list(input))) {
      out <- readRDS(input_file)
      # If input is a list
      } else if(isTRUE(is.list(input))) {
        out <- input[[i]]
        }
    
    # sense output
    if(!("summary" %in% ls(out$BUGSoutput))){
      stop('The element(s) does not contain a summary of the "BUGSoutput" object.')
    }
    if(!("SPP_NAME" %in% ls(out))){
      stop('The element(s) does  do not contain a "SPP_NAME" object.')
    }
    if(!("min_year" %in% ls(out))){
      stop('The element(s) does do not contain a "min_year" object.')
    }
    if(!("max_year" %in% ls(out))){
      stop('The element(s) does  do not contain a "max_year" object.')
    }
    
    # some old outputs don't have min year in which case make it == 1
    min_year <- ifelse(is.null(out$min_year), 1, out$min_year)
    
    #Get the summary output for the rows and columns that we are interested in
    temp_out <- as.data.frame(out$BUGSoutput$summary)
      rows <- grep("^(psi.fs[^.r])", row.names(temp_out))
      for (i in rows) {
        if (temp_out[i, c("Rhat")] > 1.1){
          convergenceYN <- "N"
          break
          }
        if (i == max(rows)){
          convergenceYN <- "Y"
        }
      }
      
      summary_out <- data.frame(species_name = out$SPP_NAME,
                                converged = convergenceYN)
    return(summary_out)
  }
  
  
  if(verbose) cat('Loading data...')
  
  
  
  #### Use lapply to run this function on all files
  
  # If input is a directory
  if(isFALSE(is.list(input))) {
    list_summaries <- lapply(file.path(input, files), read_Rhat)
    # If input is a list
  } else if(isTRUE(is.list(input))) {
    list_summaries <-  lapply(input, read_Rhat)
  }
  
  if(verbose) cat('done\n')
  
  # Unlist these and bind them together
  spp_data <- do.call(rbind, list_summaries)
  
  return(spp_data)
  
  }
