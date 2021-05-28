# Function to summarise whether or not all occupancy estimates throughout the time series have converged (based on Rhat-values)
# Input can be either for a list of occDet elements or a directory with .rds files
# This function reads in and summarises convergence based on Rhat values (threshold 1.1) for the occupancy estimates
SummariseRhatDetProb <-  function(input, verbose = TRUE) {
  
  # Load required libraries
  library(reshape2)
  require(dplyr)
  
  ### If input is a list of occDet elements
  if(isTRUE(is.list(input))){
    
    # Create an empty dataframe to populate
    summary_out <- data.frame(species_name = character(length(input)),
                              converged = character(length(input)), 
                              stringsAsFactors = FALSE)
    
    # create a function loop through and read in the data we want from the list elements
    for(i in 1:length(input)){
      
      # Read elements and call 'out'
      out <- input[[i]]
      
      # Some sense checks
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
      
      #Get the summary output for the rows and columns that we are interested in
      # Specify BUGSoutput$summary
      temp_out <- as.data.frame(out$BUGSoutput$summary) 
      # Specify the rows summarising alpha.p (occupancy) per closure periods
      rows <- grep("^(alpha.p[^.r])", row.names(temp_out))
      
      ### Loop through the rows (closure periods), and determine whether 1.1<Rhat>1.1
      for (j in rows) {
        if (temp_out[j, c("Rhat")] > 1.1) # If any closure period has Rhat>1.1
        {
          convergenceYN <- "N" # Give convergenceYN the value 'N'
          break # Stop looping through closure periods if Rhat>1.1
        }
        if (j == max(rows)) { # Else, if closure period j has Rhat<1.1
          convergenceYN <- "Y" # Give convergenceYN the value 'N'
        }
      }
      
      ### Summarise 
      # Species name
      summary_out[i, 1] <- out$SPP_NAME
      # Whether all closure periods have converged
      summary_out[i, 2] <- convergenceYN
      
      
      
      if(verbose) cat('Loading data...')
      
      # return the summary
      return(summary_out)
    }
    
    
    
  } else{
    
    ### If input is a directory
    
    # get files from the input directory & list of the files to loop through
    files <- list.files(path = paste(input), ignore.case = TRUE, pattern = '\\.rds$') 
    
    # sense check these file names
    if(length(files) == 0) stop('No .rds files found in ', input)
    if(length(files) < length(list.files(path = input))) warning('Not all files in ', input, ' are .rds files, other file types have been ignored')
    
    loadrds <- function(fileName){
      #loads an rds file, tests if it contains the necessary objects and returns it
      out <- readRDS(fileName)
      if(!("BUGSoutput" %in% ls(out))){
        stop('The rds file(s) do not contain a "BUGSoutput" object.')
      }
      if(!("summary" %in% ls(out$BUGSoutput))){
        stop('The rds file(s) do not contain a summary of the "BUGSoutput" object.')
      }
      if(!("SPP_NAME" %in% ls(out))){
        stop('The rds file(s) do not contain a "SPP_NAME" object.')
      }
      if(!("min_year" %in% ls(out))){
        stop('The rds file(s) do not contain a "min_year" object.')
      }
      if(!("max_year" %in% ls(out))){
        stop('The rds file(s) do not contain a "max_year" object.')
      }
      return(out)
    }
    
    # create a function to read in the data we want from these .rds files
    read_bayes <- function(file){
      
      out <- loadrds(file) 
      
      # some old outputs don't have min year in which case make it == 1
      min_year <- ifelse(is.null(out$min_year), 1, out$min_year)
      #Get the summary output for the rows and columns that we are interested in
      temp_out <- as.data.frame(out$BUGSoutput$summary)
      
      rows <- grep("^(alpha.p[^.r])", row.names(temp_out))
      
      for (i in rows) {
        if (temp_out[i, c("Rhat")] > 1.1){
          alpha.p <- "N"
          break
        }
        if (i == max(rows)){
          alpha.p <- "Y"
        }
      }
        
      
      #rows2 <- grep("^(dtype2.p[^.r])", row.names(temp_out))
      #for (i in rows2) {
      rows <- grep("dtype2.p", row.names(temp_out))
      for (j in rows) {
        if(temp_out[j, c("Rhat")] > 1.1){
          dtype2.p <- "N"
          
          break
        }
          if(temp_out[j, c("Rhat")] < 1.1){
          dtype2.p <- "Y"
          }
      }
      
      rows <- grep("dtype3.p", row.names(temp_out))
      for (x in rows) {
        if (temp_out[x, c("Rhat")] > 1.1){
          dtype3.p <- "N"
          
          break
        }
        if(temp_out[x, c("Rhat")] < 1.1){
          dtype3.p <- "Y"
        }
      }
      
      
      rows <- grep("LL.p", row.names(temp_out))
      for (y in rows) {
        if (temp_out[y, c("Rhat")] > 1.1){
          LL.p <- "N"
          
          break
        }
        if(temp_out[y, c("Rhat")] < 1.1){
          LL.p <- "Y"
        }
      }
      
    
      
      summary_out <- data.frame(species_name = out$SPP_NAME,
                                alpha.p = alpha.p,
                                dtype2.p = dtype2.p,
                                dtype3.p = dtype3.p,
                                LL.p = LL.p)
      return(summary_out)
    }
    
    if(verbose) cat('Loading data...')
    
    # Use lapply to run this function on all files
    list_summaries <- lapply(file.path(input, files), read_bayes)
    if(verbose) cat('done\n')
    
    # Unlist these and bind them together
    spp_data <- do.call(rbind, list_summaries)
    
    return(spp_data)
    
  }
  
}
