# Function to summarise whether or not all occupancy estimates throughout the time series have converged (based on Rhat-values) for many .rds files in an input directory
# This function reads in and summarises all the .rds files' Rhat values (all values below 1.1 or not) for the occupancy estimates
summarise_growthRate <-  function(input_dir, TP1start, TP1end, TP2start, TP2end, verbose = TRUE) {
  
  library(reshape2)
  require(dplyr)
  require(sparta)
  library(data.table)
  
  # get files from the input directory
  files <- list.files(path = paste(input_dir), ignore.case = TRUE, pattern = '\\.rds$') # list of the files to loop through
  
  # sense check these file names
  if(length(files) == 0) stop('No .rds files found in ', input_dir)
  if(length(files) < length(list.files(path = input_dir))) warning('Not all files in ', input_dir, ' are .rds files, other file types have been ignored')
  
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
  
  # Create an empty data frame to populate
  output <- data.frame(species = as.character(rep(NA, length(files))),
                          TP1mean = as.numeric(rep(NA, length(files))),
                          TP1lowCI = as.numeric(rep(NA, length(files))),
                          TP1upCI = as.numeric(rep(NA, length(files))),
                          TP1trend = as.numeric(rep(NA, length(files))),
                          TP2mean = as.numeric(rep(NA, length(files))),
                          TP2lowCI = as.numeric(rep(NA, length(files))),
                          TP2upCI = as.numeric(rep(NA, length(files))),
                          TP2trend = as.numeric(rep(NA, length(files)))
                          )
  output$species <- as.character(output$species)
  
  if(verbose) cat('Loading data...')
  
  # create a function to read in the data we want from these .rds files
  for(i in 1:length(files)){
    
    # read the rds file
    out <- loadrds(file.path(input_dir, files[i])) 
    
    # Enter species name in output table
    output[i,"species"] <- out$SPP_NAME
    
    # Find growth rate for both time periods
    TP1 <- occurrenceChange(TP1start, TP1end, out, change = "growthrate")
    TP2<- occurrenceChange(TP2start, TP2end, out, change = "growthrate")
    
    # Enter mean growth rate for first time period
    output[i,"TP1mean"] <- TP1$mean
    output[i,"TP2mean"] <- TP2$mean
    
    # Enter CIs for growth rate in first time period
    output[i,"TP1lowCI"] <- unname(TP1$CIs[1])
    output[i,"TP1upCI"] <- unname(TP1$CIs[2])
    output[i,"TP2lowCI"] <- unname(TP2$CIs[1])
    output[i,"TP2upCI"] <- unname(TP2$CIs[2])
  }
  
  output$species <- as.factor(output$species)

  if(verbose) cat('done\n')
  
  return(output)
}