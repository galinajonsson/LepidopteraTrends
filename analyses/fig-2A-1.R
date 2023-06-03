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

########################################################

# Get rid of records recorded over multiple days
#BNM <- BNM[BNM$START_DATE==BNM$END_DATE,]
# 10627792

# Get rid of locality column as grid ref at 1 km precision is provided and, END_DATE (same as START_DATE), and DATE_TYPE (all the same)
#drops <- c("TO_LOCALITY", "END_DATE", "DATE_TYPE")
#BNM <- BNM[ , !(names(BNM) %in% drops)]

# Rename START_DATE
colnames(BNM)[colnames(BNM)=="START_DATE"] <- "date"

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



