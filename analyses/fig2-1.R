# Load required packages
require(dplyr)
require(plyr)
require(ggplot2)
require(viridis)
require(readr)
require(wesanderson)
require(cowplot)

# Load spp_vis data (any would do), which contain all visits and whether or not each of the three species have been observed at that visit
spp_vis <- read.csv('./data/formattedData/spp_vis_merged_2020-04-07.csv', header=T, na.strings=c("","NA"))

# Load occDetdata giving each visits' site ID (grid cell), list length (numper of species observed) and time period (in this case year)
occDetdata_merged_2020_04_07 <- read.csv('./data/formattedData/occDetdata_merged_2020-04-07.csv', header=T, na.strings=c("","NA"))

# Merge by visit
spp_vis <- merge(spp_vis, occDetdata_merged_2020_04_07, by="visit")
# Find unique visits
spp_vis <- unique(spp_vis)

### Make L column a source column
# Change all List lengths between 0 and 22222 to 1 (all these are BNM data)
spp_vis$L <- replace(spp_vis$L, spp_vis$L > 0 & spp_vis$L < 22222, 1)
spp_vis$L <- as.factor(spp_vis$L) # Make L a factor
# Rename factor levels according to data type
spp_vis$L <- revalue(spp_vis$L, c("1"="BNM", "22222"="UKBMS", "33333"="NHCs"))
colnames(spp_vis)[colnames(spp_vis)=="L"] <- "Source" # Rename column to Source

# Correct time period so it starts at 1900
spp_vis$Year <- spp_vis$TP+1899

### Find records per data type
spp_vis$count.TRUE <- apply(spp_vis, 1, function(x) length(which(x=="TRUE")))
#

### Find visits per data type
test <- as.data.frame(spp_vis %>% select(Source, Year, count.TRUE)) %>% group_by(Source, Year) %>% tally(count.TRUE)
test <- test[rep(seq_len(nrow(test)), test$n), ]




### (A) record numbers
p <- ggplot(test, aes(x=Year, group=Source, fill=Source)) +
  geom_histogram(position="identity",binwidth = 1, alpha=0.8, boundary = 1900) + 
  theme_bw(base_size = 11)+ labs(x = "Year", y = "Records", colour = "Data type") + 
  scale_fill_manual(values = (wes_palette("Rushmore1", n = 4))[c(4,3,1)]) + 
  guides(fill=guide_legend(title="Data type")) + 
  geom_vline(xintercept = 1976, linetype = "dashed") +
  scale_y_sqrt(expand = c(0, 0)) + 
  scale_x_continuous(expand = c(0, 0)) +
  theme(panel.grid.minor = element_blank()) +
  theme(text=element_text(size=11)) 


### (A) visit numbers
p2 <- ggplot(spp_vis,aes(x=Year, group=Source, fill=Source)) +
  geom_histogram(position="identity",binwidth = 1, alpha=0.8, boundary = 1900) + 
  theme_bw(base_size = 11) + labs(x = "Year", y = "Visits", colour = "Data type") + 
  scale_fill_manual(values = (wes_palette("Rushmore1", n = 4))[c(4,3,1)]) + 
  guides(fill=guide_legend(title="Data type")) + 
  geom_vline(xintercept = 1976, linetype = "dashed") +
  scale_y_sqrt(expand = c(0, 0)) + 
  scale_x_continuous(expand = c(0, 0)) +
  theme(panel.grid.minor = element_blank()) +
  theme(text=element_text(size=11)) +
  theme(legend.direction="horizontal")


my_legend <- get_legend(p2)

plot_grid(plot_grid((p+ theme(legend.position = "none")), 
                    (p2 + theme(legend.position = "none")),
                    labels = c('(A)', '(B)'), label_size = 12,
                    hjust = 0.03, nrow = 1, ncol = 2),
          my_legend,
          nrow = 2,
          rel_heights = c(8,1))

#ggsave("./figs/Fig2-1:A-B.png", width = 15, height = 6, units = "cm")


