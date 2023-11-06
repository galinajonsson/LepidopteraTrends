### Occupancy - Chapter 5
require(ggplot2)

###############  x occDet  #################
# gets summary output from the BUGS files 
x <- readRDS("../outputs/mixLL-outputs/results_Argynnis_adippe_crick_mixLL.rds")
#x <- readRDS("../outputs/mixLL-outputs/results_Coenonympha_tullia_crick_mixLL.rds")
spp_data <- as.data.frame(x$BUGSoutput$summary)
# get rows we are interested in
### take psi.fs rows - these are the yearly proportion of occupied cells ###
spp_data$X <- row.names(spp_data)
new_data <- spp_data[grepl(paste0("^psi.fs",  "\\["),spp_data$X),]
new_data$year <- (Year = (x$min_year +1899) + as.numeric(gsub(paste0("psi.fs"), "", gsub("\\[|\\]","", row.names(new_data)))))
# rename columns, otherwise ggplot doesn't work properly    
names(new_data) <- gsub("2.5%","quant_025", names(new_data))
names(new_data) <- gsub("97.5%","quant_975", names(new_data))
new_data$Year <- c(1900:2015)

Coenonympha_tullia <- new_data  
Coenonympha_tullia$species <- "Coenonympha tullia"
Argynnis_adippe <-  new_data
Argynnis_adippe$species <- "Argynnis adippe"

temp <- rbind(Coenonympha_tullia, Argynnis_adippe)


p <- ggplot(data = temp, aes(x=Year, y=mean)) +
  geom_line(aes(x=Year, y=mean)) + 
  geom_ribbon(aes(x=Year, ymin=quant_025, ymax=quant_975), alpha=0.2) + 
  ylab("Occupancy") +
  xlab("Year") + geom_vline(xintercept = 1976, linetype = "dashed", col= "red") + 
  theme_light(base_size = 15) + 
  scale_x_continuous(breaks=seq(1900, 2020, 20), limits = c(1900, 2025), expand = c(0, 0)) +
  scale_y_continuous(breaks=seq(0, 0.5, 0.1), limits = c(0, 0.5), expand = c(0, 0)) +
  theme(panel.grid.minor = element_blank(),
        panel.grid.major = element_blank(), 
        axis.line = element_line(colour = "black")) +
  facet_grid(~ species) +
  theme(strip.text = element_text(size = 12, colour="black", face="bold")) +
  theme(legend.position="bottom")  +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1)) +
  theme(strip.text.x = element_text(face="italic"))
ggsave("./figs/Fig_5_1_AB.png", p, width = 7, height = 2.5)



###############  x occDet  #################
# gets summary output from the BUGS files 
x <- readRDS("../outputs/mixLL-outputs/results_Hamearis_lucina_crick_mixLL.rds")
x <- readRDS("../outputs/mixLL-outputs/results_Cupido_minimus_watson_mixLL.rds")
spp_data <- as.data.frame(x$BUGSoutput$summary)
# get rows we are interested in
### take psi.fs rows - these are the yearly proportion of occupied cells ###
spp_data$X <- row.names(spp_data)
new_data <- spp_data[grepl(paste0("^psi.fs",  "\\["),spp_data$X),]
new_data$year <- (Year = (x$min_year +1899) + as.numeric(gsub(paste0("psi.fs"), "", gsub("\\[|\\]","", row.names(new_data)))))
# rename columns, otherwise ggplot doesn't work properly    
names(new_data) <- gsub("2.5%","quant_025", names(new_data))
names(new_data) <- gsub("97.5%","quant_975", names(new_data))
new_data$Year <- c(1900:2015)

Cupido_minimus <- new_data  
Cupido_minimus$species <- "Cupido minimus"
#Hamearis_lucina <-  new_data
#Hamearis_lucina$species <- "Hamearis lucina"

temp <- rbind(Cupido_minimus, Hamearis_lucina)


p <- ggplot(data = temp, aes(x=Year, y=mean)) +
  geom_line(aes(x=Year, y=mean)) + 
  geom_ribbon(aes(x=Year, ymin=quant_025, ymax=quant_975), alpha=0.2) + 
  ylab("Occupancy") +
  xlab("Year") + geom_vline(xintercept = 1976, linetype = "dashed", col= "red") + 
  theme_light(base_size = 15) + 
  scale_x_continuous(breaks=seq(1900, 2020, 20), limits = c(1900, 2025), expand = c(0, 0)) +
  scale_y_continuous(breaks=seq(0, 0.5, 0.1), limits = c(0, 0.5), expand = c(0, 0)) +
  theme(panel.grid.minor = element_blank(),
        panel.grid.major = element_blank(), 
        axis.line = element_line(colour = "black")) +
  facet_grid(~ species) +
  theme(strip.text = element_text(size = 12, colour="black", face="bold")) +
  theme(legend.position="bottom")  +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1)) +
  theme(strip.text.x = element_text(face="italic"))
#ggsave("./figs/Fig_5_1_CD.png", p, width = 7, height = 2.5)



###############  x occDet  #################
# gets summary output from the BUGS files 
x <- readRDS("../outputs/mixLL-outputs/results_Leptidea_sinapis_watson_mixLL.rds")
#x <- readRDS("../outputs/mixLL-outputs/results_Thymelicus_acteon_ctag_mixLL.rds")
spp_data <- as.data.frame(x$BUGSoutput$summary)
# get rows we are interested in
### take psi.fs rows - these are the yearly proportion of occupied cells ###
spp_data$X <- row.names(spp_data)
new_data <- spp_data[grepl(paste0("^psi.fs",  "\\["),spp_data$X),]
new_data$year <- (Year = (x$min_year +1899) + as.numeric(gsub(paste0("psi.fs"), "", gsub("\\[|\\]","", row.names(new_data)))))
# rename columns, otherwise ggplot doesn't work properly    
names(new_data) <- gsub("2.5%","quant_025", names(new_data))
names(new_data) <- gsub("97.5%","quant_975", names(new_data))
new_data$Year <- c(1900:2015)

#Thymelicus_acteon <- new_data  
#Thymelicus_acteon$species <- "Thymelicus acteon"
Leptidea_sinapis <-  new_data
Leptidea_sinapis$species <- "Leptidea sinapis"

temp <- rbind(Thymelicus_acteon, Leptidea_sinapis)


p <- ggplot(data = temp, aes(x=Year, y=mean)) +
  geom_line(aes(x=Year, y=mean)) + 
  geom_ribbon(aes(x=Year, ymin=quant_025, ymax=quant_975), alpha=0.2) + 
  ylab("Occupancy") +
  xlab("Year") + geom_vline(xintercept = 1976, linetype = "dashed", col= "red") + 
  theme_light(base_size = 15) + 
  scale_x_continuous(breaks=seq(1900, 2020, 20), limits = c(1900, 2025), expand = c(0, 0)) +
  scale_y_continuous(breaks=seq(0, 0.15, 0.05), limits = c(0, 0.15), expand = c(0, 0)) +
  theme(panel.grid.minor = element_blank(),
        panel.grid.major = element_blank(), 
        axis.line = element_line(colour = "black")) +
  facet_grid(~ species) +
  theme(strip.text = element_text(size = 12, colour="black", face="bold")) +
  theme(legend.position="bottom")  +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1)) +
  theme(strip.text.x = element_text(face="italic"))
ggsave("./figs/Fig_5_1_EF.png", p, width = 7, height = 2.5)

###############  x occDet  #################
# gets summary output from the BUGS files 
#x <- readRDS("../outputs/mixLL-outputs/results_Polygonia_c_album_watson_mixLL.rds")
x <- readRDS("../outputs/mixLL-outputs/results_Gonepteryx_rhamni_watson_mixLL.rds")
spp_data <- as.data.frame(x$BUGSoutput$summary)
# get rows we are interested in
### take psi.fs rows - these are the yearly proportion of occupied cells ###
spp_data$X <- row.names(spp_data)
new_data <- spp_data[grepl(paste0("^psi.fs",  "\\["),spp_data$X),]
new_data$year <- (Year = (x$min_year +1899) + as.numeric(gsub(paste0("psi.fs"), "", gsub("\\[|\\]","", row.names(new_data)))))
# rename columns, otherwise ggplot doesn't work properly    
names(new_data) <- gsub("2.5%","quant_025", names(new_data))
names(new_data) <- gsub("97.5%","quant_975", names(new_data))
new_data$Year <- c(1900:2015)

Gonepteryx_rhamni <- new_data  
Gonepteryx_rhamni$species <- "Gonepteryx rhamni"
Polygonia_c_album <-  new_data
Polygonia_c_album$species <- "Polygonia c-album"

temp <- rbind(Polygonia_c_album, Gonepteryx_rhamni)


p <- ggplot(data = temp, aes(x=Year, y=mean)) +
  geom_line(aes(x=Year, y=mean)) + 
  geom_ribbon(aes(x=Year, ymin=quant_025, ymax=quant_975), alpha=0.2) + 
  ylab("Occupancy") +
  xlab("Year") + geom_vline(xintercept = 1976, linetype = "dashed", col= "red") + 
  theme_light(base_size = 15) + 
  scale_x_continuous(breaks=seq(1900, 2020, 20), limits = c(1900, 2025), expand = c(0, 0)) +
  scale_y_continuous(breaks=seq(0, 1, 0.25), limits = c(0, 1), expand = c(0, 0)) +
  theme(panel.grid.minor = element_blank(),
        panel.grid.major = element_blank(), 
        axis.line = element_line(colour = "black")) +
  facet_grid(~ species) +
  theme(strip.text = element_text(size = 12, colour="black", face="bold")) +
  theme(legend.position="bottom")  +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1)) +
  theme(strip.text.x = element_text(face="italic"))
ggsave("./figs/Fig_5_1_GH.png", p, width = 7, height = 2.5)
   