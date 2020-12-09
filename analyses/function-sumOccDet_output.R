# Function to summarise occupancy estimates throughout the time series for many .rds files in an input directory
# This function reads in and summarises all the .rds files' mean occupancy and detection year effect throughout the time series, as well as the mean effect of data types, list lengths and the last years mean occupancy 
# There is also an option to categorise species into low, medium or high occupancies based on the last years occupancy estimates. To do so one must provide a vector with four numbers indicating the three ranges which define the three categories. 

sumOccDet_output <-  function(input_dir, verbose = TRUE, categoriseOccu = FALSE, quantileProbs = NULL) {
  
  require(reshape2)
  require(dplyr)
  require(plyr)
  require(boot)
  
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
    return(out)
  }
  
  # create a function to read in the data we want from these .rds files
  read_bayes <- function(file){
    
    out <- loadrds(file) 
    
    #Get the summary output for the rows and columns that we are interested in
    temp_out <- as.data.frame(out$BUGSoutput$summary)
    
    # psi.fs
    psifs_rows <- grep("^(psi.fs[^.r])", row.names(temp_out))
    psifs_dat <- temp_out[min(psifs_rows):max(psifs_rows),]
    Occupancy_lastYr <- psifs_dat[nrow(psifs_dat), c("mean")]
    MeanOccupancy_mean <- mean(psifs_dat[, c("mean")])
    MeanOccupancy_sd <- stats::sd(psifs_dat[, c("mean")])
    
    # alpha.p (Year effect)
    alpha.p_rows <- grep("^(alpha.p[^.r])", row.names(temp_out))
    alpha.p_dat <- temp_out[min(alpha.p_rows):max(alpha.p_rows),]
    MeanYearEffect_mean <- mean(inv.logit(alpha.p_dat[, c("mean")]))
    MeanYearEffect_sd <- stats::sd(inv.logit(alpha.p_dat[, c("mean")]))
    
    # Detection
    dtype2.p_row <- grep("dtype2.p", row.names(temp_out))
    DT2effect_mean <- inv.logit(mean(alpha.p_dat[, c("mean")])+(temp_out[dtype2.p_row, c("mean")]))
    dtype3.p_row <- grep("dtype3.p", row.names(temp_out))
    DT3effect_mean <- inv.logit(mean(alpha.p_dat[, c("mean")])+(temp_out[dtype3.p_row, c("mean")]))
    LLp_row <- grep("^LL.p", row.names(temp_out))
    LLeffect_mean <- inv.logit(mean(alpha.p_dat[, c("mean")])+(temp_out[LLp_row, c("mean")]))
    
    # summmarise
    summary_out <- c(species_name = out$SPP_NAME,
                              Occupancy_lastYr = Occupancy_lastYr,
                              MeanOccupancy_mean = MeanOccupancy_mean,
                              MeanOccupancy_sd = MeanOccupancy_sd,
                              MeanYearEffect_mean = MeanYearEffect_mean,
                              MeanYearEffect_sd = MeanYearEffect_sd,
                              DT2effect_mean = DT2effect_mean,
                              DT3effect_mean = DT3effect_mean,
                              LLeffect_mean = LLeffect_mean)
    return(summary_out)
  }
  
  if(verbose) cat('Loading data...')
  # Use lapply to run this function on all files
  list_summaries <- lapply(file.path(input_dir, files), read_bayes)
  if(verbose) cat('done\n')
  
  # Unlist these and bind them together
  spp_data <- do.call(rbind, list_summaries)
  
  # If categoriseOccu is true 
  if(isTRUE(categoriseOccu)){
    
    # Check that "quantileProbs" is given as a vector with four items
    if(!(is.vector(quantileProbs))){
      stop('quantileProbs is not specified or not specified as a vector')
    }
    if(!(length(quantileProbs) == 4)){
      stop('four numbers are not specified for quantileProbs')
    }
    
    category = cut(as.numeric(spp_data[,"Occupancy_lastYr"]), 
                   quantile(as.numeric(spp_data[,"Occupancy_lastYr"]), probs = quantileProbs), 
                   labels = c('Low', 'Medium', 'High'), 
                   include.lowest = TRUE)
    
    spp_data <- cbind(spp_data, category)
  }
  
  spp_data <- data.frame(spp_data)
  spp_data$category <- as.factor(spp_data$category)
  revalue(spp_data$category, c("1"="Low", "2"="Medium", "3"="High"))
  spp_data$species_name <- as.factor(spp_data$species_name)
  spp_data$Occupancy_lastYr <- as.numeric(spp_data$Occupancy_lastYr)
  spp_data$MeanOccupancy_mean <- as.numeric(spp_data$MeanOccupancy_mean)
  spp_data$MeanOccupancy_sd <- as.numeric(spp_data$MeanOccupancy_sd)
  spp_data$MeanYearEffect_mean <- as.numeric(spp_data$MeanYearEffect_mean)
  spp_data$MeanYearEffect_sd <- as.numeric(spp_data$MeanYearEffect_sd)
  spp_data$DT2effect_mean <- as.numeric(spp_data$DT2effect_mean)
  spp_data$DT3effect_mean <- as.numeric(spp_data$DT3effect_mean)
  spp_data$LLeffect_mean <- as.numeric(spp_data$LLeffect_mean)
  
  
  
  return(spp_data)
}
