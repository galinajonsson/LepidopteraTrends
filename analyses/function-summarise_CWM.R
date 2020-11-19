# This function summarises a named CWM generate by the FD package using the "extractPosterior" function

summarise_CWM <-  function(FD_list, CWM_number, iterations, years) {
  
  # Create a data frame with all FEve values from the first iteration
  temp <- FD_list[[1]]
  
  out <- as.data.frame(temp$CWM[CWM_number])
  
  # Loop through all matrices in FD_list (starting from 2) and populate out
  for(i in 2:iterations){
    
    temp <- FD_list[[i]]
    
    out[,i] <- temp$CWM[CWM_number]
    
  }
  
  # Name each column (i.e. iteration) "Iter" followed by number
  nameList <- paste("Iter", 1:iterations, sep = "")
  names(out)[1:iterations] <- nameList
  
  # Add a year column
  out$year <- as.integer(1:years)
  #out[,1:iterations] <- as.numeric(out[,1:iterations])
  
  # Add a mean and standard deviation collumn
  out$mean <- apply(out[,1:iterations], 1, mean)
  out$sd <- apply(out[,1:iterations], 1, sd)
  out$sem <- apply(out[,1:iterations], 1, std.error)
  
  return(out)
}
