# Load required packages
require(dplyr)
#require(plyr)
require(ggplot2)
#require(viridis)
#require(readr)
#require(wesanderson)
#require(cowplot)


# Read BNM data
BNM <- read.delim("./data/rawData/BRCdata/BNM_butterflies/bnm_data.txt", header = TRUE, sep = "\t", dec = ".")
# 11588695 Observation

# Make dates date class
BNM$START_DATE <- as.Date(BNM$START_DATE, "%d/%m/%Y")
BNM$END_DATE <- as.Date(BNM$END_DATE, "%d/%m/%Y")
colnames(BNM)[colnames(BNM)=="START_DATE"] <- "date"

# Read species data
BNMspp <- read.delim("../data/rawData/BRCdata/BNM_butterflies/bnm_species.txt", header = TRUE, sep = "\t", dec = ".")

# Get rid of unnecisary columns
drops <- c("INFORMAL_GROUP", "ADDITIONAL_GROUP", "NAME_ENGLISH", "RANK")
BNMspp <- BNMspp[ , !(names(BNMspp) %in% drops)]

# Merge the species information
BNM <- merge(BNM, BNMspp, all.x=TRUE)

# Drop unused levels
BNM <- droplevels(BNM)

# Remove records of species not of interest
BNM<-BNM[BNM$NAME!="Vanessa atalanta",]
BNM<-BNM[BNM$NAME!="Vanessa cardui",]
BNM<-BNM[BNM$NAME!="Colias croceus",]
BNM<-BNM[BNM$NAME!="Danaus plexippus",]
BNM<-BNM[BNM$NAME!="Issoria lathonia",]
BNM<-BNM[BNM$NAME!="Lampides boeticus",]
BNM<-BNM[BNM$NAME!="Leptidea juvernica",]
BNM<-BNM[BNM$NAME!="Maculinea arion",]
BNM<-BNM[BNM$NAME!="Nymphalis antiopa",]
BNM<-BNM[BNM$NAME!="Nymphalis polychloros",]
BNM<-BNM[BNM$NAME!="Nymphalis xanthomelas",]

########################################################




p <- ggplot(BNM, aes(x=as.numeric(format(BNM$date, format="%Y")))) +
  geom_histogram(position="identity",binwidth = 1, alpha=0.8, boundary = 1900) + 
  theme_bw(base_size = 11)+ labs(x = "Year", y = "Records") + 
#  scale_fill_manual(values = (wes_palette("Rushmore1", n = 4))[c(4,3,1)]) + 
#  guides(fill=guide_legend(title="Data type")) + 
  geom_vline(xintercept = 1976, linetype = "dashed") +
  scale_y_sqrt(expand = c(0, 0)) + 
  scale_x_continuous(expand = c(0, 0)) +
  theme(panel.grid.minor = element_blank()) +
  theme(text=element_text(size=11)) 

p
#ggsave("figs/Fig2A-1A.png", width = 7, height = 5, units = "cm")





#my_legend <- get_legend(p2)

#plot_grid(plot_grid((p+ theme(legend.position = "none")), 
#                    (p2 + theme(legend.position = "none")),
#                    labels = c('(A)', '(B)'), label_size = 12,
#                    hjust = 0.03, nrow = 1, ncol = 2),
#          my_legend,
#          nrow = 2,
#          rel_heights = c(8,1))



