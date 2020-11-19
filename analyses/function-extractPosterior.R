# This function extracts a specified number of random occupancy estimates from the posterior distribution of multiple .rds files in a specified input directory. 
# This function reads in and extracts a specified number of occupancy estimates from the posterior distribution of all the .rds files in the input directory.

summarise_posterior <-  function(input_dir, iterations, years, verbose = TRUE) {
  
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
    if(!("sims.list" %in% ls(out$BUGSoutput))){
      stop('The rds file(s) do not contain a sims.list in the "BUGSoutput" object.')
    }
    if(!("SPP_NAME" %in% ls(out))){
      stop('The rds file(s) do not contain a "SPP_NAME" object.')
    }
    if(!("psi.fs" %in% ls(out$BUGSoutput$sims.list))){
      stop('The rds file(s) do not contain psi.fs in the "BUGSoutput$sims.list" object.')
    }
  #  if(!("max_year" %in% ls(out))){
  #    stop('The rds file(s) do not contain a "max_year" object.')
  #  }
    return(out)
  }
  
  # Create a list of matrices defined by the number of intereations specified by the argument "iterations"
  sim_list = replicate(n = iterations,
                       expr = {matrix(0, nrow = years, ncol = length(files))},
                       simplify = F)
  
  # Create a vector to fill with species names, length defined by the number of rds files in the input directory
  spp_names <- c()
  
  # Loop through all files and extract the relevant information
  
  for (g in 1:length(files)) {
    
    # Load the model output file
    out <- loadrds(file.path(input_dir, files[g]))
    
    # Extract the species name
    sp_name <- out$SPP_NAME
    
    # Add it so the list of species names 
    spp_names <- c(spp_names, sp_name)
    
    # Extract the species' matrix with all occupancy simulations for all time periods
    out_psi.fs <- out$BUGSoutput$sims.list$psi.fs
    
    # Find the total number of iterations
    total_its <- length(out_psi.fs[,1])
    
    # Check that the number of iterations defined in the iterations argument doesn't exceed the total number of iterations
    if(total_its < iterations){
      warning('Available iterations in ', files[g], 
              ' are less than defined by "iterations" argument. File has been ignored.')
      
    } else if(total_its >= iterations){
    
    # randomly subset a number of these defined by the argument "iterations"
    selected_its <- sample(total_its, iterations ,replace = FALSE)
    
    # For each year
    for (i in 1:length(out_psi.fs[1,])) { 
      # And for each of the randomly selecetd iteration numbers
      for (j in 1:length(selected_its)) {
        
        # Add the value of the jth iteration in year i to the jth matrix in sim_list
        sim_list[[j]][i,g] <- (out_psi.fs[selected_its[j],i])
      }
      }
    }
  }

  if(verbose) cat('done\n')
  
  # Create a vector with names for the rows in the data (the years)
  yearVec <- c()
  
  # Loop through the numbers of itterations defined and populate vector with "iterationNo" followed by the number
  for (n in 1:years) {
    yearName <- as.character(paste("year", n, sep = ""))
    yearVec <- c(yearVec, yearName)
  }
  
  # Name the columns and row of each matrix in sim_list
  for (y in 1:iterations) {
    colnames(sim_list[[y]]) <- spp_names
    rownames(sim_list[[y]]) <- yearVec
  }
  
  
  return(sim_list)
}
