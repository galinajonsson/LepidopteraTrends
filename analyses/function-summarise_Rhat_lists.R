# Function to summarise whether or not all occupancy estimates throughout the time series have converged (based on Rhat-values) for many .rds files in an input directory
# This function reads in and summarises all the .rds files' Rhat values (all values below 1.1 or not) for the occupancy estimates
summarise_Rhat_lists <-  function(input_list, verbose = TRUE) {
  
library(reshape2)
require(dplyr)
  
  summary_out <- data.frame(species_name = character(length(input_list)),
                            converged = character(length(input_list)), 
                            stringsAsFactors = FALSE)
  
# create a function to read in the data we want from these .rds files
  
  
  for(i in 1:length(input_list)){
    
    out <- input_list[[i]]
    
    
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
    temp_out <- as.data.frame(out$BUGSoutput$summary)
    
    rows <- grep("^(psi.fs[^.r])", row.names(temp_out))
    
    for (j in rows) {
      if (temp_out[j, c("Rhat")] > 1.1) 
        {
        convergenceYN <- "N"
        break
        }
      if (j == max(rows)) {
        convergenceYN <- "Y"
      }
    }
    
    
    summary_out[i, 1] <- out$SPP_NAME
    summary_out[i, 2] <- convergenceYN
    
    }


if(verbose) cat('Loading data...')

# Use lapply to run this function on all files
#list_summaries <- lapply(input_list, sum_element)
#if(verbose) cat('done\n') 
  
# Unlist these and bind them together
#spp_data <- do.call(rbind, summary_out)
  
return(summary_out)

}
