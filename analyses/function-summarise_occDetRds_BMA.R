summarise_occDetRdsBMA <-  function(input_dir, region = NULL, verbose = TRUE){
  
  library(reshape2)
  require(dplyr)
  
  # get files from the input directory
  files <- (list.files(path = paste(input_dir), ignore.case = TRUE, pattern = '\\.rds$')) # list of the files to loop through
  # sense check these file names
  if(length(files) == 0) stop('No .rds files found in ', input_dir)
  if(length(files) < length(list.files(path = input_dir))) warning('Not all files in ', input_dir, ' are .rds files, other file types have been ignored')
  
  # Create empty data frame to be populated
  output <- data.frame("species" = character(),
                       "year"= numeric(),
                       "index" = numeric(),
                       "se" = numeric())

  
  # create a function to read in the data we want from these .rds files
 for (file in files){
   infile <- file.path(input_dir, file)
      out <- readRDS(infile) 
      #file.path(input_dir, files)
      #infile <- paste(i,".txt",sep="")
      
      # some old outputs dont have min year in which case make it == 1
      min_year <- ifelse(is.null(out$min_year), 1, out$min_year)
      #Get the summary output for the rows and columns that we are interested in
      temp_out <- as.data.frame(out$BUGSoutput$summary)
      # 
      rows <- grep("^(psi.fs[^.r])", row.names(temp_out))
      # Enter species name
      pos <- nrow(output)
      # Enter the species name as a new factor level
      levels(output$species) <- c(levels(output$species), out$SPP_NAME)
      # Enter species name
      output[((pos+1):(pos+(length(rows)))), 1] <- out$SPP_NAME
      # Enter years
      output[(pos+1):(pos+(length(rows))), 2] <- seq(min_year, (length(rows)))
      # Enter index
      output[(pos+1):(pos+(length(rows))), 3] <- (out$BUGSoutput$summary[grepl(pattern="psi.fs\\[", x=dimnames(out$BUGSoutput$summary)[[1]]), c("mean")])
      # Enter sd
      output[(pos+1):(pos+(length(rows))), 4] <- (out$BUGSoutput$summary[grepl(pattern="psi.fs\\[", x=dimnames(out$BUGSoutput$summary)[[1]]), c("sd")])
 }
      ### Replace the output
      return(output)
}
