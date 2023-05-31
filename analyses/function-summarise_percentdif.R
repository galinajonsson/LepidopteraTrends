summarise_percentdif <-  function(input_dir, cutoff, verbose = TRUE) {
  
  library(reshape2)
  require(dplyr)
  require(sparta)
  
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
  
  
  # create a function to read in the data we want from these .rds files
  read_bayes <- function(file){
    
    out <- loadrds(file) 
    
    # some old outputs dont have min year in which case make it == 1
    min_year <- ifelse(is.null(out$min_year), 1, out$min_year)
    max_year <- out$max_year
    
    # Create empty df to populated
    data_frame <- data.frame(species = rep(as.factor(out$SPP_NAME), (max_year-1)),  # No data as of now
                             year = as.numeric((min_year+1):max_year), # Dimentions defined by nsp, nyr and iter
                             MeanPercentdif = as.numeric(NA),
                             CI2.5 = as.numeric(NA),
                             CI97.5 = as.numeric(NA))
    
    #Get the summary output for the rows and columns that we are interested in
    for (i in min_year:(max_year-1)){
      data_frame[i, "MeanPercentdif"]  <- (sparta::occurrenceChange(firstYear = i, 
                                                                    lastYear = (i+1), 
                                                                    out, 
                                                                    change = "percentdif"))$mean
      data_frame[i, "CI2.5"]  <- unname((sparta::occurrenceChange(firstYear = i, 
                                                                  lastYear = (i+1), 
                                                                  out, 
                                                                  change = "percentdif"))$CI[1])
      data_frame[i, "CI97.5"]  <- unname((sparta::occurrenceChange(firstYear = i, 
                                                                  lastYear = (i+1), 
                                                                  out, 
                                                                  change = "percentdif"))$CI[2])
      if((data_frame[i, "MeanPercentdif"]) <0){
        data_frame[i, "MeanPercentdif"] <- abs(data_frame[i, "MeanPercentdif"])
        data_frame[i, "CI2.5"] <- abs(data_frame[i, "CI2.5"])
        if((data_frame[i, "CI97.5"]) >0){
          data_frame[i, "CI97.5"] <- (data_frame[i, "CI97.5"])*-1
        }
      }
    }
    return(data_frame)
  }
  
  if(verbose) cat('Loading data...')
  # Use lapply to run this function on all files
  list_summaries <- lapply(file.path(input_dir, files), read_bayes)
  
  # Unlist these and bind them together
  out_data <- do.call(rbind, list_summaries)
  
  # subset the out_data into pre and post a cut off year and split each by species
  #outEarly <- subset(out_data, year <cutoff)
  #outLate <- subset(out_data, year >(cutoff-1))
  #outEarly <- split(outEarly, outEarly$species)
  #outLate <- split(outLate, outLate$species)
  outEarly <- split((subset(out_data, year <cutoff)), out_data$species)
  outLate <- split((subset(out_data, year >(cutoff-1))), out_data$species)
  
  # list the species
  spp <- unique(out_data$species)
  
  # Create two dfs for pre and post a cut off year
  PreCutoff <- data.frame(species = (as.factor(spp)), 
                          MeanPercentdif = as.numeric(NA),
                          SD = as.numeric(NA),
                          CI2.5 = as.numeric(NA),
                          CI97.5 = as.numeric(NA))
  PostCutoff <- data.frame(species = (as.factor(spp)), 
                           MeanPercentdif = as.numeric(NA),
                           SD = as.numeric(NA),
                           CI2.5 = as.numeric(NA),
                           CI97.5 = as.numeric(NA))
  
  
  for(i in 1:length(spp)){
    PreCutoff[i, "MeanPercentdif"] <- mean((outEarly[[i]])$MeanPercentdif)
    PreCutoff[i, "SD"] <- sd((outEarly[[i]])$MeanPercentdif)
    PreCutoff[i, "CI2.5"] <- mean((outEarly[[i]])$CI2.5)
    PreCutoff[i, "CI97.5"] <- mean((outEarly[[i]])$CI97.5)
  } 
  
  for(i in 1:length(spp)){
    PostCutoff[i, "MeanPercentdif"] <- mean((outLate[[i]])$MeanPercentdif)
    PostCutoff[i, "SD"] <- sd((outLate[[i]])$MeanPercentdif)
    PostCutoff[i, "CI2.5"] <- mean((outLate[[i]])$CI2.5)
    PostCutoff[i, "CI97.5"] <- mean((outLate[[i]])$CI97.5)
  } 
  
  cutoff_year <- cutoff
  names(cutoff_year) <- "cutoff_year"
  names(max_year) <- "max_year"
  names(min_year) <- "min_year"
  
  output <- list(PreCutoff, PostCutoff, min_year, max_year, cutoff_year)
  
  if(verbose) cat('done\n')
  return(output)
}
