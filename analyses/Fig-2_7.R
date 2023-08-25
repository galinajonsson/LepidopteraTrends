################################################################
### Thesis Figure 2.7
### Annual mean detection probability from 1900 to 2016 for butterfly species in Great Britain 
#(lines) and associated 95% credible intervals (ribbons) estimated using three different model formulations (Model A-C) for species: Pieris rapae (Small white), Carterocephalus palaemon (Chequered skipper), and Limenitis Camilla (White admiral). For each combination of species and model formulation, separate detection probabilities are given for three data types: Natural History Collections (NHCs; blue), UK Butterfly Monitoring Scheme (UKBMS; green), and Butterflies for a New Millennium (BNM). For model A, detection probability for BNM data is given by the red line, for Models B-C, detection probability for BNM data is given for two list lengths: 1=red line and 5=purple line. 
################################################################
# Load required package
require("sparta")
require("boot")
require("reshape2")
require("plyr")
require("ggplot2")
source("./DetectionOverTimeGG.R")


################################################################
### Pieris rapae
################################################################
Pieris_rapae_ModelA <- readRDS("../outputs/catLL-outputs/results_Pieris_rapae_ctag_catLL.rds")
Pieris_rapae_ModelB <- readRDS("../outputs/mixLL-outputs/results_Pieris_rapae_crick_mixLL.rds")
Pieris_rapae_ModelC <- readRDS("../outputs/mixLL2-outputs/results_Pieris_rapae_crick_mixLL2.rds")
P_rapae_ModelA <- DetectionOverTimeGG(Pieris_rapae_ModelA, min.yr = 1900, 
                                      legend_labels =c("BNM/Year_Effect", "UKBMS", "NHCs"),
                                      legend_title = "Data Type") 
P_rapae_ModelA$Model <- "Model A"
P_rapae_ModelB <- DetectionOverTimeGG(Pieris_rapae_ModelB, min.yr = 1900, 
                                      legend_labels = c("BNM_LL1/Year effect", "UKBMS", 
                                                        "NHCs", "BNM_LL5"), legend_title = "Data Type")
P_rapae_ModelB$Model <- "Model B"
P_rapae_ModelC <- DetectionOverTimeGG(Pieris_rapae_ModelC, min.yr = 1900, 
                                      legend_labels = c("BNM_LL1/Year effect", "UKBMS", "NHCs", "BNM_LL5"), 
                                      mixLL2 = TRUE, legend_title = "Data Type")
P_rapae_ModelC$Model <- "Model C"
P_rapae <- rbind(P_rapae_ModelA, P_rapae_ModelB, P_rapae_ModelC)
P_rapae$species <- "Pieris rapae"


################################################################
### Carterocephalus palaemon
################################################################
Carterocephalus_palaemon_ModelA <- readRDS("../outputs/catLL-outputs/results_Carterocephalus_palaemon_watson_catLL.rds")
Carterocephalus_palaemon_ModelB <- readRDS("../outputs/mixLL-outputs/results_Carterocephalus_palaemon_ctag_mixLL.rds")
Carterocephalus_palaemon_ModelC <- readRDS("../outputs/mixLL2-outputs/results_Carterocephalus_palaemon_watson_mixLL2.rds")
C_palaemon_ModelA <- DetectionOverTimeGG(Carterocephalus_palaemon_ModelA, min.yr = 1900, 
                                         legend_labels =c("BNM/Year_Effect", "UKBMS", "NHCs"),
                                         legend_title = "Data Type") 
C_palaemon_ModelA$Model <- "Model A"
C_palaemon_ModelB <- DetectionOverTimeGG(Carterocephalus_palaemon_ModelB, min.yr = 1900, 
                                         legend_labels = c("BNM_LL1/Year effect", "UKBMS", 
                                                           "NHCs", "BNM_LL5"), legend_title = "Data Type")
C_palaemon_ModelB$Model <- "Model B"
C_palaemon_ModelC <- DetectionOverTimeGG(Carterocephalus_palaemon_ModelC, min.yr = 1900, 
                                         legend_labels = c("BNM_LL1/Year effect", "UKBMS", "NHCs", "BNM_LL5"), 
                                         mixLL2 = TRUE, legend_title = "Data Type")
C_palaemon_ModelC$Model <- "Model C"
C_palaemon <- rbind(C_palaemon_ModelA, C_palaemon_ModelB, C_palaemon_ModelC)
C_palaemon$species <- "Carterocephalus \n palaemon"



################################################################
### Limenitis camilla
################################################################
Limenitis_camilla_ModelA <- readRDS("../outputs/catLL-outputs/results_Limenitis_camilla_crick_catLL.rds")
Limenitis_camilla_ModelB <- readRDS("../outputs/mixLL-outputs/results_Limenitis_camilla_ctag_mixLL.rds")
Limenitis_camilla_ModelC <- readRDS("../outputs/mixLL2-outputs/results_Limenitis_camilla_watson_mixLL2.rds")
L_camilla_ModelA <- DetectionOverTimeGG(Limenitis_camilla_ModelA, min.yr = 1900, 
                                        legend_labels =c("BNM/Year_Effect", "UKBMS", "NHCs"),
                                        legend_title = "Data Type") 
L_camilla_ModelA$Model <- "Model A"
L_camilla_ModelB <- DetectionOverTimeGG(Limenitis_camilla_ModelB, min.yr = 1900, 
                                        legend_labels = c("BNM_LL1/Year effect", "UKBMS", 
                                                          "NHCs", "BNM_LL5"), legend_title = "Data Type")
L_camilla_ModelB$Model <- "Model B"
L_camilla_ModelC <- DetectionOverTimeGG(Limenitis_camilla_ModelC, min.yr = 1900, 
                                        legend_labels = c("BNM_LL1/Year effect", "UKBMS", "NHCs", "BNM_LL5"), 
                                        mixLL2 = TRUE, legend_title = "Data Type")
L_camilla_ModelC$Model <- "Model C"
L_camilla <- rbind(L_camilla_ModelA, L_camilla_ModelB, L_camilla_ModelC)
L_camilla$species <- "Limenitis \n camilla"

################################################################
### Plot all the three Spp
################################################################

allThreeSpp <- rbind(P_rapae, C_palaemon, L_camilla)


p <- ggplot(data = allThreeSpp, aes(x=year, y=mean_pDet, group = ListLength)) +
  geom_line(aes(x=year, y=mean_pDet, col=factor(ListLength))) +
  geom_ribbon(aes(x=year, ymin=lower95CI, ymax=upper95CI, fill=factor(ListLength)), alpha=0.2) +
  scale_color_discrete(name  ="Data Type",
                       breaks=c("1", "2", "4", "5"),
                       labels=c("BNM (list length=1)", "UKBMS", "NHCs", "BNM list length=5")) +
  scale_fill_discrete(name  ="Data Type",
                      breaks=c("1", "2", "4", "5"),
                      labels=c("BNM (list length=1)", "UKBMS", "NHCs", "BNM list length=5")) +
  ylab("Detection probability") +
  xlab("Year") + geom_vline(xintercept = 1976, linetype = "dashed") + 
  theme_light(base_size = 13) + 
  scale_x_continuous(breaks=seq(1900, 2020, 20), limits = c(1900, 2025), expand = c(0, 0)) +
  scale_y_continuous(breaks=seq(0, 1, 0.25), limits = c(0, 1), expand = c(0, 0)) +
  theme(panel.grid.minor = element_blank(),
        panel.grid.major = element_blank(), 
        axis.line = element_line(colour = "black")) +
  facet_grid(factor(species, levels=c('Pieris rapae', 'Carterocephalus \n palaemon', 'Limenitis \n camilla')) ~ Model) +
  theme(strip.text = element_text(size = 12, colour="black", face="bold")) +
  theme(legend.position="bottom")  +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1)) +
  theme(strip.text.y = element_text(face="italic")) +
  theme(panel.spacing.y = unit(4, "mm"))

ggsave("../figs/ThesisFigure_2_7_.png", p, width = 7, height = 6.5)
### Annual mean detection probability from 1900 to 2016 for butterfly species in Great Britain 
#(lines) and associated 95% credible intervals (ribbons) estimated using three different model formulations (Model A-C) for species: Pieris rapae (Small white), Carterocephalus palaemon (Chequered skipper), and Limenitis Camilla (White admiral). For each combination of species and model formulation, separate detection probabilities are given for three data types: Natural History Collections (NHCs; blue), UK Butterfly Monitoring Scheme (UKBMS; green), and Butterflies for a New Millennium (BNM). For model A, detection probability for BNM data is given by the red line, for Models B-C, detection probability for BNM data is given for two list lengths: 1=red line and 5=purple line. 
