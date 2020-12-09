# Function to summarise occupancy estimates throughout the time series for many .rds files in an input directory
# This function reads in and summarises all the .rds files' mean occupancy and detection year effect throughout the time series, as well as the mean effect of data types, list lengths and the last years mean occupancy 

sumOccDet_output <-  function(input_dir, verbose = TRUE) {
  
  library(reshape2)
  require(dplyr)
  
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
    
    # some old outputs don't have min year in which case make it == 1
    min_year <- ifelse(is.null(out$min_year), 1, out$min_year)
    
    max_year <- out$max_year
    
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
    dtype2.p_row <- grep("^(dtype2.p[^.r])", row.names(temp_out))
    DT2effect_mean <- inv.logit(temp_out[dtype2.p_row, c("mean")])
    dtype3.p_row <- grep("^(dtype3.p[^.r])", row.names(temp_out))
    DT3effect_mean <- inv.logit(temp_out[dtype3.p_row, c("mean")])
    LLp_row <- grep("^(LL.p[^.r])", row.names(temp_out))
    LLeffect_mean <- inv.logit(temp_out[LLp_row, c("mean")])
    
    # summmarise
    summary_out <- c(species_name = out$SPP_NAME,
                              Occupancy_lastYrX = Occupancy_lastYr,
                              MeanOccupancy_meanX = MeanOccupancy_mean,
                              MeanOccupancy_sdX = MeanOccupancy_sd,
                              MeanYearEffect_meanX = MeanYearEffect_mean,
                              MeanYearEffect_sdX = MeanYearEffect_sd,
                              DT2effect_meanX = DT2effect_mean,
                              DT3effect_meanX = DT3effect_mean,
                              LLeffect_meanX = LLeffect_mean)
    return(summary_out)
  }
  
  if(verbose) cat('Loading data...')
  # Use lapply to run this function on all files
  list_summaries <- lapply(file.path(input_dir, files), read_bayes)
  if(verbose) cat('done\n')
  
  # Unlist these and bind them together
  spp_data <- do.call(rbind, list_summaries)
  
  return(spp_data)
}
