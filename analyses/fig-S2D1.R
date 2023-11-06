


ModelNames_catLL <- paste(ModelNames, "catLL", sep="_") # Add '_catLL' to model names
catLL_list <- list() # Create an empty list



# Define input directory
input_dir <- "./outputs/mixLL-outputs_Converged/"

# List files to loop through
files <- list.files(path = paste(input_dir), 
                    ignore.case = TRUE, pattern = '\\.rds$')

# Create a vector with species names to name model outputs
ModelNames <- files
ModelNames <- sub("results_", "", ModelNames)
ModelNames <- sub("_watson_mixLL_80k.rds", "", ModelNames)
ModelNames <- sub("_watson_mixLL.rds", "", ModelNames)
ModelNames <- sub("_crick_mixLL.rds", "", ModelNames)
ModelNames <- sub("_ctag_mixLL.rds", "", ModelNames)
ModelNames <- sub("_ctag_mixLLL.rds", "", ModelNames)
ModelNames <- sub("_", " ", ModelNames)




########################################################## 
#######################  Page 1  #########################
##########################################################
page1files <- files[1:16]
page1names <- ModelNames[1:16]
page1list <- list() # Create an empty list
# Loop through, read the rds files, append to list and name elements
for(i in 1:length(page1files)){
  # read rds file and append to list
  page1list[[i]] <- as.data.frame(readRDS(file.path(input_dir, 
                                                    page1files[i]))$BUGSoutput$summary) 
  page1list[[i]]$spp <- paste(page1names[i]) # species name
  # subset rows for occu trends
  temp <- page1list[[i]]
  page1list[[i]] <- temp[grepl(paste0("^psi.fs", "\\["), row.names(temp)),]
  # add year column
  page1list[[i]]$year <- (Year = 1900 + as.numeric(gsub(paste0("psi.fs"), "", gsub("\\[|\\]","", row.names(page1list[[i]])))))
  # rename columns, otherwise ggplot doesn't work properly    
  names(page1list[[i]]) <- gsub("2.5%","quant_025", names(page1list[[i]]))
  names(page1list[[i]]) <- gsub("97.5%","quant_975", names(page1list[[i]]))
}
# Rbins species
page1dat  <- page1list[[1]]
for (i in 2:length(page1files)) {
  page1dat  <- rbind(page1dat, page1list[[i]])
}

### Plot 
p <- ggplot(page1dat, aes(x = year, y = mean)) + 
  geom_ribbon(data = page1dat,
              aes(group = 1, 
                  ymin = quant_025, ymax = quant_975),
              alpha = 0.5, fill= "grey") +
  geom_line(data = page1dat, colour = c("#0072B2"), linetype = "solid") +
  geom_vline(xintercept = 1976, linetype = "dashed", colour="red") +   # Vertical line = 1976
  ylab("Occupancy") +
  xlab("Year") +
  scale_y_continuous(limits=c(0, 1), expand = c(0, 0)) + # Limits to y-scale
  scale_x_continuous(breaks=seq(1900, 2020, 20), limits = c(1900, 2025),
                     expand = c(0, 0)) + # Limits to x-scale
  theme(panel.grid.minor = element_blank(),
        panel.background = element_blank(), 
        axis.line = element_line(colour = "black"))  +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1)) +
  theme(text=element_text(size=13)) + 
  facet_wrap(~spp) + theme(strip.text.x = element_text(face="italic"))
### save
ggsave("./figs/Fig_S2D1_A.png", p, width = 22, height = 17.5, units = "cm")




########################################################## 
#######################  Page 2  #########################
##########################################################
page2files <- files[17:36]
page2names <- ModelNames[17:36]
page2list <- list() 
# Loop through, read the rds files, append to list and name elements
for(i in 1:length(page2files)){
  # read rds file and append to list
  page2list[[i]] <- as.data.frame(readRDS(file.path(input_dir, 
                                                    page2files[i]))$BUGSoutput$summary) 
  page2list[[i]]$spp <- paste(page2names[i]) # species name
  temp <- page2list[[i]] # subset rows for occu trends
  page2list[[i]] <- temp[grepl(paste0("^psi.fs", "\\["), row.names(temp)),]
  # add year column
  page2list[[i]]$year <- (Year = 1900 + as.numeric(gsub(paste0("psi.fs"), "", 
                                                        gsub("\\[|\\]","", row.names(page2list[[i]])))))
  # rename columns, otherwise ggplot doesn't work properly    
  names(page2list[[i]]) <- gsub("2.5%","quant_025", names(page2list[[i]]))
  names(page2list[[i]]) <- gsub("97.5%","quant_975", names(page2list[[i]]))
}
# Rbind species
page2dat  <- page2list[[1]]
for (i in 2:length(page2files)) {
  page2dat  <- rbind(page2dat, page2list[[i]])
}

### Plot 
p <- ggplot(page2dat, aes(x = year, y = mean)) + 
  geom_ribbon(data = page2dat,
              aes(group = 1, 
                  ymin = quant_025, ymax = quant_975),
              alpha = 0.5, fill= "grey") +
  geom_line(data = page2dat, colour = c("#0072B2"), linetype = "solid") +
  geom_vline(xintercept = 1976, linetype = "dashed", colour="red") +   # Vertical line = 1976
  ylab("Occupancy") +
  xlab("Year") +
  scale_y_continuous(limits=c(0, 1), expand = c(0, 0)) + # Limits to y-scale
  scale_x_continuous(breaks=seq(1900, 2020, 20), limits = c(1900, 2025),
                     expand = c(0, 0)) + # Limits to x-scale
  theme(panel.grid.minor = element_blank(),
        panel.background = element_blank(), 
        axis.line = element_line(colour = "black"))  +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1)) +
  theme(text=element_text(size=13)) + 
  facet_wrap(~spp, nrow = 4) + theme(strip.text.x = element_text(face="italic"))
### save
ggsave("./figs/Fig_S2D1_2.png", p, width = 27, height = 17.5, units = "cm")




########################################################## 
#######################  Page 3  #########################
##########################################################
page3files <- files[37:52]
page3names <- ModelNames[37:52]
page3names[6] <- "Polygonia c-album"
page3names[12] <- "Satyrium w-album"
page3list <- list() 
# Loop through, read the rds files, append to list and name elements
for(i in 1:length(page3files)){
  # read rds file and append to list
  page3list[[i]] <- as.data.frame(readRDS(file.path(input_dir, 
                                                    page3files[i]))$BUGSoutput$summary) 
  page3list[[i]]$spp <- paste(page3names[i]) # species name
  temp <- page3list[[i]] # subset rows for occu trends
  page3list[[i]] <- temp[grepl(paste0("^psi.fs", "\\["), row.names(temp)),]
  # add year column
  page3list[[i]]$year <- (Year = 1900 + as.numeric(gsub(paste0("psi.fs"), "", 
                                                        gsub("\\[|\\]","", row.names(page3list[[i]])))))
  # rename columns, otherwise ggplot doesn't work properly    
  names(page3list[[i]]) <- gsub("2.5%","quant_025", names(page3list[[i]]))
  names(page3list[[i]]) <- gsub("97.5%","quant_975", names(page3list[[i]]))
}
# Rbind species
page3dat  <- page3list[[1]]
for (i in 2:length(page3files)) {
  page3dat  <- rbind(page3dat, page3list[[i]])
}

### Plot 
p <- ggplot(page3dat, aes(x = year, y = mean)) + 
  geom_ribbon(data = page3dat,
              aes(group = 1, 
                  ymin = quant_025, ymax = quant_975),
              alpha = 0.5, fill= "grey") +
  geom_line(data = page3dat, colour = c("#0072B2"), linetype = "solid") +
  geom_vline(xintercept = 1976, linetype = "dashed", colour="red") +   # Vertical line = 1976
  ylab("Occupancy") +
  xlab("Year") +
  scale_y_continuous(limits=c(0, 1), expand = c(0, 0)) + # Limits to y-scale
  scale_x_continuous(breaks=seq(1900, 2020, 20), limits = c(1900, 2025),
                     expand = c(0, 0)) + # Limits to x-scale
  theme(panel.grid.minor = element_blank(),
        panel.background = element_blank(), 
        axis.line = element_line(colour = "black"))  +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1)) +
  theme(text=element_text(size=13)) + 
  facet_wrap(~spp) + theme(strip.text.x = element_text(face="italic"))
### save
ggsave("./figs/Fig_S2D1_3.png", p, width = 22, height = 17.5, units = "cm")




