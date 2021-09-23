#' Function to find number and proportions of overlapping sites, time periods and site:time period combinations between data types
#' 
#' @param taxon_name A character giving the name of the species.
#' @param occDetdata The 2nd element of the object returned by formatOccData.
#' @param spp_vis The 1st element of the object returned by formatOccData.
#' @param modeltype A character string specifying the model type to use. See details. Note that only fully and partially categorical list lenth specifications are supported (catlistlength, mixlistlength and mixlistlength2)
#' @param minTP numeric, defaults to NA. If a subset of time periods should be used - the first time period to use. 
#' @param maxTP numeric, defaults to NA. If a subset of time periods should be used - the last time period to use. 
#' @param TP 
#' @param TPinterval
#' @param ... Additional arguments passed to ggplot

#' @import dplyr
#' @method plot occDet
#' @export


########################################################
# 
# NOTE: Not finished code allowing for several TPinterval values (lines 301-309)
#
########################################################


DT.overlap <- function(taxon_name = taxon_name,
                      occDetdata = occDetdata,
                      spp_vis = spp_vis,
                      modeltype = NULL, 
                      minTP = min(occDetdata$TP), 
                      maxTP = max(occDetdata$TP),
                      TP = occDetdata$TP,
                      TPinterval = NULL,
                      ...){
  
  
  ################## BASIC CHECKS
  # Check the modeltype is specified correctly
  if(!any(c('catlistlength', 'mixlistlength', 'mixlistlength2') %in% modeltype)){
    stop('modeltype should contain one of "catlistlength", "mixlistlength" or "mixlistlength2", which specify the list-length effect to be used')
  }
  # Check the taxon_name exists in supplied spp_vis data
  if(!taxon_name %in% colnames(spp_vis)){ 
    stop('taxon_name is not the name of a taxa in spp_vis')
  }
  # Check spp_vis and occDetdata contain visit column
  if(!'visit' %in% colnames(spp_vis) || !'visit' %in% colnames(occDetdata)){
    stop('spp_vis and/or occDetdata do not contain column named visit')
  }
  # Check spp_vis and occDetdata contain matching visits
  if(!identical(spp_vis$visit, occDetdata$visit) || !nrow(spp_vis)==nrow(occDetdata)){
    stop('spp_vis and occDetdata contain different visits')
  }

    
  
  
  ### If minTP and/or maxTP specified 
  if(!is.null(minTP) | !is.null(maxTP)){ 
    # Check that minTP and maxTP exist within the supplied data
    if(!is.null(minTP) & is.null(maxTP)){ 
      message('minTP is specified but maxTP is not specified, maxTP is assumed to be the last TP in spp_vis')
    }
    if(!is.null(maxTP) & is.null(minTP)){ 
      message('maxTP is specified but minTP is not specified, minTP is assumed to be the first TP in spp_vis')
    }
    # Check that minTP and maxTP exist within the supplied data, if specified
    if(!minTP %in% occDetdata$TP | !maxTP %in% occDetdata$TP){ 
     stop('minTP and/or maxTP do not exist in occDetdata')
    }
    
    ### Extract relevant data for specified taxon
    spp_vis <- spp_vis[,c("visit", paste0(taxon_name))]
    occDetdata <- merge(occDetdata, spp_vis, 
                        by= "visit", all.x = T, all.y = F)
    #Subset specified years
    occDetdata <- subset(occDetdata, TP >= minTP & TP <= maxTP)
    
    
    ### If minTP and maxTP are NOT specified
    } else{
      ### Extract relevant data for specified taxon
      spp_vis <- spp_vis[,c("visit", paste0(taxon_name))]
      occDetdata <- merge(occDetdata, spp_vis, 
                          by= "visit", all.x = T, all.y = F)
    }
  
    
    
    
    

    
    extractData <- function(occDetdata){
      
      ### Create list with info and dataframes to populate
      out <- list()
      
      out$taxon <- paste0(taxon_name)
      out$modeltype <- as.character(modeltype)
      out$minTP <- minTP 
      out$maxTP <- maxTP 
      
      out$data <- as.data.frame(matrix(ncol=8,nrow=8))
      names(out$data) <- c("data","dataType","visits","sites","site_TPs","visits_prop","sites_prop","site_TPs_prop")
      out$data[,c("data")] <- as.factor(rep(c("All", paste0(taxon_name)), each = 4))
      out$data[,c("dataType")] <- as.factor(rep(c("Total", "1", "2", "3"), times = 2))
      
      out$overlap <- as.data.frame(matrix(ncol=3,nrow=3))
      names(out$overlap) <- c("sites", "site_TPs", "TPs")
      row.names(out$overlap) <-  c("1-2", "1-3", "2-3")
      
    
    ### Ad site:time period combination column
    occDetdata$siteTP <- paste(TP, occDetdata$site, sep = "")
    
    
    ##############################################################
    ######### For mixlistlength or mixlistlength2 models #########
    ##############################################################
    if(modeltype == 'mixlistlength' | modeltype == 'mixlistlength2'){
      # Find number of unique visits, sites and site:time period per data type (if specified, between minTP and maxTP)
      # visits
      out$data[1:4,] <- out$data[1:4,] %>% mutate(visits = case_when(
        dataType=="Total" ~ nrow(occDetdata), 
        dataType=="1" ~ nrow(subset(occDetdata, L < 22222)), # DT1
        dataType=="2" ~ nrow(subset(occDetdata, L == 22222)), # DT2
        dataType=="3" ~ nrow(subset(occDetdata, L == 33333)))) # DT3
      # sites
      out$data[1:4,] <- out$data[1:4,] %>% mutate(sites = case_when(
        dataType=="Total" ~ length(unique(occDetdata$site)),
        dataType=="1" ~ length(unique(subset(occDetdata, L < 22222)$site)), # DT1
        dataType=="2" ~ length(unique(subset(occDetdata, L == 22222)$site)), # DT2
        dataType=="3" ~ length(unique(subset(occDetdata, L == 33333)$site)))) # DT3
      # site:time period combinations
      out$data[1:4,] <- out$data[1:4,] %>% mutate(site_TPs = case_when(
        dataType=="Total" ~ length(unique(occDetdata$siteTP)),
        dataType=="1" ~ length(unique(subset(occDetdata, L < 22222)$siteTP)), # DT1
        dataType=="2" ~ length(unique(subset(occDetdata, L == 22222)$siteTP)), # DT2
        dataType=="3" ~ length(unique(subset(occDetdata, L == 33333)$siteTP)))) # DT3
      # proportions
      out$data[1, c("visits_prop","sites_prop","site_TPs_prop")] <- NA
      out$data[2:4, "visits_prop"] <- out$data[2:4,"visits"]/out$data[1,"visits"] # visits
      out$data[2:4, "sites_prop"] <- out$data[2:4,"sites"]/out$data[1,"sites"] # sites
      out$data[2:4, "site_TPs_prop"] <- out$data[2:4,"site_TPs"]/out$data[1,"site_TPs"] # site:time period combinations


      ##############################################################
      ################## For catlistlength models ##################
      ##############################################################
      } else if(modeltype == 'catlistlength'){
        # Find number of unique visits, sites and site:time period per data type (if specified, between minTP and maxTP)
        # visits
        out$data[1:4,] <- out$data[1:4,] %>% mutate(visits = case_when(
        dataType=="Total" ~ nrow(occDetdata), 
        dataType=="1" ~ nrow(subset(occDetdata, L == 1)), # DT1
        dataType=="2" ~ nrow(subset(occDetdata, L > 1 & L < 4)), # DT2
        dataType=="3" ~ nrow(subset(occDetdata, L > 3)))) # DT3
        # sites
        out$data[1:4,] <- out$data[1:4,] %>% mutate(sites = case_when(
          dataType=="Total" ~ length(unique(occDetdata$site)),
          dataType=="1" ~ length(unique(subset(occDetdata, L == 1)$site)), # DT1
          dataType=="2" ~ length(unique(subset(occDetdata, L > 1 & L < 4)$site)), # DT2
          dataType=="3" ~ length(unique(subset(occDetdata, L > 3)$site)))) # DT3
        # site:time period combinations
        out$data[1:4,] <- out$data[1:4,] %>% mutate(site_TPs = case_when(
          dataType=="Total" ~ length(unique(occDetdata$siteTP)),
          dataType=="1" ~ length(unique(subset(occDetdata, L == 1)$siteTP)), # DT1
          dataType=="2" ~ length(unique(subset(occDetdata, L > 1 & L < 4)$siteTP)), # DT2
          dataType=="3" ~ length(unique(subset(occDetdata, L > 3)$siteTP)))) # DT3
        # proportions
        out$data[1, c("visits_prop","sites_prop","site_TPs_prop")] <- NA
        out$data[2:4, "visits_prop"] <- out$data[2:4,"visits"]/out$data[1,"visits"] # visits
        out$data[2:4, "sites_prop"] <- out$data[2:4,"sites"]/out$data[1,"sites"] # sites
        out$data[2:4, "site_TPs_prop"] <- out$data[2:4,"site_TPs"]/out$data[1,"site_TPs"] # site:time period combinations
      }
    
    
    
    
    
    
    
    ####################################################
    ##############  for specified taxon  ###############
    ####################################################
    
    ## Subset visits with specified taxon occurences
    occDetdata_spp <- occDetdata[occDetdata[,paste0(taxon_name)],]
    
    
    
    ##############################################################
    ######### For mixlistlength or mixlistlength2 models #########
    ##############################################################
    if(modeltype == 'mixlistlength' | modeltype == 'mixlistlength2'){ 
     # Find number of unique visits, sites and site:time period per data type (if specified, between minTP and maxTP)
      # visits
      out$data[5:8,] <- out$data[5:8,] %>% mutate(visits = case_when(
        dataType=="Total" ~ nrow(occDetdata_spp), 
        dataType=="1" ~ nrow(subset(occDetdata_spp, L < 22222)), # DT1
        dataType=="2" ~ nrow(subset(occDetdata_spp, L == 22222)), # DT2
        dataType=="3" ~ nrow(subset(occDetdata_spp, L == 33333)))) # DT3
      # sites
      out$data[5:8,] <- out$data[5:8,] %>% mutate(sites = case_when(
        dataType=="Total" ~ length(unique(occDetdata_spp$site)),
        dataType=="1" ~ length(unique(subset(occDetdata_spp, L < 22222)$site)), # DT1
        dataType=="2" ~ length(unique(subset(occDetdata_spp, L == 22222)$site)), # DT2
        dataType=="3" ~ length(unique(subset(occDetdata_spp, L == 33333)$site)))) # DT3
      # site:time period combinations
      out$data[5:8,] <- out$data[5:8,] %>% mutate(site_TPs = case_when(
        dataType=="Total" ~ length(unique(occDetdata_spp$siteTP)),
        dataType=="1" ~ length(unique(subset(occDetdata_spp, L < 22222)$siteTP)), # DT1
        dataType=="2" ~ length(unique(subset(occDetdata_spp, L == 22222)$siteTP)), # DT2
        dataType=="3" ~ length(unique(subset(occDetdata_spp, L == 33333)$siteTP)))) # DT3
      # proportions
      out$data[5, c("visits_prop","sites_prop","site_TPs_prop")] <- NA
      out$data[5:8, "visits_prop"] <- out$data[5:8,"visits"]/out$data[5,"visits"] # visits
      out$data[5:8, "sites_prop"] <- out$data[5:8,"sites"]/out$data[5,"sites"] # sites
      out$data[5:8, "site_TPs_prop"] <- out$data[5:8,"site_TPs"]/out$data[5,"site_TPs"] # site:time period combinations
    
      ## Overlap
      out$overlap["1-2", "sites"] <- length(unique((subset(occDetdata_spp, L<22222))$site[(subset(occDetdata_spp, L<22222))$site %in% (subset(occDetdata_spp, L==22222))$site]))
      out$overlap["1-3", "sites"] <- length(unique((subset(occDetdata_spp, L<22222))$site[(subset(occDetdata_spp, L<22222))$site %in% (subset(occDetdata_spp, L==33333))$site]))
      out$overlap["2-3", "sites"] <- length(unique((subset(occDetdata_spp, L==22222))$site[(subset(occDetdata_spp, L==22222))$site %in% (subset(occDetdata_spp, L==33333))$site]))
      out$overlap["1-2", "site_TPs"] <- length(unique((subset(occDetdata_spp, L<22222))$siteTP[(subset(occDetdata_spp, L<22222))$siteTP %in% (subset(occDetdata_spp, L==22222))$siteTP]))
      out$overlap["1-3", "site_TPs"] <- length(unique((subset(occDetdata_spp, L<22222))$siteTP[(subset(occDetdata_spp, L<22222))$siteTP %in% (subset(occDetdata_spp, L==33333))$siteTP]))
      out$overlap["2-3", "site_TPs"] <- length(unique((subset(occDetdata_spp, L==22222))$siteTP[(subset(occDetdata_spp, L==22222))$siteTP %in% (subset(occDetdata_spp, L==33333))$siteTP]))
      out$overlap["1-2", "TPs"] <- length(unique((subset(occDetdata_spp, L<22222))$TP[(subset(occDetdata_spp, L<22222))$TP %in% (subset(occDetdata_spp, L==22222))$TP]))
      out$overlap["1-3", "TPs"] <- length(unique((subset(occDetdata_spp, L<22222))$TP[(subset(occDetdata_spp, L<22222))$TP %in% (subset(occDetdata_spp, L==33333))$TP]))
      out$overlap["2-3", "TPs"] <- length(unique((subset(occDetdata_spp, L==22222))$TP[(subset(occDetdata_spp, L==22222))$TP %in% (subset(occDetdata_spp, L==33333))$TP]))
      
      
      
      
      
      ##############################################################
      ################## For catlistlength models ##################
      ##############################################################
    } else if(modeltype == 'catlistlength'){
      # Find number of unique visits, sites and site:time period per data type (if specified, between minTP and maxTP)
      # visits
      out$data[5:8,] <- out$data[5:8,] %>% mutate(visits = case_when(
        dataType=="Total" ~ nrow(occDetdata_spp), 
        dataType=="1" ~ nrow(subset(occDetdata_spp, L == 1)), # DT1
        dataType=="2" ~ nrow(subset(occDetdata_spp, L > 1 & L < 4)), # DT2
        dataType=="3" ~ nrow(subset(occDetdata_spp, L > 3)))) # DT3
      # sites
      out$data[5:8,] <- out$data[5:8,] %>% mutate(sites = case_when(
        dataType=="Total" ~ length(unique(occDetdata_spp$site)),
        dataType=="1" ~ length(unique(subset(occDetdata_spp, L == 1)$site)), # DT1
        dataType=="2" ~ length(unique(subset(occDetdata_spp, L > 1 & L < 4)$site)), # DT2
        dataType=="3" ~ length(unique(subset(occDetdata_spp, L > 3)$site)))) # DT3
      # site:time period combinations
      out$data[5:8,] <- out$data[5:8,] %>% mutate(site_TPs = case_when(
        dataType=="Total" ~ length(unique(occDetdata_spp$siteTP)),
        dataType=="1" ~ length(unique(subset(occDetdata_spp, L == 1)$siteTP)), # DT1
        dataType=="2" ~ length(unique(subset(occDetdata_spp, L > 1 & L < 4)$siteTP)), # DT2
        dataType=="3" ~ length(unique(subset(occDetdata_spp, L > 3)$siteTP)))) # DT3
      # proportions
      out$data[5, c("visits_prop","sites_prop","site_TPs_prop")] <- NA
      out$data[5:8, "visits_prop"] <- out$data[5:8,"visits"]/out$data[5,"visits"] # visits
      out$data[5:8, "sites_prop"] <- out$data[5:8,"sites"]/out$data[5,"sites"] # sites
      out$data[5:8, "site_TPs_prop"] <- out$data[5:8,"site_TPs"]/out$data[5,"site_TPs"] # site:time period combinations
      
      ## Overlap
      out$overlap["1-2", "sites"] <- length(unique((subset(occDetdata_spp, L == 1))$site[(subset(occDetdata_spp, L == 1))$site %in% (subset(occDetdata_spp, L > 1 & L < 4))$site]))
      out$overlap["1-3", "sites"] <- length(unique((subset(occDetdata_spp, L == 1))$site[(subset(occDetdata_spp, L == 1))$site %in% (subset(occDetdata_spp, L > 3))$site]))
      out$overlap["2-3", "sites"] <- length(unique((subset(occDetdata_spp, L > 1 & L < 4))$site[(subset(occDetdata_spp, L > 1 & L < 4))$site %in% (subset(occDetdata_spp, L > 3))$site]))
      out$overlap["1-2", "site_TPs"] <- length(unique((subset(occDetdata_spp, L == 1))$siteTP[(subset(occDetdata_spp, L == 1))$siteTP %in% (subset(occDetdata_spp, L > 1 & L < 4))$siteTP]))
      out$overlap["1-3", "site_TPs"] <- length(unique((subset(occDetdata_spp, L == 1))$siteTP[(subset(occDetdata_spp, L == 1))$siteTP %in% (subset(occDetdata_spp, L > 3))$siteTP]))
      out$overlap["2-3", "site_TPs"] <- length(unique((subset(occDetdata_spp, L > 1 & L < 4))$siteTP[(subset(occDetdata_spp, L > 1 & L < 4))$siteTP %in% (subset(occDetdata_spp, L > 3))$siteTP]))
      out$overlap["1-2", "TPs"] <- length(unique((subset(occDetdata_spp, L == 1))$TP[(subset(occDetdata_spp, L == 1))$TP %in% (subset(occDetdata_spp, L > 1 & L < 4))$TP]))
      out$overlap["1-3", "TPs"] <- length(unique((subset(occDetdata_spp, L == 1))$TP[(subset(occDetdata_spp, L == 1))$TP %in% (subset(occDetdata_spp, L > 3))$TP]))
      out$overlap["2-3", "TPs"] <- length(unique((subset(occDetdata_spp, L > 1 & L < 4))$TP[(subset(occDetdata_spp, L > 1 & L < 4))$TP %in% (subset(occDetdata_spp, L > 3))$TP]))
      
    }
    # Return function output
    return(out)
    }
    
    
    ### If TPinterval is NOT specified
    if(is.null(TPinterval)){
      outFinal <- extractData(occDetdata)
    }
    
    
    ### If TPinterval is specified
    if(!is.null(TPinterval)){
      
      if(!is.numeric(TPinterval)){
        stop('TPinterval is specified but not in the correct format - TPduration should be a numerical vector with elements specifying the time period(s) to bin and specifying the incriment of the sequence')
      }
      
      if(length(TPinterval) == 1){
      TP <- findInterval(occDetdata$TP, seq(minTP, maxTP, TPinterval))
      occDetdata$TPorig <- occDetdata$TP
      occDetdata$TP <- TP
      outFinal <- extractData(occDetdata)
      }
      
      #if(length(TPinterval) > 1){
      #  outFinal <- list()
      #  occDetdata$TPorig <- occDetdata$TP
      #  for(i in length(TPinterval)){
      #    TP <- findInterval(occDetdata$TPorig, seq(minTP,maxTP, TPinterval[i]))
      #    occDetdata$TP <- TP
      #    outFinal[[i]] <- extractData(occDetdata)
      #  }
      #}
    }
    
return(outFinal)    

}
