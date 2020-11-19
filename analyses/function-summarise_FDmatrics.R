# This function summarises FEveSum, FDivSum, FDisSum and CWMs generate by the FD package using the "extractPosterior" function

summarise_FDmatrics <-  function(FD_list, iterations, years) {
  
  #library(reshape2)
  #require(dplyr)
  require(plotrix)
  
  ###################################################################################
  ############### Summarise Functional evenness (FEve) across iterations ############
  ###################################################################################
  
  # Create a data frame with all FEve values from the first iteration
  FEveSum <- as.data.frame(FD_list$Iter1$FEve)
  
  ### Rename the column
  names(FEveSum)[1] <- "Iter1"
  
  # Loop through all matrices in FD_list (starting from 2) and populate FEveSum with FEve values
  for(i in 2:iterations){
    FEveSum[,i] <- FD_list[[i]]$FEve
  }
  
  # Name each column (i.e. iteration) "Iter" followed by number
  nameList <- paste("Iter", 1:iterations, sep = "")
  names(FEveSum)[1:iterations] <- nameList
  
  # Add a year column
  FEveSum$year <- as.integer(1:years)
  
  # Add a mean and standard deviation collumn
  FEveSum$mean <- apply(FEveSum[,1:iterations], 1, mean)
  FEveSum$sd <- apply(FEveSum[,1:iterations], 1, sd)
  FEveSum$sem <- apply(FEveSum[,1:iterations], 1, std.error)
  
  
  ###################################################################################
  ############## Summarise Functional diversity (FDiv) across iterations ############
  ###################################################################################
  
  # Create a data frame with all FDiv values from the first iteration
  FDivSum <- as.data.frame(FD_list$Iter1$FDiv)
  
  ### Rename the column
  names(FEveSum)[1] <- "Iter1"
  
  # Loop through all matrices in FD_list (starting from 2) and populate FEveSum with FEve values
  for(i in 2:iterations){
    FDivSum[,i] <- FD_list[[i]]$FDiv
  }
  
  # Name each column (i.e. iteration) "Iter" followed by number
  nameList <- paste("Iter", 1:iterations, sep = "")
  names(FDivSum)[1:iterations] <- nameList
  
  # Add a year column
  FDivSum$year <- as.integer(1:years)
  
  # Add a mean and standard deviation collumn
  FDivSum$mean <- apply(FDivSum[,1:iterations], 1, mean)
  FDivSum$sd <- apply(FDivSum[,1:iterations], 1, sd)
  FDivSum$sem <- apply(FDivSum[,1:iterations], 1, std.error)
  
  
  
  ###################################################################################
  ############## Summarise Functional diversity (FDiv) across iterations ############
  ###################################################################################
  
  # Create a data frame with all FDiv values from the first iteration
  FDivSum <- as.data.frame(FD_list$Iter1$FDiv)
  
  ### Rename the column
  names(FEveSum)[1] <- "Iter1"
  
  # Loop through all matrices in FD_list (starting from 2) and populate FEveSum with FEve values
  for(i in 2:iterations){
    FDivSum[,i] <- FD_list[[i]]$FDiv
  }
  
  # Name each column (i.e. iteration) "Iter" followed by number
  nameList <- paste("Iter", 1:iterations, sep = "")
  names(FDivSum)[1:iterations] <- nameList
  
  # Add a year column
  FDivSum$year <- as.integer(1:years)
  
  # Add a mean and standard deviation collumn
  FDivSum$mean <- apply(FDivSum[,1:iterations], 1, mean)
  FDivSum$sd <- apply(FDivSum[,1:iterations], 1, sd)
  require(plotrix)
  FDivSum$sem <- apply(FDivSum[,1:iterations], 1, std.error)
  
  
  ###################################################################################
  ########### Summarise Functional dissimilarity (FDis) across iterations ###########
  ###################################################################################
  
  # Create a data frame with all FDiv values from the first iteration
  FDisSum <- as.data.frame(FD_list$Iter1$FDis)
  
  ### Rename the column
  names(FDisSum)[1] <- "Iter1"
  
  # Loop through all matrices in FD_list (starting from 2) and populate FEveSum with FEve values
  for(i in 2:iterations){
    FDisSum[,i] <- FD_list[[i]]$FDis
  }
  
  # Name each column (i.e. iteration) "Iter" followed by number
  nameList <- paste("Iter", 1:iterations, sep = "")
  names(FDisSum)[1:iterations] <- nameList
  
  # Add a year column
  FDisSum$year <- as.integer(1:years)
  
  # Add a mean and standard deviation and standard error of the mean collumn
  FDisSum$mean <- apply(FDisSum[,1:iterations], 1, mean)
  FDisSum$sd <- apply(FDisSum[,1:iterations], 1, sd)
  require(plotrix)
  FDisSum$sem <- apply(FDisSum[,1:iterations], 1, std.error)
  
  ###################################################################################
  #################### Summarise Community weighted means (CWMs) ####################
  ###################################################################################
  
  # find number of traits
  traits <- length(FD_list$Iter1$CWM)
  
  # Make a list with one data frame for each trait
  CWM_list = replicate(n = traits,
                       expr = {data.frame(iter1= rep(NA, years))},
                       simplify = F)
  
  # Name the data frames in the list according to trait number
  names(CWM_list) <- names(FD_list$Iter1$CWM)
  
  
  # Loop through each trait
  for (t in 1:traits){
    
    for  (i in 1:iterations){
      tempIter <- FD_list[[t]]
      CWM_list[[t]][,i] <- as.numeric(tempIter$CWM[[t]])
    }
    
    # Name each column (i.e. iteration) "Iter" followed by number
    nameList <- paste("Iter", 1:iterations, sep = "")
    names(CWM_list[[t]])[1:iterations] <- nameList
    
    # Add a year column
    CWM_list[[t]]$year <- as.integer(1:years)
    
    # Add a mean and standard deviation and standard error of the mean collumn
    CWM_list[[t]]$mean <- apply(CWM_list[[t]][,1:iterations], 1, mean)
    CWM_list[[t]]$sd <- apply(CWM_list[[t]][,1:iterations], 1, sd)
    CWM_list[[t]]$sem <- apply(CWM_list[[t]][,1:iterations], 1, std.error)
  }
  
  ###### Put all in a list
  
  output <- list(FEveSum, FDivSum, FDisSum, CWM_list)
  names(output) <- c("FEveSum", "FDivSum", "FDisSum", "CWM_list")
  return(output)
}
  