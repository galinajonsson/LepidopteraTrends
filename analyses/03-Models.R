##########################################################################################
###################################### 26 MAY 2020 #######################################
##########################################################################################

# scp -o ProxyJump=galj@orca.nhm.ac.uk sparta.zip galina@157.140.15.119:
# unzip sparta.zip
# mkdir ~/R_libs
# install.packages('/home/galina/sparta/', lib = "~/R_libs", repos = NULL)
# library(sparta, lib = "~/R_libs")





############################################# crick 22766

occDetdata_merged_7April2020 <- read.csv("/home/galina/occDetdata_merged_2020-04-07.csv", header=T, na.strings=c("","NA")) 
spp_vis_merged_7April2020 <- read.csv('/home/galina/spp_vis_merged_2020-04-07.csv', header=T, na.strings=c("","NA"))

library(sparta, lib = "~/R_libs")

start.time <- Sys.time()
results_Aglais_io_crick_mixLL <- sparta::occDetFunc(taxa_name = "Aglais.io",
                                                     n_iterations = 50000,
                                                     burnin = 25000,
                                                     thinning = 5, 
                                                     occDetdata = occDetdata_merged_7April2020, 
                                                     spp_vis = spp_vis_merged_7April2020, 
                                                     modeltype = c('ranwalk', 'halfcauchy', 'mixlistlength'), 
                                                     write_results = FALSE)
end.time <- Sys.time()
time.taken <- end.time - start.time
# Save outputs
saveRDS(results_Aglais_io_crick_mixLL, "/home/galina/results_Aglais_io_crick_mixLL.rds")
saveRDS(time.taken, "/home/galina/time.taken_results_Aglais_io_crick_mixLL.rds")





############################################# crick 23151

occDetdata_merged_7April2020 <- read.csv("/home/galina/occDetdata_merged_2020-04-07.csv", header=T, na.strings=c("","NA")) 
spp_vis_merged_7April2020 <- read.csv('/home/galina/spp_vis_merged_2020-04-07.csv', header=T, na.strings=c("","NA"))

library(sparta, lib = "~/R_libs")

start.time <- Sys.time()
results_Aglais_urticae_crick_mixLL <- sparta::occDetFunc(taxa_name = "Aglais.urticae",
                                                    n_iterations = 50000,
                                                    burnin = 25000,
                                                    thinning = 5, 
                                                    occDetdata = occDetdata_merged_7April2020, 
                                                    spp_vis = spp_vis_merged_7April2020, 
                                                    modeltype = c('ranwalk', 'halfcauchy', 'mixlistlength'), 
                                                    write_results = FALSE)
end.time <- Sys.time()
time.taken <- end.time - start.time
# Save outputs
saveRDS(results_Aglais_urticae_crick_mixLL, "/home/galina/results_Aglais_urticae_crick_mixLL.rds")
saveRDS(time.taken, "/home/galina/time.taken_results_Aglais_urticae_crick_mixLL.rds")





############################################# crick 23890

occDetdata_merged_7April2020 <- read.csv("/home/galina/occDetdata_merged_2020-04-07.csv", header=T, na.strings=c("","NA")) 
spp_vis_merged_7April2020 <- read.csv('/home/galina/spp_vis_merged_2020-04-07.csv', header=T, na.strings=c("","NA"))

library(sparta, lib = "~/R_libs")

start.time <- Sys.time()
results_Anthocharis_cardamines_crick_mixLL <- sparta::occDetFunc(taxa_name = "Anthocharis.cardamines",
                                                         n_iterations = 50000,
                                                         burnin = 25000,
                                                         thinning = 5, 
                                                         occDetdata = occDetdata_merged_7April2020, 
                                                         spp_vis = spp_vis_merged_7April2020, 
                                                         modeltype = c('ranwalk', 'halfcauchy', 'mixlistlength'), 
                                                         write_results = FALSE)
end.time <- Sys.time()
time.taken <- end.time - start.time
# Save outputs
saveRDS(results_Anthocharis_cardamines_crick_mixLL, "/home/galina/results_Anthocharis_cardamines_crick_mixLL.rds")
saveRDS(time.taken, "/home/galina/time.taken_results_Anthocharis_cardamines_crick_mixLL.rds")





############################################# crick 24246

occDetdata_merged_7April2020 <- read.csv("/home/galina/occDetdata_merged_2020-04-07.csv", header=T, na.strings=c("","NA")) 
spp_vis_merged_7April2020 <- read.csv('/home/galina/spp_vis_merged_2020-04-07.csv', header=T, na.strings=c("","NA"))

library(sparta, lib = "~/R_libs")

start.time <- Sys.time()
results_Apatura_iris_crick_mixLL <- sparta::occDetFunc(taxa_name = "Apatura.iris",
                                                                 n_iterations = 50000,
                                                                 burnin = 25000,
                                                                 thinning = 5, 
                                                                 occDetdata = occDetdata_merged_7April2020, 
                                                                 spp_vis = spp_vis_merged_7April2020, 
                                                                 modeltype = c('ranwalk', 'halfcauchy', 'mixlistlength'), 
                                                                 write_results = FALSE)
end.time <- Sys.time()
time.taken <- end.time - start.time
# Save outputs
saveRDS(results_Apatura_iris_crick_mixLL, "/home/galina/results_Apatura_iris_crick_mixLL.rds")
saveRDS(time.taken, "/home/galina/time.taken_results_Apatura_iris_crick_mixLL.rds")





############################################# crick 24574

occDetdata_merged_7April2020 <- read.csv("/home/galina/occDetdata_merged_2020-04-07.csv", header=T, na.strings=c("","NA")) 
spp_vis_merged_7April2020 <- read.csv('/home/galina/spp_vis_merged_2020-04-07.csv', header=T, na.strings=c("","NA"))

library(sparta, lib = "~/R_libs")

start.time <- Sys.time()
results_Aphantopus_hyperantus_crick_mixLL <- sparta::occDetFunc(taxa_name = "Aphantopus.hyperantus",
                                                       n_iterations = 50000,
                                                       burnin = 25000,
                                                       thinning = 5, 
                                                       occDetdata = occDetdata_merged_7April2020, 
                                                       spp_vis = spp_vis_merged_7April2020, 
                                                       modeltype = c('ranwalk', 'halfcauchy', 'mixlistlength'), 
                                                       write_results = FALSE)
end.time <- Sys.time()
time.taken <- end.time - start.time
# Save outputs
saveRDS(results_Aphantopus_hyperantus_crick_mixLL, "/home/galina/results_Aphantopus_hyperantus_crick_mixLL.rds")
saveRDS(time.taken, "/home/galina/time.taken_results_Aphantopus_hyperantus_crick_mixLL.rds")





############################################# crick 24879

occDetdata_merged_7April2020 <- read.csv("/home/galina/occDetdata_merged_2020-04-07.csv", header=T, na.strings=c("","NA")) 
spp_vis_merged_7April2020 <- read.csv('/home/galina/spp_vis_merged_2020-04-07.csv', header=T, na.strings=c("","NA"))

library(sparta, lib = "~/R_libs")

start.time <- Sys.time()
results_Argynnis_adippe_crick_mixLL <- sparta::occDetFunc(taxa_name = "Argynnis.adippe",
                                                                n_iterations = 50000,
                                                                burnin = 25000,
                                                                thinning = 5, 
                                                                occDetdata = occDetdata_merged_7April2020, 
                                                                spp_vis = spp_vis_merged_7April2020, 
                                                                modeltype = c('ranwalk', 'halfcauchy', 'mixlistlength'), 
                                                                write_results = FALSE)
end.time <- Sys.time()
time.taken <- end.time - start.time
# Save outputs
saveRDS(results_Argynnis_adippe_crick_mixLL, "/home/galina/results_Argynnis_adippe_crick_mixLL.rds")
saveRDS(time.taken, "/home/galina/time.taken_results_Argynnis_adippe_crick_mixLL.rds")





############################################# crick 25222

occDetdata_merged_7April2020 <- read.csv("/home/galina/occDetdata_merged_2020-04-07.csv", header=T, na.strings=c("","NA")) 
spp_vis_merged_7April2020 <- read.csv('/home/galina/spp_vis_merged_2020-04-07.csv', header=T, na.strings=c("","NA"))

library(sparta, lib = "~/R_libs")

start.time <- Sys.time()
results_Argynnis_aglaja_crick_mixLL <- sparta::occDetFunc(taxa_name = "Argynnis.aglaja",
                                                          n_iterations = 50000,
                                                          burnin = 25000,
                                                          thinning = 5, 
                                                          occDetdata = occDetdata_merged_7April2020, 
                                                          spp_vis = spp_vis_merged_7April2020, 
                                                          modeltype = c('ranwalk', 'halfcauchy', 'mixlistlength'), 
                                                          write_results = FALSE)
end.time <- Sys.time()
time.taken <- end.time - start.time
# Save outputs
saveRDS(results_Argynnis_aglaja_crick_mixLL, "/home/galina/results_Argynnis_aglaja_crick_mixLL.rds")
saveRDS(time.taken, "/home/galina/time.taken_results_Argynnis_aglaja_crick_mixLL.rds")






##########################################################################################
###################################### 27 MAY 2020 #######################################
##########################################################################################

# scp -o ProxyJump=galj@orca.nhm.ac.uk sparta.zip galina@157.140.15.118:
# scp -o ProxyJump=galj@orca.nhm.ac.uk sparta.zip galina@ctag:
# scp -o ProxyJump=galj@orca.nhm.ac.uk spp_vis_merged_2020-04-07.csv galina@ctag:
# scp -o ProxyJump=galj@orca.nhm.ac.uk occDetdata_merged_2020-04-07.csv galina@ctag:
# unzip sparta.zip
# mkdir ~/R_libs
# install.packages('/home/galina/sparta/', lib = "~/R_libs", repos = NULL)
# library(sparta, lib = "~/R_libs")




############################################# Watson 14074

occDetdata_merged_7April2020 <- read.csv("/home/galina/occDetdata_merged_2020-04-07.csv", header=T, na.strings=c("","NA")) 
spp_vis_merged_7April2020 <- read.csv('/home/galina/spp_vis_merged_2020-04-07.csv', header=T, na.strings=c("","NA"))

library(sparta, lib = "~/R_libs")

start.time <- Sys.time()
results_Argynnis_paphia_watson_mixLL <- sparta::occDetFunc(taxa_name = "Argynnis.paphia",
                                                    n_iterations = 50000,
                                                    burnin = 25000,
                                                    thinning = 5, 
                                                    occDetdata = occDetdata_merged_7April2020, 
                                                    spp_vis = spp_vis_merged_7April2020, 
                                                    modeltype = c('ranwalk', 'halfcauchy', 'mixlistlength'), 
                                                    write_results = FALSE)
end.time <- Sys.time()
time.taken <- end.time - start.time
# Save outputs
saveRDS(results_Argynnis_paphia_watson_mixLL, "/home/galina/results_Argynnis_paphia_watson_mixLL.rds")
saveRDS(time.taken, "/home/galina/time.taken_results_Argynnis_paphia_watson_mixLL.rds")






############################################# Watson 14456

occDetdata_merged_7April2020 <- read.csv("/home/galina/occDetdata_merged_2020-04-07.csv", header=T, na.strings=c("","NA")) 
spp_vis_merged_7April2020 <- read.csv('/home/galina/spp_vis_merged_2020-04-07.csv', header=T, na.strings=c("","NA"))

library(sparta, lib = "~/R_libs")

start.time <- Sys.time()
results_Aricia_agestis_watson_mixLL <- sparta::occDetFunc(taxa_name = "Aricia.agestis",
                                                           n_iterations = 50000,
                                                           burnin = 25000,
                                                           thinning = 5, 
                                                           occDetdata = occDetdata_merged_7April2020, 
                                                           spp_vis = spp_vis_merged_7April2020, 
                                                           modeltype = c('ranwalk', 'halfcauchy', 'mixlistlength'), 
                                                           write_results = FALSE)
end.time <- Sys.time()
time.taken <- end.time - start.time
# Save outputs
saveRDS(results_Aricia_agestis_watson_mixLL, "/home/galina/results_Aricia_agestis_watson_mixLL.rds")
saveRDS(time.taken, "/home/galina/time.taken_results_Aricia_agestis_watson_mixLL.rds")






############################################# Watson 14525

occDetdata_merged_7April2020 <- read.csv("/home/galina/occDetdata_merged_2020-04-07.csv", header=T, na.strings=c("","NA")) 
spp_vis_merged_7April2020 <- read.csv('/home/galina/spp_vis_merged_2020-04-07.csv', header=T, na.strings=c("","NA"))

library(sparta, lib = "~/R_libs")

start.time <- Sys.time()
results_Aricia_artaxerxes_watson_mixLL <- sparta::occDetFunc(taxa_name = "Aricia.artaxerxes",
                                                          n_iterations = 50000,
                                                          burnin = 25000,
                                                          thinning = 5, 
                                                          occDetdata = occDetdata_merged_7April2020, 
                                                          spp_vis = spp_vis_merged_7April2020, 
                                                          modeltype = c('ranwalk', 'halfcauchy', 'mixlistlength'), 
                                                          write_results = FALSE)
end.time <- Sys.time()
time.taken <- end.time - start.time
# Save outputs
saveRDS(results_Aricia_artaxerxes_watson_mixLL, "/home/galina/results_Aricia_artaxerxes_watson_mixLL.rds")
saveRDS(time.taken, "/home/galina/time.taken_results_Aricia_artaxerxes_watson_mixLL.rds")






############################################# Watson 14540

occDetdata_merged_7April2020 <- read.csv("/home/galina/occDetdata_merged_2020-04-07.csv", header=T, na.strings=c("","NA")) 
spp_vis_merged_7April2020 <- read.csv('/home/galina/spp_vis_merged_2020-04-07.csv', header=T, na.strings=c("","NA"))

library(sparta, lib = "~/R_libs")

start.time <- Sys.time()
results_Boloria_euphrosyne_watson_mixLL <- sparta::occDetFunc(taxa_name = "Boloria.euphrosyne",
                                                             n_iterations = 50000,
                                                             burnin = 25000,
                                                             thinning = 5, 
                                                             occDetdata = occDetdata_merged_7April2020, 
                                                             spp_vis = spp_vis_merged_7April2020, 
                                                             modeltype = c('ranwalk', 'halfcauchy', 'mixlistlength'), 
                                                             write_results = FALSE)
end.time <- Sys.time()
time.taken <- end.time - start.time
# Save outputs
saveRDS(results_Boloria_euphrosyne_watson_mixLL, "/home/galina/results_Boloria_euphrosyne_watson_mixLL.rds")
saveRDS(time.taken, "/home/galina/time.taken_results_Boloria_euphrosyne_watson_mixLL.rds")






############################################# Watson 14598

occDetdata_merged_7April2020 <- read.csv("/home/galina/occDetdata_merged_2020-04-07.csv", header=T, na.strings=c("","NA")) 
spp_vis_merged_7April2020 <- read.csv('/home/galina/spp_vis_merged_2020-04-07.csv', header=T, na.strings=c("","NA"))

library(sparta, lib = "~/R_libs")

start.time <- Sys.time()
results_Boloria_selene_watson_mixLL <- sparta::occDetFunc(taxa_name = "Boloria.selene",
                                                              n_iterations = 50000,
                                                              burnin = 25000,
                                                              thinning = 5, 
                                                              occDetdata = occDetdata_merged_7April2020, 
                                                              spp_vis = spp_vis_merged_7April2020, 
                                                              modeltype = c('ranwalk', 'halfcauchy', 'mixlistlength'), 
                                                              write_results = FALSE)
end.time <- Sys.time()
time.taken <- end.time - start.time
# Save outputs
saveRDS(results_Boloria_selene_watson_mixLL, "/home/galina/results_Boloria_selene_watson_mixLL.rds")
saveRDS(time.taken, "/home/galina/time.taken_results_Boloria_selene_watson_mixLL.rds")






############################################# ctag 16508

occDetdata_merged_7April2020 <- read.csv("/home/galina/occDetdata_merged_2020-04-07.csv", header=T, na.strings=c("","NA")) 
spp_vis_merged_7April2020 <- read.csv('/home/galina/spp_vis_merged_2020-04-07.csv', header=T, na.strings=c("","NA"))

library(sparta, lib = "~/R_libs")

start.time <- Sys.time()
results_Callophrys_rubi_ctag_mixLL <- sparta::occDetFunc(taxa_name = "Callophrys.rubi",
                                                          n_iterations = 50000,
                                                          burnin = 25000,
                                                          thinning = 5, 
                                                          occDetdata = occDetdata_merged_7April2020, 
                                                          spp_vis = spp_vis_merged_7April2020, 
                                                          modeltype = c('ranwalk', 'halfcauchy', 'mixlistlength'), 
                                                          write_results = FALSE)
end.time <- Sys.time()
time.taken <- end.time - start.time
# Save outputs
saveRDS(results_Callophrys_rubi_ctag_mixLL, "/home/galina/results_Callophrys_rubi_ctag_mixLL.rds")
saveRDS(time.taken, "/home/galina/time.taken_results_Callophrys_rubi_ctag_mixLL.rds")






############################################# ctag 19738

occDetdata_merged_7April2020 <- read.csv("/home/galina/occDetdata_merged_2020-04-07.csv", header=T, na.strings=c("","NA")) 
spp_vis_merged_7April2020 <- read.csv('/home/galina/spp_vis_merged_2020-04-07.csv', header=T, na.strings=c("","NA"))

library(sparta, lib = "~/R_libs")

start.time <- Sys.time()
results_Carterocephalus_palaemon_ctag_mixLL <- sparta::occDetFunc(taxa_name = "Carterocephalus.palaemon",
                                                         n_iterations = 50000,
                                                         burnin = 25000,
                                                         thinning = 5, 
                                                         occDetdata = occDetdata_merged_7April2020, 
                                                         spp_vis = spp_vis_merged_7April2020, 
                                                         modeltype = c('ranwalk', 'halfcauchy', 'mixlistlength'), 
                                                         write_results = FALSE)
end.time <- Sys.time()
time.taken <- end.time - start.time
# Save outputs
saveRDS(results_Carterocephalus_palaemon_ctag_mixLL, "/home/galina/results_Carterocephalus_palaemon_ctag_mixLL.rds")
saveRDS(time.taken, "/home/galina/time.taken_results_Carterocephalus_palaemon_ctag_mixLL.rds")






############################################# ctag 19746

occDetdata_merged_7April2020 <- read.csv("/home/galina/occDetdata_merged_2020-04-07.csv", header=T, na.strings=c("","NA")) 
spp_vis_merged_7April2020 <- read.csv('/home/galina/spp_vis_merged_2020-04-07.csv', header=T, na.strings=c("","NA"))

library(sparta, lib = "~/R_libs")

start.time <- Sys.time()
results_Celastrina_argiolus_ctag_mixLL <- sparta::occDetFunc(taxa_name = "Celastrina.argiolus",
                                                                  n_iterations = 50000,
                                                                  burnin = 25000,
                                                                  thinning = 5, 
                                                                  occDetdata = occDetdata_merged_7April2020, 
                                                                  spp_vis = spp_vis_merged_7April2020, 
                                                                  modeltype = c('ranwalk', 'halfcauchy', 'mixlistlength'), 
                                                                  write_results = FALSE)
end.time <- Sys.time()
time.taken <- end.time - start.time
# Save outputs
saveRDS(results_Celastrina_argiolus_ctag_mixLL, "/home/galina/results_Celastrina_argiolus_ctag_mixLL.rds")
saveRDS(time.taken, "/home/galina/time.taken_results_Celastrina_argiolus_ctag_mixLL.rds")






############################################# ctag 19754

occDetdata_merged_7April2020 <- read.csv("/home/galina/occDetdata_merged_2020-04-07.csv", header=T, na.strings=c("","NA")) 
spp_vis_merged_7April2020 <- read.csv('/home/galina/spp_vis_merged_2020-04-07.csv', header=T, na.strings=c("","NA"))

library(sparta, lib = "~/R_libs")

start.time <- Sys.time()
results_Coenonympha_pamphilus_ctag_mixLL <- sparta::occDetFunc(taxa_name = "Coenonympha.pamphilus",
                                                             n_iterations = 50000,
                                                             burnin = 25000,
                                                             thinning = 5, 
                                                             occDetdata = occDetdata_merged_7April2020, 
                                                             spp_vis = spp_vis_merged_7April2020, 
                                                             modeltype = c('ranwalk', 'halfcauchy', 'mixlistlength'), 
                                                             write_results = FALSE)
end.time <- Sys.time()
time.taken <- end.time - start.time
# Save outputs
saveRDS(results_Coenonympha_pamphilus_ctag_mixLL, "/home/galina/results_Coenonympha_pamphilus_ctag_mixLL.rds")
saveRDS(time.taken, "/home/galina/time.taken_results_Coenonympha_pamphilus_ctag_mixLL.rds")



##########################################################################################
###################################### 25 JUNE 2020 ######################################
##########################################################################################

# scp -o ProxyJump=galj@orca.nhm.ac.uk -r galina@ctag.nhm.ac.uk:/home/galina/ .
# scp -o ProxyJump=galj@orca.nhm.ac.uk -r galina@157.140.15.118:/home/galina/ .
# scp -o ProxyJump=galj@orca.nhm.ac.uk -r galina@157.140.15.119:/home/galina/ .




############################################# ctag 7916

occDetdata_merged_7April2020 <- read.csv("/home/galina/occDetdata_merged_2020-04-07.csv", header=T, na.strings=c("","NA")) 
spp_vis_merged_7April2020 <- read.csv('/home/galina/spp_vis_merged_2020-04-07.csv', header=T, na.strings=c("","NA"))

library(sparta, lib = "~/R_libs")

start.time <- Sys.time()
results_Papilio_machaon_ctag_mixLL <- sparta::occDetFunc(taxa_name = "Papilio.machaon",
                                                               n_iterations = 50000,
                                                               burnin = 25000,
                                                               thinning = 3, 
                                                               occDetdata = occDetdata_merged_7April2020, 
                                                               spp_vis = spp_vis_merged_7April2020, 
                                                               modeltype = c('ranwalk', 'halfcauchy', 'mixlistlength'), 
                                                               write_results = FALSE)
end.time <- Sys.time()
time.taken <- end.time - start.time
# Save outputs
saveRDS(results_Papilio_machaon_ctag_mixLL, "/home/galina/results_Papilio_machaon_ctag_mixLL.rds")
saveRDS(time.taken, "/home/galina/time.taken_results_Papilio_machaon_ctag_mixLL.rds")




############################################# ctag 7925

occDetdata_merged_7April2020 <- read.csv("/home/galina/occDetdata_merged_2020-04-07.csv", header=T, na.strings=c("","NA")) 
spp_vis_merged_7April2020 <- read.csv('/home/galina/spp_vis_merged_2020-04-07.csv', header=T, na.strings=c("","NA"))

library(sparta, lib = "~/R_libs")

start.time <- Sys.time()
results_Erynnis_tages_ctag_mixLL <- sparta::occDetFunc(taxa_name = "Erynnis.tages",
                                                         n_iterations = 50000,
                                                         burnin = 25000,
                                                         thinning = 3, 
                                                         occDetdata = occDetdata_merged_7April2020, 
                                                         spp_vis = spp_vis_merged_7April2020, 
                                                         modeltype = c('ranwalk', 'halfcauchy', 'mixlistlength'), 
                                                         write_results = FALSE)
end.time <- Sys.time()
time.taken <- end.time - start.time
# Save outputs
saveRDS(results_Erynnis_tages_ctag_mixLL, "/home/galina/results_Erynnis_tages_ctag_mixLL.rds")
saveRDS(time.taken, "/home/galina/time.taken_results_Erynnis_tages_ctag_mixLL.rds")




############################################# ctag 7960

occDetdata_merged_7April2020 <- read.csv("/home/galina/occDetdata_merged_2020-04-07.csv", header=T, na.strings=c("","NA")) 
spp_vis_merged_7April2020 <- read.csv('/home/galina/spp_vis_merged_2020-04-07.csv', header=T, na.strings=c("","NA"))

library(sparta, lib = "~/R_libs")

start.time <- Sys.time()
results_Hesperia_comma_ctag_mixLL <- sparta::occDetFunc(taxa_name = "Hesperia.comma",
                                                       n_iterations = 50000,
                                                       burnin = 25000,
                                                       thinning = 3, 
                                                       occDetdata = occDetdata_merged_7April2020, 
                                                       spp_vis = spp_vis_merged_7April2020, 
                                                       modeltype = c('ranwalk', 'halfcauchy', 'mixlistlength'), 
                                                       write_results = FALSE)
end.time <- Sys.time()
time.taken <- end.time - start.time
# Save outputs
saveRDS(results_Hesperia_comma_ctag_mixLL, "/home/galina/results_Hesperia_comma_ctag_mixLL.rds")
saveRDS(time.taken, "/home/galina/time.taken_results_Hesperia_comma_ctag_mixLL.rds")




############################################# ctag 7993

occDetdata_merged_7April2020 <- read.csv("/home/galina/occDetdata_merged_2020-04-07.csv", header=T, na.strings=c("","NA")) 
spp_vis_merged_7April2020 <- read.csv('/home/galina/spp_vis_merged_2020-04-07.csv', header=T, na.strings=c("","NA"))

library(sparta, lib = "~/R_libs")

start.time <- Sys.time()
results_Ochlodes_sylvanus_ctag_mixLL <- sparta::occDetFunc(taxa_name = "Ochlodes.sylvanus",
                                                        n_iterations = 50000,
                                                        burnin = 25000,
                                                        thinning = 3, 
                                                        occDetdata = occDetdata_merged_7April2020, 
                                                        spp_vis = spp_vis_merged_7April2020, 
                                                        modeltype = c('ranwalk', 'halfcauchy', 'mixlistlength'), 
                                                        write_results = FALSE)
end.time <- Sys.time()
time.taken <- end.time - start.time
# Save outputs
saveRDS(results_Ochlodes_sylvanus_ctag_mixLL, "/home/galina/results_Ochlodes_sylvanus_ctag_mixLL.rds")
saveRDS(time.taken, "/home/galina/time.taken_results_Ochlodes_sylvanus_ctag_mixLL.rds")




############################################# ctag 8001

occDetdata_merged_7April2020 <- read.csv("/home/galina/occDetdata_merged_2020-04-07.csv", header=T, na.strings=c("","NA")) 
spp_vis_merged_7April2020 <- read.csv('/home/galina/spp_vis_merged_2020-04-07.csv', header=T, na.strings=c("","NA"))

library(sparta, lib = "~/R_libs")

start.time <- Sys.time()
results_Pyrgus_malvae_ctag_mixLL <- sparta::occDetFunc(taxa_name = "Pyrgus.malvae",
                                                           n_iterations = 50000,
                                                           burnin = 25000,
                                                           thinning = 3, 
                                                           occDetdata = occDetdata_merged_7April2020, 
                                                           spp_vis = spp_vis_merged_7April2020, 
                                                           modeltype = c('ranwalk', 'halfcauchy', 'mixlistlength'), 
                                                           write_results = FALSE)
end.time <- Sys.time()
time.taken <- end.time - start.time
# Save outputs
saveRDS(results_Pyrgus_malvae_ctag_mixLL, "/home/galina/results_Pyrgus_malvae_ctag_mixLL.rds")
saveRDS(time.taken, "/home/galina/time.taken_results_Pyrgus_malvae_ctag_mixLL.rds")




############################################# ctag 8034

occDetdata_merged_7April2020 <- read.csv("/home/galina/occDetdata_merged_2020-04-07.csv", header=T, na.strings=c("","NA")) 
spp_vis_merged_7April2020 <- read.csv('/home/galina/spp_vis_merged_2020-04-07.csv', header=T, na.strings=c("","NA"))

library(sparta, lib = "~/R_libs")

start.time <- Sys.time()
results_Thymelicus_acteon_ctag_mixLL <- sparta::occDetFunc(taxa_name = "Thymelicus.acteon",
                                                       n_iterations = 50000,
                                                       burnin = 25000,
                                                       thinning = 3, 
                                                       occDetdata = occDetdata_merged_7April2020, 
                                                       spp_vis = spp_vis_merged_7April2020, 
                                                       modeltype = c('ranwalk', 'halfcauchy', 'mixlistlength'), 
                                                       write_results = FALSE)
end.time <- Sys.time()
time.taken <- end.time - start.time
# Save outputs
saveRDS(results_Thymelicus_acteon_ctag_mixLL, "/home/galina/results_Thymelicus_acteon_ctag_mixLL.rds")
saveRDS(time.taken, "/home/galina/time.taken_results_Thymelicus_acteon_ctag_mixLL.rds")





############################################# Watson 23322

occDetdata_merged_7April2020 <- read.csv("/home/galina/occDetdata_merged_2020-04-07.csv", header=T, na.strings=c("","NA")) 
spp_vis_merged_7April2020 <- read.csv('/home/galina/spp_vis_merged_2020-04-07.csv', header=T, na.strings=c("","NA"))

library(sparta, lib = "~/R_libs")

start.time <- Sys.time()
results_Thymelicus_lineola_watson_mixLL <- sparta::occDetFunc(taxa_name = "Thymelicus.lineola",
                                                             n_iterations = 50000,
                                                             burnin = 25000,
                                                             thinning = 3, 
                                                             occDetdata = occDetdata_merged_7April2020, 
                                                             spp_vis = spp_vis_merged_7April2020, 
                                                             modeltype = c('ranwalk', 'halfcauchy', 'mixlistlength'), 
                                                             write_results = FALSE)
end.time <- Sys.time()
time.taken <- end.time - start.time
# Save outputs
saveRDS(results_Thymelicus_lineola_watson_mixLL, "/home/galina/results_Thymelicus_lineola_watson_mixLL.rds")
saveRDS(time.taken, "/home/galina/time.taken_results_Thymelicus_lineola_watson_mixLL.rds")





############################################# Watson 23356

occDetdata_merged_7April2020 <- read.csv("/home/galina/occDetdata_merged_2020-04-07.csv", header=T, na.strings=c("","NA")) 
spp_vis_merged_7April2020 <- read.csv('/home/galina/spp_vis_merged_2020-04-07.csv', header=T, na.strings=c("","NA"))

library(sparta, lib = "~/R_libs")

start.time <- Sys.time()
results_Thymelicus_sylvestris_watson_mixLL <- sparta::occDetFunc(taxa_name = "Thymelicus.sylvestris",
                                                              n_iterations = 50000,
                                                              burnin = 25000,
                                                              thinning = 3, 
                                                              occDetdata = occDetdata_merged_7April2020, 
                                                              spp_vis = spp_vis_merged_7April2020, 
                                                              modeltype = c('ranwalk', 'halfcauchy', 'mixlistlength'), 
                                                              write_results = FALSE)
end.time <- Sys.time()
time.taken <- end.time - start.time
# Save outputs
saveRDS(results_Thymelicus_sylvestris_watson_mixLL, "/home/galina/results_Thymelicus_sylvestris_watson_mixLL.rds")
saveRDS(time.taken, "/home/galina/time.taken_results_Thymelicus_sylvestris_watson_mixLL.rds")





############################################# Watson 23419

occDetdata_merged_7April2020 <- read.csv("/home/galina/occDetdata_merged_2020-04-07.csv", header=T, na.strings=c("","NA")) 
spp_vis_merged_7April2020 <- read.csv('/home/galina/spp_vis_merged_2020-04-07.csv', header=T, na.strings=c("","NA"))

library(sparta, lib = "~/R_libs")

start.time <- Sys.time()
results_Gonepteryx_rhamni_watson_mixLL <- sparta::occDetFunc(taxa_name = "Gonepteryx.rhamni",
                                                                 n_iterations = 50000,
                                                                 burnin = 25000,
                                                                 thinning = 3, 
                                                                 occDetdata = occDetdata_merged_7April2020, 
                                                                 spp_vis = spp_vis_merged_7April2020, 
                                                                 modeltype = c('ranwalk', 'halfcauchy', 'mixlistlength'), 
                                                                 write_results = FALSE)
end.time <- Sys.time()
time.taken <- end.time - start.time
# Save outputs
saveRDS(results_Gonepteryx_rhamni_watson_mixLL, "/home/galina/results_Gonepteryx_rhamni_watson_mixLL.rds")
saveRDS(time.taken, "/home/galina/time.taken_results_Gonepteryx_rhamni_watson_mixLL.rds")





############################################# Watson 23483

occDetdata_merged_7April2020 <- read.csv("/home/galina/occDetdata_merged_2020-04-07.csv", header=T, na.strings=c("","NA")) 
spp_vis_merged_7April2020 <- read.csv('/home/galina/spp_vis_merged_2020-04-07.csv', header=T, na.strings=c("","NA"))

library(sparta, lib = "~/R_libs")

start.time <- Sys.time()
results_Leptidea_sinapis_watson_mixLL <- sparta::occDetFunc(taxa_name = "Leptidea.sinapis",
                                                             n_iterations = 50000,
                                                             burnin = 25000,
                                                             thinning = 3, 
                                                             occDetdata = occDetdata_merged_7April2020, 
                                                             spp_vis = spp_vis_merged_7April2020, 
                                                             modeltype = c('ranwalk', 'halfcauchy', 'mixlistlength'), 
                                                             write_results = FALSE)
end.time <- Sys.time()
time.taken <- end.time - start.time
# Save outputs
saveRDS(results_Leptidea_sinapis_watson_mixLL, "/home/galina/results_Leptidea_sinapis_watson_mixLL.rds")
saveRDS(time.taken, "/home/galina/time.taken_results_Leptidea_sinapis_watson_mixLL.rds")





############################################# Watson 23627

occDetdata_merged_7April2020 <- read.csv("/home/galina/occDetdata_merged_2020-04-07.csv", header=T, na.strings=c("","NA")) 
spp_vis_merged_7April2020 <- read.csv('/home/galina/spp_vis_merged_2020-04-07.csv', header=T, na.strings=c("","NA"))

library(sparta, lib = "~/R_libs")

start.time <- Sys.time()
results_Pieris_brassicae_watson_mixLL <- sparta::occDetFunc(taxa_name = "Pieris.brassicae",
                                                            n_iterations = 50000,
                                                            burnin = 25000,
                                                            thinning = 3, 
                                                            occDetdata = occDetdata_merged_7April2020, 
                                                            spp_vis = spp_vis_merged_7April2020, 
                                                            modeltype = c('ranwalk', 'halfcauchy', 'mixlistlength'), 
                                                            write_results = FALSE)
end.time <- Sys.time()
time.taken <- end.time - start.time
# Save outputs
saveRDS(results_Pieris_brassicae_watson_mixLL, "/home/galina/results_Pieris_brassicae_watson_mixLL.rds")
saveRDS(time.taken, "/home/galina/time.taken_results_Pieris_brassicae_watson_mixLL.rds")





############################################# Watson 23693

occDetdata_merged_7April2020 <- read.csv("/home/galina/occDetdata_merged_2020-04-07.csv", header=T, na.strings=c("","NA")) 
spp_vis_merged_7April2020 <- read.csv('/home/galina/spp_vis_merged_2020-04-07.csv', header=T, na.strings=c("","NA"))

library(sparta, lib = "~/R_libs")

start.time <- Sys.time()
results_Pieris_napi_watson_mixLL <- sparta::occDetFunc(taxa_name = "Pieris.napi",
                                                            n_iterations = 50000,
                                                            burnin = 25000,
                                                            thinning = 3, 
                                                            occDetdata = occDetdata_merged_7April2020, 
                                                            spp_vis = spp_vis_merged_7April2020, 
                                                            modeltype = c('ranwalk', 'halfcauchy', 'mixlistlength'), 
                                                            write_results = FALSE)
end.time <- Sys.time()
time.taken <- end.time - start.time
# Save outputs
saveRDS(results_Pieris_napi_watson_mixLL, "/home/galina/results_Pieris_napi_watson_mixLL.rds")
saveRDS(time.taken, "/home/galina/time.taken_results_Pieris_napi_watson_mixLL.rds")





############################################# crick 24626

occDetdata_merged_7April2020 <- read.csv("/home/galina/occDetdata_merged_2020-04-07.csv", header=T, na.strings=c("","NA")) 
spp_vis_merged_7April2020 <- read.csv('/home/galina/spp_vis_merged_2020-04-07.csv', header=T, na.strings=c("","NA"))

library(sparta, lib = "~/R_libs")

start.time <- Sys.time()
results_Pieris_rapae_crick_mixLL <- sparta::occDetFunc(taxa_name = "Pieris.rapae",
                                                       n_iterations = 50000,
                                                       burnin = 25000,
                                                       thinning = 3, 
                                                       occDetdata = occDetdata_merged_7April2020, 
                                                       spp_vis = spp_vis_merged_7April2020, 
                                                       modeltype = c('ranwalk', 'halfcauchy', 'mixlistlength'), 
                                                       write_results = FALSE)
end.time <- Sys.time()
time.taken <- end.time - start.time
# Save outputs
saveRDS(results_Pieris_rapae_crick_mixLL, "/home/galina/results_Pieris_rapae_crick_mixLL.rds")
saveRDS(time.taken, "/home/galina/time.taken_results_Pieris_rapae_crick_mixLL.rds")





############################################# crick 24673

occDetdata_merged_7April2020 <- read.csv("/home/galina/occDetdata_merged_2020-04-07.csv", header=T, na.strings=c("","NA")) 
spp_vis_merged_7April2020 <- read.csv('/home/galina/spp_vis_merged_2020-04-07.csv', header=T, na.strings=c("","NA"))

library(sparta, lib = "~/R_libs")

start.time <- Sys.time()
results_Coenonympha_tullia_crick_mixLL <- sparta::occDetFunc(taxa_name = "Coenonympha.tullia",
                                                       n_iterations = 50000,
                                                       burnin = 25000,
                                                       thinning = 3, 
                                                       occDetdata = occDetdata_merged_7April2020, 
                                                       spp_vis = spp_vis_merged_7April2020, 
                                                       modeltype = c('ranwalk', 'halfcauchy', 'mixlistlength'), 
                                                       write_results = FALSE)
end.time <- Sys.time()
time.taken <- end.time - start.time
# Save outputs
saveRDS(results_Coenonympha_tullia_crick_mixLL, "/home/galina/results_Coenonympha_tullia_crick_mixLL.rds")
saveRDS(time.taken, "/home/galina/time.taken_results_Coenonympha_tullia_crick_mixLL.rds")





############################################# crick 24739

occDetdata_merged_7April2020 <- read.csv("/home/galina/occDetdata_merged_2020-04-07.csv", header=T, na.strings=c("","NA")) 
spp_vis_merged_7April2020 <- read.csv('/home/galina/spp_vis_merged_2020-04-07.csv', header=T, na.strings=c("","NA"))

library(sparta, lib = "~/R_libs")

start.time <- Sys.time()
results_Erebia_aethiops_crick_mixLL <- sparta::occDetFunc(taxa_name = "Erebia.aethiops",
                                                             n_iterations = 50000,
                                                             burnin = 25000,
                                                             thinning = 3, 
                                                             occDetdata = occDetdata_merged_7April2020, 
                                                             spp_vis = spp_vis_merged_7April2020, 
                                                             modeltype = c('ranwalk', 'halfcauchy', 'mixlistlength'), 
                                                             write_results = FALSE)
end.time <- Sys.time()
time.taken <- end.time - start.time
# Save outputs
saveRDS(results_Erebia_aethiops_crick_mixLL, "/home/galina/results_Erebia_aethiops_crick_mixLL.rds")
saveRDS(time.taken, "/home/galina/time.taken_results_Erebia_aethiops_crick_mixLL.rds")





############################################# crick 24872

occDetdata_merged_7April2020 <- read.csv("/home/galina/occDetdata_merged_2020-04-07.csv", header=T, na.strings=c("","NA")) 
spp_vis_merged_7April2020 <- read.csv('/home/galina/spp_vis_merged_2020-04-07.csv', header=T, na.strings=c("","NA"))

library(sparta, lib = "~/R_libs")

start.time <- Sys.time()
results_Erebia_epiphron_crick_mixLL <- sparta::occDetFunc(taxa_name = "Erebia.epiphron",
                                                          n_iterations = 50000,
                                                          burnin = 25000,
                                                          thinning = 3, 
                                                          occDetdata = occDetdata_merged_7April2020, 
                                                          spp_vis = spp_vis_merged_7April2020, 
                                                          modeltype = c('ranwalk', 'halfcauchy', 'mixlistlength'), 
                                                          write_results = FALSE)
end.time <- Sys.time()
time.taken <- end.time - start.time
# Save outputs
saveRDS(results_Erebia_epiphron_crick_mixLL, "/home/galina/results_Erebia_epiphron_crick_mixLL.rds")
saveRDS(time.taken, "/home/galina/time.taken_results_Erebia_epiphron_crick_mixLL.rds")

















##########################################################################################
###################################### 27 JULY 2020 ######################################
##########################################################################################

# scp -o ProxyJump=galj@orca.nhm.ac.uk -r galina@ctag.nhm.ac.uk:/home/galina/ .
# scp -o ProxyJump=galj@orca.nhm.ac.uk -r galina@157.140.15.118:/home/galina/ .
# scp -o ProxyJump=galj@orca.nhm.ac.uk -r galina@157.140.15.119:/home/galina/ .







############################################# ctag 81078
occDetdata_merged_7April2020 <- read.csv("/home/galina/occDetdata_merged_2020-04-07.csv", header=T, na.strings=c("","NA")) 
spp_vis_merged_7April2020 <- read.csv('/home/galina/spp_vis_merged_2020-04-07.csv', header=T, na.strings=c("","NA"))

library(sparta, lib = "~/R_libs")

start.time <- Sys.time()
results_Euphydryas_aurinia_ctag_mixLL <- sparta::occDetFunc(taxa_name = "Euphydryas.aurinia",
                                                             n_iterations = 50000,
                                                             burnin = 25000,
                                                             thinning = 3, 
                                                             occDetdata = occDetdata_merged_7April2020, 
                                                             spp_vis = spp_vis_merged_7April2020, 
                                                             modeltype = c('ranwalk', 'halfcauchy', 'mixlistlength'), 
                                                             write_results = FALSE)
end.time <- Sys.time()
time.taken <- end.time - start.time
# Save outputs
saveRDS(results_Euphydryas_aurinia_ctag_mixLL, "/home/galina/results_Euphydryas_aurinia_ctag_mixLL.rds")
saveRDS(time.taken, "/home/galina/time.taken_results_Euphydryas_aurinia_ctag_mixLL.rds")






############################################# ctag 8034
start.time <- Sys.time()
results_Hipparchia_semele_ctag_mixLL <- sparta::occDetFunc(taxa_name = "Hipparchia.semele",
                                                            n_iterations = 50000,
                                                            burnin = 25000,
                                                            thinning = 3, 
                                                            occDetdata = occDetdata_merged_7April2020, 
                                                            spp_vis = spp_vis_merged_7April2020, 
                                                            modeltype = c('ranwalk', 'halfcauchy', 'mixlistlength'), 
                                                            write_results = FALSE)
end.time <- Sys.time()
time.taken <- end.time - start.time
# Save outputs
saveRDS(results_Hipparchia_semele_ctag_mixLL, "/home/galina/results_Hipparchia_semele_ctag_mixLL.rds")
saveRDS(time.taken, "/home/galina/time.taken_results_Hipparchia_semele_ctag_mixLL.rds")






############################################# ctag 8001
start.time <- Sys.time()
results_Lasiommata_megera_ctag_mixLL <- sparta::occDetFunc(taxa_name = "Lasiommata.megera",
                                                           n_iterations = 50000,
                                                           burnin = 25000,
                                                           thinning = 3, 
                                                           occDetdata = occDetdata_merged_7April2020, 
                                                           spp_vis = spp_vis_merged_7April2020, 
                                                           modeltype = c('ranwalk', 'halfcauchy', 'mixlistlength'), 
                                                           write_results = FALSE)
end.time <- Sys.time()
time.taken <- end.time - start.time
# Save outputs
saveRDS(results_Lasiommata_megera_ctag_mixLL, "/home/galina/results_Lasiommata_megera_ctag_mixLL.rds")
saveRDS(time.taken, "/home/galina/time.taken_results_Lasiommata_megera_ctag_mixLL.rds")






############################################# ctag 7993
start.time <- Sys.time()
results_Limenitis_camilla_ctag_mixLL <- sparta::occDetFunc(taxa_name = "Limenitis.camilla",
                                                           n_iterations = 50000,
                                                           burnin = 25000,
                                                           thinning = 3, 
                                                           occDetdata = occDetdata_merged_7April2020, 
                                                           spp_vis = spp_vis_merged_7April2020, 
                                                           modeltype = c('ranwalk', 'halfcauchy', 'mixlistlength'), 
                                                           write_results = FALSE)
end.time <- Sys.time()
time.taken <- end.time - start.time
# Save outputs
saveRDS(results_Limenitis_camilla_ctag_mixLL, "/home/galina/results_Limenitis_camilla_ctag_mixLL.rds")
saveRDS(time.taken, "/home/galina/time.taken_results_Limenitis_camilla_ctag_mixLL.rds")






############################################# ctag 7960
start.time <- Sys.time()
results_Maniola_jurtina_ctag_mixLL <- sparta::occDetFunc(taxa_name = "Maniola.jurtina",
                                                           n_iterations = 50000,
                                                           burnin = 25000,
                                                           thinning = 3, 
                                                           occDetdata = occDetdata_merged_7April2020, 
                                                           spp_vis = spp_vis_merged_7April2020, 
                                                           modeltype = c('ranwalk', 'halfcauchy', 'mixlistlength'), 
                                                           write_results = FALSE)
end.time <- Sys.time()
time.taken <- end.time - start.time
# Save outputs
saveRDS(results_Maniola_jurtina_ctag_mixLL, "/home/galina/results_Maniola_jurtina_ctag_mixLLL.rds")
saveRDS(time.taken, "/home/galina/time.taken_results_Maniola_jurtina_ctag_mixLL.rds")






############################################# ctag 7925
start.time <- Sys.time()
results_Melanargia_galathea_ctag_mixLL <- sparta::occDetFunc(taxa_name = "Melanargia.galathea",
                                                         n_iterations = 50000,
                                                         burnin = 25000,
                                                         thinning = 3, 
                                                         occDetdata = occDetdata_merged_7April2020, 
                                                         spp_vis = spp_vis_merged_7April2020, 
                                                         modeltype = c('ranwalk', 'halfcauchy', 'mixlistlength'), 
                                                         write_results = FALSE)
end.time <- Sys.time()
time.taken <- end.time - start.time
# Save outputs
saveRDS(results_Melanargia_galathea_ctag_mixLL, "/home/galina/results_Melanargia_galathea_ctag_mixLL.rds")
saveRDS(time.taken, "/home/galina/time.taken_results_Melanargia_galathea_ctag_mixLL.rds")





############################################# Watson 33047

occDetdata_merged_7April2020 <- read.csv("/home/galina/occDetdata_merged_2020-04-07.csv", header=T, na.strings=c("","NA")) 
spp_vis_merged_7April2020 <- read.csv('/home/galina/spp_vis_merged_2020-04-07.csv', header=T, na.strings=c("","NA"))

library(sparta, lib = "~/R_libs")

start.time <- Sys.time()
results_Melitaea_athalia_watson_mixLL <- sparta::occDetFunc(taxa_name = "Melitaea.athalia",
                                                            n_iterations = 50000,
                                                            burnin = 25000,
                                                            thinning = 3, 
                                                            occDetdata = occDetdata_merged_7April2020, 
                                                            spp_vis = spp_vis_merged_7April2020, 
                                                            modeltype = c('ranwalk', 'halfcauchy', 'mixlistlength'), 
                                                            write_results = FALSE)
end.time <- Sys.time()
time.taken <- end.time - start.time
# Save outputs
saveRDS(results_Melitaea_athalia_watson_mixLL, "/home/galina/results_Melitaea_athalia_watson_mixLL.rds")
saveRDS(time.taken, "/home/galina/time.taken_results_Melitaea_athalia_watson_mixLL.rds")





############################################# Watson 33202

occDetdata_merged_7April2020 <- read.csv("/home/galina/occDetdata_merged_2020-04-07.csv", header=T, na.strings=c("","NA")) 
spp_vis_merged_7April2020 <- read.csv('/home/galina/spp_vis_merged_2020-04-07.csv', header=T, na.strings=c("","NA"))

library(sparta, lib = "~/R_libs")

start.time <- Sys.time()
results_Melitaea_cinxia_watson_mixLL <- sparta::occDetFunc(taxa_name = "Melitaea.cinxia",
                                                            n_iterations = 50000,
                                                            burnin = 25000,
                                                            thinning = 3, 
                                                            occDetdata = occDetdata_merged_7April2020, 
                                                            spp_vis = spp_vis_merged_7April2020, 
                                                            modeltype = c('ranwalk', 'halfcauchy', 'mixlistlength'), 
                                                            write_results = FALSE)
end.time <- Sys.time()
time.taken <- end.time - start.time
# Save outputs
saveRDS(results_Melitaea_cinxia_watson_mixLL, "/home/galina/results_Melitaea_cinxia_watson_mixLL.rds")
saveRDS(time.taken, "/home/galina/time.taken_results_Melitaea_cinxia_watson_mixLL.rds")





############################################# Watson 33341

occDetdata_merged_7April2020 <- read.csv("/home/galina/occDetdata_merged_2020-04-07.csv", header=T, na.strings=c("","NA")) 
spp_vis_merged_7April2020 <- read.csv('/home/galina/spp_vis_merged_2020-04-07.csv', header=T, na.strings=c("","NA"))

library(sparta, lib = "~/R_libs")

start.time <- Sys.time()
results_Pararge_aegeria_watson_mixLL <- sparta::occDetFunc(taxa_name = "Pararge.aegeria",
                                                           n_iterations = 50000,
                                                           burnin = 25000,
                                                           thinning = 3, 
                                                           occDetdata = occDetdata_merged_7April2020, 
                                                           spp_vis = spp_vis_merged_7April2020, 
                                                           modeltype = c('ranwalk', 'halfcauchy', 'mixlistlength'), 
                                                           write_results = FALSE)
end.time <- Sys.time()
time.taken <- end.time - start.time
# Save outputs
saveRDS(results_Pararge_aegeria_watson_mixLL, "/home/galina/results_Pararge_aegeria_watson_mixLL.rds")
saveRDS(time.taken, "/home/galina/time.taken_results_Pararge_aegeria_watson_mixLL.rds")





############################################# Watson 33456

occDetdata_merged_7April2020 <- read.csv("/home/galina/occDetdata_merged_2020-04-07.csv", header=T, na.strings=c("","NA")) 
spp_vis_merged_7April2020 <- read.csv('/home/galina/spp_vis_merged_2020-04-07.csv', header=T, na.strings=c("","NA"))

library(sparta, lib = "~/R_libs")

start.time <- Sys.time()
results_Polygonia_c_album_watson_mixLL <- sparta::occDetFunc(taxa_name = "Polygonia.c.album",
                                                           n_iterations = 50000,
                                                           burnin = 25000,
                                                           thinning = 3, 
                                                           occDetdata = occDetdata_merged_7April2020, 
                                                           spp_vis = spp_vis_merged_7April2020, 
                                                           modeltype = c('ranwalk', 'halfcauchy', 'mixlistlength'), 
                                                           write_results = FALSE)
end.time <- Sys.time()
time.taken <- end.time - start.time
# Save outputs
saveRDS(results_Polygonia_c_album_watson_mixLL, "/home/galina/results_Polygonia_c_album_watson_mixLL.rds")
saveRDS(time.taken, "/home/galina/time.taken_results_Polygonia_c_album_watson_mixLL.rds")





############################################# Watson 34048

occDetdata_merged_7April2020 <- read.csv("/home/galina/occDetdata_merged_2020-04-07.csv", header=T, na.strings=c("","NA")) 
spp_vis_merged_7April2020 <- read.csv('/home/galina/spp_vis_merged_2020-04-07.csv', header=T, na.strings=c("","NA"))

library(sparta, lib = "~/R_libs")

start.time <- Sys.time()
results_Pyronia_tithonus_watson_mixLL <- sparta::occDetFunc(taxa_name = "Pyronia.tithonus",
                                                             n_iterations = 50000,
                                                             burnin = 25000,
                                                             thinning = 3, 
                                                             occDetdata = occDetdata_merged_7April2020, 
                                                             spp_vis = spp_vis_merged_7April2020, 
                                                             modeltype = c('ranwalk', 'halfcauchy', 'mixlistlength'), 
                                                             write_results = FALSE)
end.time <- Sys.time()
time.taken <- end.time - start.time
# Save outputs
saveRDS(results_Polygonia_c_album_watson_mixLL, "/home/galina/results_Pyronia_tithonus_watson_mixLL.rds")
saveRDS(time.taken, "/home/galina/time.taken_results_Pyronia_tithonus_watson_mixLL.rds")





############################################# Watson 34229

occDetdata_merged_7April2020 <- read.csv("/home/galina/occDetdata_merged_2020-04-07.csv", header=T, na.strings=c("","NA")) 
spp_vis_merged_7April2020 <- read.csv('/home/galina/spp_vis_merged_2020-04-07.csv', header=T, na.strings=c("","NA"))

library(sparta, lib = "~/R_libs")

start.time <- Sys.time()
results_Cupido_minimus_watson_mixLL <- sparta::occDetFunc(taxa_name = "Cupido.minimus",
                                                            n_iterations = 50000,
                                                            burnin = 25000,
                                                            thinning = 3, 
                                                            occDetdata = occDetdata_merged_7April2020, 
                                                            spp_vis = spp_vis_merged_7April2020, 
                                                            modeltype = c('ranwalk', 'halfcauchy', 'mixlistlength'), 
                                                            write_results = FALSE)
end.time <- Sys.time()
time.taken <- end.time - start.time
# Save outputs
saveRDS(results_Cupido_minimus_watson_mixLL, "/home/galina/results_Cupido_minimus_watson_mixLL.rds")
saveRDS(time.taken, "/home/galina/time.taken_results_Cupido_minimus_watson_mixLL.rds")




############################################# crick 24626

start.time <- Sys.time()
results_Favonius_quercus_crick_mixLL <- sparta::occDetFunc(taxa_name = "Favonius.quercus",
                                                       n_iterations = 50000,
                                                       burnin = 25000,
                                                       thinning = 3, 
                                                       occDetdata = occDetdata_merged_7April2020, 
                                                       spp_vis = spp_vis_merged_7April2020, 
                                                       modeltype = c('ranwalk', 'halfcauchy', 'mixlistlength'), 
                                                       write_results = FALSE)
end.time <- Sys.time()
time.taken <- end.time - start.time
# Save outputs
saveRDS(results_Favonius_quercus_crick_mixLL, "/home/galina/results_Favonius_quercus_crick_mixLL.rds")
saveRDS(time.taken, "/home/galina/time.taken_results_Favonius_quercus_crick_mixLL.rds")





############################################# crick 24673

start.time <- Sys.time()
results_Lycaena_phlaeas_crick_mixLL <- sparta::occDetFunc(taxa_name = "Lycaena.phlaeas",
                                                             n_iterations = 50000,
                                                             burnin = 25000,
                                                             thinning = 3, 
                                                             occDetdata = occDetdata_merged_7April2020, 
                                                             spp_vis = spp_vis_merged_7April2020, 
                                                             modeltype = c('ranwalk', 'halfcauchy', 'mixlistlength'), 
                                                             write_results = FALSE)
end.time <- Sys.time()
time.taken <- end.time - start.time
# Save outputs
saveRDS(results_Lycaena_phlaeas_crick_mixLL, "/home/galina/results_Lycaena_phlaeas_crick_mixLL.rds")
saveRDS(time.taken, "/home/galina/time.taken_results_Lycaena_phlaeas_crick_mixLL.rds")





############################################# crick 24739

start.time <- Sys.time()
results_Plebejus_argus_crick_mixLL <- sparta::occDetFunc(taxa_name = "Plebejus.argus",
                                                          n_iterations = 50000,
                                                          burnin = 25000,
                                                          thinning = 3, 
                                                          occDetdata = occDetdata_merged_7April2020, 
                                                          spp_vis = spp_vis_merged_7April2020, 
                                                          modeltype = c('ranwalk', 'halfcauchy', 'mixlistlength'), 
                                                          write_results = FALSE)
end.time <- Sys.time()
time.taken <- end.time - start.time
# Save outputs
saveRDS(results_Plebejus_argus_crick_mixLL, "/home/galina/results_Plebejus_argus_crick_mixLL.rds")
saveRDS(time.taken, "/home/galina/time.taken_results_Plebejus_argus_crick_mixLL.rds")





############################################# crick 24872

start.time <- Sys.time()
results_Polyommatus_bellargus_crick_mixLL <- sparta::occDetFunc(taxa_name = "Polyommatus.bellargus",
                                                          n_iterations = 50000,
                                                          burnin = 25000,
                                                          thinning = 3, 
                                                          occDetdata = occDetdata_merged_7April2020, 
                                                          spp_vis = spp_vis_merged_7April2020, 
                                                          modeltype = c('ranwalk', 'halfcauchy', 'mixlistlength'), 
                                                          write_results = FALSE)
end.time <- Sys.time()
time.taken <- end.time - start.time
# Save outputs
saveRDS(results_Polyommatus_bellargus_crick_mixLL, "/home/galina/results_Polyommatus_bellargus_crick_mixLL.rds")
saveRDS(time.taken, "/home/galina/time.taken_results_Polyommatus_bellargus_crick_mixLL.rds")





############################################# crick 35787

occDetdata_merged_7April2020 <- read.csv("/home/galina/occDetdata_merged_2020-04-07.csv", header=T, na.strings=c("","NA")) 
spp_vis_merged_7April2020 <- read.csv('/home/galina/spp_vis_merged_2020-04-07.csv', header=T, na.strings=c("","NA"))

library(sparta, lib = "~/R_libs")

start.time <- Sys.time()
results_Polyommatus_coridon_crick_mixLL <- sparta::occDetFunc(taxa_name = "Polyommatus.coridon",
                                                                n_iterations = 50000,
                                                                burnin = 25000,
                                                                thinning = 3, 
                                                                occDetdata = occDetdata_merged_7April2020, 
                                                                spp_vis = spp_vis_merged_7April2020, 
                                                                modeltype = c('ranwalk', 'halfcauchy', 'mixlistlength'), 
                                                                write_results = FALSE)
end.time <- Sys.time()
time.taken <- end.time - start.time
# Save outputs
saveRDS(results_Polyommatus_coridon_crick_mixLL, "/home/galina/results_Polyommatus_coridon_crick_mixLL.rds")
saveRDS(time.taken, "/home/galina/time.taken_results_Polyommatus_coridon_crick_mixLL.rds")






##########################################################################################
###################################### 19 AUG 2020 #######################################
##########################################################################################

# scp -o ProxyJump=galj@orca.nhm.ac.uk -r galina@157.140.15.118:/home/galina/ .




############################################# watson 32743
occDetdata_merged_7April2020 <- read.csv("/home/galina/occDetdata_merged_2020-04-07.csv", header=T, na.strings=c("","NA")) 
spp_vis_merged_7April2020 <- read.csv('/home/galina/spp_vis_merged_2020-04-07.csv', header=T, na.strings=c("","NA"))

library(sparta, lib = "~/R_libs")

start.time <- Sys.time()
results_Aglais_io_watson_mixLL_80k <- sparta::occDetFunc(taxa_name = "Aglais.io",
                                                            n_iterations = 80000,
                                                            burnin = 40000,
                                                            thinning = 3, 
                                                            occDetdata = occDetdata_merged_7April2020, 
                                                            spp_vis = spp_vis_merged_7April2020, 
                                                            modeltype = c('ranwalk', 'halfcauchy', 'mixlistlength'), 
                                                            write_results = FALSE)
end.time <- Sys.time()
time.taken <- end.time - start.time
# Save outputs
saveRDS(results_Aglais_io_watson_mixLL_80k, "/home/galina/results_Aglais_io_watson_mixLL_80k.rds")
saveRDS(time.taken, "/home/galina/time.taken_results_Aglais_io_watson_mixLL_80k.rds")







############################################# watson 36598
occDetdata_merged_7April2020 <- read.csv("/home/galina/occDetdata_merged_2020-04-07.csv", header=T, na.strings=c("","NA")) 
spp_vis_merged_7April2020 <- read.csv('/home/galina/spp_vis_merged_2020-04-07.csv', header=T, na.strings=c("","NA"))

library(sparta, lib = "~/R_libs")

start.time <- Sys.time()
results_Apatura_iris_watson_mixLL_80k <- sparta::occDetFunc(taxa_name = "Apatura.iris",
                                                         n_iterations = 80000,
                                                         burnin = 40000,
                                                         thinning = 3, 
                                                         occDetdata = occDetdata_merged_7April2020, 
                                                         spp_vis = spp_vis_merged_7April2020, 
                                                         modeltype = c('ranwalk', 'halfcauchy', 'mixlistlength'), 
                                                         write_results = FALSE)
end.time <- Sys.time()
time.taken <- end.time - start.time
# Save outputs
saveRDS(results_Apatura_iris_watson_mixLL_80k, "/home/galina/results_Apatura_iris_watson_mixLL_80k.rds")
saveRDS(time.taken, "/home/galina/time.taken_results_Apatura_iris_watson_mixLL_80k.rds")







############################################# watson 38845
occDetdata_merged_7April2020 <- read.csv("/home/galina/occDetdata_merged_2020-04-07.csv", header=T, na.strings=c("","NA")) 
spp_vis_merged_7April2020 <- read.csv('/home/galina/spp_vis_merged_2020-04-07.csv', header=T, na.strings=c("","NA"))

library(sparta, lib = "~/R_libs")

start.time <- Sys.time()
results_Ochlodes_sylvanus_watson_mixLL_80k <- sparta::occDetFunc(taxa_name = "Ochlodes.sylvanus",
                                                            n_iterations = 80000,
                                                            burnin = 40000,
                                                            thinning = 3, 
                                                            occDetdata = occDetdata_merged_7April2020, 
                                                            spp_vis = spp_vis_merged_7April2020, 
                                                            modeltype = c('ranwalk', 'halfcauchy', 'mixlistlength'), 
                                                            write_results = FALSE)
end.time <- Sys.time()
time.taken <- end.time - start.time
# Save outputs
saveRDS(results_Ochlodes_sylvanus_watson_mixLL_80k, "/home/galina/results_Ochlodes_sylvanus_watson_mixLL_80k.rds")
saveRDS(time.taken, "/home/galina/time.taken_results_Ochlodes_sylvanus_watson_mixLL_80k.rds")







##########################################################################################
###################################### 24 AUG 2020 #######################################
##########################################################################################

# scp -o ProxyJump=galj@orca.nhm.ac.uk -r galina@157.140.15.118:/home/galina/ .
# scp -o ProxyJump=galj@orca.nhm.ac.uk -r galina@157.140.15.119:/home/galina/ .







##########################################################################################
####################################### 7 SEP 2020 #######################################
##########################################################################################

# scp -o ProxyJump=galj@orca.nhm.ac.uk -r galina@ctag:/home/galina/ .










############################################# watson 10408
occDetdata_merged_7April2020 <- read.csv("/home/galina/occDetdata_merged_2020-04-07.csv", header=T, na.strings=c("","NA")) 
spp_vis_merged_7April2020 <- read.csv('/home/galina/spp_vis_merged_2020-04-07.csv', header=T, na.strings=c("","NA"))

library(sparta, lib = "~/R_libs")

start.time <- Sys.time()
results_Pyronia_tithonus_watson_mixLL_80k <- sparta::occDetFunc(taxa_name = "Pyronia.tithonus",
                                                            n_iterations = 80000,
                                                            burnin = 40000,
                                                            thinning = 3, 
                                                            occDetdata = occDetdata_merged_7April2020, 
                                                            spp_vis = spp_vis_merged_7April2020, 
                                                            modeltype = c('ranwalk', 'halfcauchy', 'mixlistlength'), 
                                                            write_results = FALSE)
end.time <- Sys.time()
time.taken <- end.time - start.time
# Save outputs
saveRDS(results_Pyronia_tithonus_watson_mixLL_80k, "/home/galina/results_Pyronia_tithonus_watson_mixLL_80k.rds")
saveRDS(time.taken, "/home/galina/time.taken_results_Pyronia_tithonus_watson_mixLL_80k.rds")










############################################# crick 32151
occDetdata_merged_7April2020 <- read.csv("/home/galina/occDetdata_merged_2020-04-07.csv", header=T, na.strings=c("","NA")) 
spp_vis_merged_7April2020 <- read.csv('/home/galina/spp_vis_merged_2020-04-07.csv', header=T, na.strings=c("","NA"))

library(sparta, lib = "~/R_libs")

start.time <- Sys.time()
results_Polyommatus_icarus_crick_mixLL <- sparta::occDetFunc(taxa_name = "Polyommatus.icarus",
                                                              n_iterations = 50000,
                                                              burnin = 25000,
                                                                thinning = 3, 
                                                                occDetdata = occDetdata_merged_7April2020, 
                                                                spp_vis = spp_vis_merged_7April2020, 
                                                                modeltype = c('ranwalk', 'halfcauchy', 'mixlistlength'), 
                                                                write_results = FALSE)
end.time <- Sys.time()
time.taken <- end.time - start.time
# Save outputs
saveRDS(results_Polyommatus_icarus_crick_mixLL, "/home/galina/results_Polyommatus_icarus_crick_mixLL.rds")
saveRDS(time.taken, "/home/galina/time.taken_results_Polyommatus_icarus_crick_mixLL.rds")










############################################# crick 14306
occDetdata_merged_7April2020 <- read.csv("/home/galina/occDetdata_merged_2020-04-07.csv", header=T, na.strings=c("","NA")) 
spp_vis_merged_7April2020 <- read.csv('/home/galina/spp_vis_merged_2020-04-07.csv', header=T, na.strings=c("","NA"))

library(sparta, lib = "~/R_libs")

start.time <- Sys.time()
results_Satyrium_pruni_crick_mixLL <- sparta::occDetFunc(taxa_name = "Satyrium.pruni",
                                                              n_iterations = 50000,
                                                              burnin = 25000,
                                                              thinning = 3, 
                                                              occDetdata = occDetdata_merged_7April2020, 
                                                              spp_vis = spp_vis_merged_7April2020, 
                                                              modeltype = c('ranwalk', 'halfcauchy', 'mixlistlength'), 
                                                              write_results = FALSE)
end.time <- Sys.time()
time.taken <- end.time - start.time
# Save outputs
saveRDS(results_Satyrium_pruni_crick_mixLL, "/home/galina/results_Satyrium_pruni_crick_mixLL.rds")
saveRDS(time.taken, "/home/galina/time.taken_results_Satyrium_pruni_crick_mixLL.rds")










############################################# crick 25763
occDetdata_merged_7April2020 <- read.csv("/home/galina/occDetdata_merged_2020-04-07.csv", header=T, na.strings=c("","NA")) 
spp_vis_merged_7April2020 <- read.csv('/home/galina/spp_vis_merged_2020-04-07.csv', header=T, na.strings=c("","NA"))

library(sparta, lib = "~/R_libs")

start.time <- Sys.time()
results_Satyrium_w.album_crick_mixLL <- sparta::occDetFunc(taxa_name = "Satyrium.w.album",
                                                         n_iterations = 50000,
                                                         burnin = 25000,
                                                         thinning = 3, 
                                                         occDetdata = occDetdata_merged_7April2020, 
                                                         spp_vis = spp_vis_merged_7April2020, 
                                                         modeltype = c('ranwalk', 'halfcauchy', 'mixlistlength'), 
                                                         write_results = FALSE)
end.time <- Sys.time()
time.taken <- end.time - start.time
# Save outputs
saveRDS(results_Satyrium_w.album_crick_mixLL, "/home/galina/results_Satyrium_w.album_crick_mixLL.rds")
saveRDS(time.taken, "/home/galina/time.taken_results_Satyrium_w.album_crick_mixLL.rds")










############################################# crick 16718
occDetdata_merged_7April2020 <- read.csv("/home/galina/occDetdata_merged_2020-04-07.csv", header=T, na.strings=c("","NA")) 
spp_vis_merged_7April2020 <- read.csv('/home/galina/spp_vis_merged_2020-04-07.csv', header=T, na.strings=c("","NA"))

library(sparta, lib = "~/R_libs")

start.time <- Sys.time()
results_Thecla_betulae_crick_mixLL <- sparta::occDetFunc(taxa_name = "Thecla.betulae",
                                                           n_iterations = 50000,
                                                           burnin = 25000,
                                                           thinning = 3, 
                                                           occDetdata = occDetdata_merged_7April2020, 
                                                           spp_vis = spp_vis_merged_7April2020, 
                                                           modeltype = c('ranwalk', 'halfcauchy', 'mixlistlength'), 
                                                           write_results = FALSE)
end.time <- Sys.time()
time.taken <- end.time - start.time
# Save outputs
saveRDS(results_Thecla_betulae_crick_mixLL, "/home/galina/results_Thecla_betulae_crick_mixLL.rds")
saveRDS(time.taken, "/home/galina/time.taken_results_Thecla_betulae_crick_mixLL.rds")










############################################# crick 1211
occDetdata_merged_7April2020 <- read.csv("/home/galina/occDetdata_merged_2020-04-07.csv", header=T, na.strings=c("","NA")) 
spp_vis_merged_7April2020 <- read.csv('/home/galina/spp_vis_merged_2020-04-07.csv', header=T, na.strings=c("","NA"))

library(sparta, lib = "~/R_libs")

start.time <- Sys.time()
results_Hamearis_lucina_crick_mixLL <- sparta::occDetFunc(taxa_name = "Hamearis.lucina",
                                                         n_iterations = 50000,
                                                         burnin = 25000,
                                                         thinning = 3, 
                                                         occDetdata = occDetdata_merged_7April2020, 
                                                         spp_vis = spp_vis_merged_7April2020, 
                                                         modeltype = c('ranwalk', 'halfcauchy', 'mixlistlength'), 
                                                         write_results = FALSE)
end.time <- Sys.time()
time.taken <- end.time - start.time
# Save outputs
saveRDS(results_Hamearis_lucina_crick_mixLL, "/home/galina/results_Hamearis_lucina_crick_mixLL.rds")
saveRDS(time.taken, "/home/galina/time.taken_results_Hamearis_lucina_crick_mixLL.rds")








##########################################################################################
###################################### 18 OCT 2020 #######################################
##########################################################################################


# scp -o ProxyJump=galj@orca.nhm.ac.uk -r galina@157.140.15.119:/home/galina/ .
# scp -o ProxyJump=galj@orca.nhm.ac.uk -r galina@ctag:/home/galina/time.taken_results_Maniola_jurtina_ctag_mixLL.rds .
# scp -o ProxyJump=galj@orca.nhm.ac.uk -r galina@157.140.15.118:/home/galina/ .








##########################################################################################
###################################### 8 DEC 2020 ########################################
##########################################################################################

# Somewhere along the line, the model outputs for Pieris brassicae were lost and I will therefore rerun the analysis for this species. 

############################################# ctag 
occDetdata_merged_7April2020 <- read.csv("/home/galina/occDetdata_merged_2020-04-07.csv", header=T, na.strings=c("","NA")) 
spp_vis_merged_7April2020 <- read.csv('/home/galina/spp_vis_merged_2020-04-07.csv', header=T, na.strings=c("","NA"))

library(sparta, lib = "~/R_libs")

start.time <- Sys.time()
results_Pieris_brassicae_crick_mixLL <- sparta::occDetFunc(taxa_name = "Pieris.brassicae",
                                                         n_iterations = 50000,
                                                         burnin = 25000,
                                                         thinning = 3, 
                                                         occDetdata = occDetdata_merged_7April2020, 
                                                         spp_vis = spp_vis_merged_7April2020, 
                                                         modeltype = c('ranwalk', 'halfcauchy', 'mixlistlength'), 
                                                         write_results = FALSE)
end.time <- Sys.time()
time.taken <- end.time - start.time
# Save outputs
saveRDS(results_Pieris_brassicae_crick_mixLL, "/home/galina/results_Pieris_brassicae_crick_mixLL.rds")
saveRDS(time.taken, "/home/galina/time.taken_results_Pieris_brassicae_crick_mixLL.rds")












##########################################################################################
###################################### 11 DEC 2020 #######################################
##########################################################################################


############################################# watson
# scp -o ProxyJump=galj@orca.nhm.ac.uk sparta.zip galina@157.140.15.118:
# rm -rf ~/R_libs
# unzip sparta.zip
# mkdir ~/R_libs
# install.packages('~/sparta/sparta/', lib = "~/R_libs", repos = NULL)
# library(sparta, lib = "~/R_libs")



############################################# crick
# scp -o ProxyJump=galj@orca.nhm.ac.uk sparta.zip galina@157.140.15.119:
# rm -rf ~/R_libs
# unzip sparta.zip
# mkdir ~/R_libs
# install.packages('~/sparta/sparta/', lib = "~/R_libs", repos = NULL)
# library(sparta, lib = "~/R_libs")







 

############################################# watson 25840
occDetdata_merged_7April2020 <- read.csv("/home/galina/occDetdata_merged_2020-04-07.csv", header=T, na.strings=c("","NA")) 
spp_vis_merged_7April2020 <- read.csv('/home/galina/spp_vis_merged_2020-04-07.csv', header=T, na.strings=c("","NA"))

library(sparta, lib = "~/R_libs")

start.time <- Sys.time()
results_Erebia_epiphron_watson_mixLL2 <- sparta::occDetFunc(taxa_name = "Erebia.epiphron",
                                                           n_iterations = 50000,
                                                           burnin = 25000,
                                                           thinning = 3, 
                                                           occDetdata = occDetdata_merged_7April2020, 
                                                           spp_vis = spp_vis_merged_7April2020, 
                                                           modeltype = c('ranwalk', 'halfcauchy', 'mixlistlength2'), 
                                                           write_results = FALSE)
end.time <- Sys.time()
time.taken <- end.time - start.time
# Save outputs
saveRDS(results_Erebia_epiphron_watson_mixLL2, "/home/galina/results_Erebia_epiphron_watson_mixLL2.rds")
saveRDS(time.taken, "/home/galina/time.taken_results_Erebia_epiphron_watson_mixLL2.rds")










############################################# watson 12065
occDetdata_merged_7April2020 <- read.csv("/home/galina/occDetdata_merged_2020-04-07.csv", header=T, na.strings=c("","NA")) 
spp_vis_merged_7April2020 <- read.csv('/home/galina/spp_vis_merged_2020-04-07.csv', header=T, na.strings=c("","NA"))

library(sparta, lib = "~/R_libs")

start.time <- Sys.time()
results_Carterocephalus_palaemon_watson_mixLL2 <- sparta::occDetFunc(taxa_name = "Carterocephalus.palaemon",
                                                           n_iterations = 50000,
                                                           burnin = 25000,
                                                           thinning = 3, 
                                                           occDetdata = occDetdata_merged_7April2020, 
                                                           spp_vis = spp_vis_merged_7April2020, 
                                                           modeltype = c('ranwalk', 'halfcauchy', 'mixlistlength2'), 
                                                           write_results = FALSE)
end.time <- Sys.time()
time.taken <- end.time - start.time
# Save outputs
saveRDS(results_Carterocephalus_palaemon_watson_mixLL2, "/home/galina/results_Carterocephalus_palaemon_watson_mixLL2.rds")
saveRDS(time.taken, "/home/galina/time.taken_results_Carterocephalus_palaemon_watson_mixLL2.rds")










############################################# watson 24760
occDetdata_merged_7April2020 <- read.csv("/home/galina/occDetdata_merged_2020-04-07.csv", header=T, na.strings=c("","NA")) 
spp_vis_merged_7April2020 <- read.csv('/home/galina/spp_vis_merged_2020-04-07.csv', header=T, na.strings=c("","NA"))

library(sparta, lib = "~/R_libs")

start.time <- Sys.time()
results_Melitaea_athalia_watson_mixLL2 <- sparta::occDetFunc(taxa_name = "Melitaea.athalia",
                                                                     n_iterations = 50000,
                                                                     burnin = 25000,
                                                                     thinning = 3, 
                                                                     occDetdata = occDetdata_merged_7April2020, 
                                                                     spp_vis = spp_vis_merged_7April2020, 
                                                                     modeltype = c('ranwalk', 'halfcauchy', 'mixlistlength2'), 
                                                                     write_results = FALSE)
end.time <- Sys.time()
time.taken <- end.time - start.time
# Save outputs
saveRDS(results_Melitaea_athalia_watson_mixLL2, "/home/galina/results_Melitaea_athalia_watson_mixLL2.rds")
saveRDS(time.taken, "/home/galina/time.taken_results_Melitaea_athalia_watson_mixLL2.rds")














############################################# watson 28125
occDetdata_merged_7April2020 <- read.csv("/home/galina/occDetdata_merged_2020-04-07.csv", header=T, na.strings=c("","NA")) 
spp_vis_merged_7April2020 <- read.csv('/home/galina/spp_vis_merged_2020-04-07.csv', header=T, na.strings=c("","NA"))

library(sparta, lib = "~/R_libs")

start.time <- Sys.time()
results_Polyommatus_bellargus_watson_mixLL2 <- sparta::occDetFunc(taxa_name = "Polyommatus.bellargus",
                                                             n_iterations = 50000,
                                                             burnin = 25000,
                                                             thinning = 3, 
                                                             occDetdata = occDetdata_merged_7April2020, 
                                                             spp_vis = spp_vis_merged_7April2020, 
                                                             modeltype = c('ranwalk', 'halfcauchy', 'mixlistlength2'), 
                                                             write_results = FALSE)
end.time <- Sys.time()
time.taken <- end.time - start.time
# Save outputs
saveRDS(results_Polyommatus_bellargus_watson_mixLL2, "/home/galina/results_Polyommatus_bellargus_watson_mixLL2.rds")
saveRDS(time.taken, "/home/galina/time.taken_results_Polyommatus_bellargus_watson_mixLL2.rds")














############################################# watson 30810
occDetdata_merged_7April2020 <- read.csv("/home/galina/occDetdata_merged_2020-04-07.csv", header=T, na.strings=c("","NA")) 
spp_vis_merged_7April2020 <- read.csv('/home/galina/spp_vis_merged_2020-04-07.csv', header=T, na.strings=c("","NA"))

library(sparta, lib = "~/R_libs")

start.time <- Sys.time()
results_Thecla_betulae_watson_mixLL2 <- sparta::occDetFunc(taxa_name = "Thecla.betulae",
                                                                  n_iterations = 50000,
                                                                  burnin = 25000,
                                                                  thinning = 3, 
                                                                  occDetdata = occDetdata_merged_7April2020, 
                                                                  spp_vis = spp_vis_merged_7April2020, 
                                                                  modeltype = c('ranwalk', 'halfcauchy', 'mixlistlength2'), 
                                                                  write_results = FALSE)
end.time <- Sys.time()
time.taken <- end.time - start.time
# Save outputs
saveRDS(results_Thecla_betulae_watson_mixLL2, "/home/galina/results_Thecla_betulae_watson_mixLL2.rds")
saveRDS(time.taken, "/home/galina/time.taken_results_Thecla_betulae_watson_mixLL2.rds")










############################################# watson 36192
occDetdata_merged_7April2020 <- read.csv("/home/galina/occDetdata_merged_2020-04-07.csv", header=T, na.strings=c("","NA")) 
spp_vis_merged_7April2020 <- read.csv('/home/galina/spp_vis_merged_2020-04-07.csv', header=T, na.strings=c("","NA"))

library(sparta, lib = "~/R_libs")

start.time <- Sys.time()
results_Limenitis_camilla_watson_mixLL2 <- sparta::occDetFunc(taxa_name = "Limenitis.camilla",
                                                                     n_iterations = 50000,
                                                                     burnin = 25000,
                                                                     thinning = 3, 
                                                                     occDetdata = occDetdata_merged_7April2020, 
                                                                     spp_vis = spp_vis_merged_7April2020, 
                                                                     modeltype = c('ranwalk', 'halfcauchy', 'mixlistlength2'), 
                                                                     write_results = FALSE)
end.time <- Sys.time()
time.taken <- end.time - start.time
# Save outputs
saveRDS(results_Limenitis_camilla_watson_mixLL2, "/home/galina/results_Limenitis_camilla_watson_mixLL2.rds")
saveRDS(time.taken, "/home/galina/time.taken_results_Limenitis_camilla_watson_mixLL2.rds")










############################################# crick 15504
occDetdata_merged_7April2020 <- read.csv("/home/galina/occDetdata_merged_2020-04-07.csv", header=T, na.strings=c("","NA")) 
spp_vis_merged_7April2020 <- read.csv('/home/galina/spp_vis_merged_2020-04-07.csv', header=T, na.strings=c("","NA"))

library(sparta, lib = "~/R_libs")

start.time <- Sys.time()
results_Polygonia_c.album_crick_mixLL2 <- sparta::occDetFunc(taxa_name = "Polygonia.c.album",
                                                              n_iterations = 50000,
                                                              burnin = 25000,
                                                              thinning = 3, 
                                                              occDetdata = occDetdata_merged_7April2020, 
                                                              spp_vis = spp_vis_merged_7April2020, 
                                                              modeltype = c('ranwalk', 'halfcauchy', 'mixlistlength2'), 
                                                              write_results = FALSE)
end.time <- Sys.time()
time.taken <- end.time - start.time
# Save outputs
saveRDS(results_Polygonia_c.album_crick_mixLL2, "/home/galina/results_Polygonia_c.album_crick_mixLL2.rds")
saveRDS(time.taken, "/home/galina/time.taken_results_Polygonia_c.album_crick_mixLL2.rds")










############################################# crick 16747
occDetdata_merged_7April2020 <- read.csv("/home/galina/occDetdata_merged_2020-04-07.csv", header=T, na.strings=c("","NA")) 
spp_vis_merged_7April2020 <- read.csv('/home/galina/spp_vis_merged_2020-04-07.csv', header=T, na.strings=c("","NA"))

library(sparta, lib = "~/R_libs")

start.time <- Sys.time()
results_Erebia_aethiops_crick_mixLL2 <- sparta::occDetFunc(taxa_name = "Erebia.aethiops",
                                                             n_iterations = 50000,
                                                             burnin = 25000,
                                                             thinning = 3, 
                                                             occDetdata = occDetdata_merged_7April2020, 
                                                             spp_vis = spp_vis_merged_7April2020, 
                                                             modeltype = c('ranwalk', 'halfcauchy', 'mixlistlength2'), 
                                                             write_results = FALSE)
end.time <- Sys.time()
time.taken <- end.time - start.time
# Save outputs
saveRDS(results_Erebia_aethiops_crick_mixLL2, "/home/galina/results_Erebia_aethiops_crick_mixLL2.rds")
saveRDS(time.taken, "/home/galina/time.taken_results_Erebia_aethiops_crick_mixLL2.rds")










############################################# crick 18549
occDetdata_merged_7April2020 <- read.csv("/home/galina/occDetdata_merged_2020-04-07.csv", header=T, na.strings=c("","NA")) 
spp_vis_merged_7April2020 <- read.csv('/home/galina/spp_vis_merged_2020-04-07.csv', header=T, na.strings=c("","NA"))

library(sparta, lib = "~/R_libs")

start.time <- Sys.time()
results_Aglais_urticae_crick_mixLL2 <- sparta::occDetFunc(taxa_name = "Aglais.urticae",
                                                           n_iterations = 50000,
                                                           burnin = 25000,
                                                           thinning = 3, 
                                                           occDetdata = occDetdata_merged_7April2020, 
                                                           spp_vis = spp_vis_merged_7April2020, 
                                                           modeltype = c('ranwalk', 'halfcauchy', 'mixlistlength2'), 
                                                           write_results = FALSE)
end.time <- Sys.time()
time.taken <- end.time - start.time
# Save outputs
saveRDS(results_Aglais_urticae_crick_mixLL2, "/home/galina/results_Aglais_urticae_crick_mixLL2.rds")
saveRDS(time.taken, "/home/galina/time.taken_results_Aglais_urticae_crick_mixLL2.rds")










############################################# crick 19296
occDetdata_merged_7April2020 <- read.csv("/home/galina/occDetdata_merged_2020-04-07.csv", header=T, na.strings=c("","NA")) 
spp_vis_merged_7April2020 <- read.csv('/home/galina/spp_vis_merged_2020-04-07.csv', header=T, na.strings=c("","NA"))

library(sparta, lib = "~/R_libs")

start.time <- Sys.time()
results_Pararge_aegeria_crick_mixLL2 <- sparta::occDetFunc(taxa_name = "Pararge.aegeria",
                                                          n_iterations = 50000,
                                                          burnin = 25000,
                                                          thinning = 3, 
                                                          occDetdata = occDetdata_merged_7April2020, 
                                                          spp_vis = spp_vis_merged_7April2020, 
                                                          modeltype = c('ranwalk', 'halfcauchy', 'mixlistlength2'), 
                                                          write_results = FALSE)
end.time <- Sys.time()
time.taken <- end.time - start.time
# Save outputs
saveRDS(results_Pararge_aegeria_crick_mixLL2, "/home/galina/results_Pararge_aegeria_crick_mixLL2.rds")
saveRDS(time.taken, "/home/galina/time.taken_results_Pararge_aegeria_crick_mixLL2.rds")










############################################# crick 20385
occDetdata_merged_7April2020 <- read.csv("/home/galina/occDetdata_merged_2020-04-07.csv", header=T, na.strings=c("","NA")) 
spp_vis_merged_7April2020 <- read.csv('/home/galina/spp_vis_merged_2020-04-07.csv', header=T, na.strings=c("","NA"))

library(sparta, lib = "~/R_libs")

start.time <- Sys.time()
results_Lycaena_phlaeas_crick_mixLL2 <- sparta::occDetFunc(taxa_name = "Lycaena.phlaeas",
                                                           n_iterations = 50000,
                                                           burnin = 25000,
                                                           thinning = 3, 
                                                           occDetdata = occDetdata_merged_7April2020, 
                                                           spp_vis = spp_vis_merged_7April2020, 
                                                           modeltype = c('ranwalk', 'halfcauchy', 'mixlistlength2'), 
                                                           write_results = FALSE)
end.time <- Sys.time()
time.taken <- end.time - start.time
# Save outputs
saveRDS(results_Lycaena_phlaeas_crick_mixLL2, "/home/galina/results_Lycaena_phlaeas_crick_mixLL2.rds")
saveRDS(time.taken, "/home/galina/time.taken_results_Lycaena_phlaeas_crick_mixLL2.rds")










############################################# crick 20879
occDetdata_merged_7April2020 <- read.csv("/home/galina/occDetdata_merged_2020-04-07.csv", header=T, na.strings=c("","NA")) 
spp_vis_merged_7April2020 <- read.csv('/home/galina/spp_vis_merged_2020-04-07.csv', header=T, na.strings=c("","NA"))

library(sparta, lib = "~/R_libs")

start.time <- Sys.time()
results_Pieris_rapae_crick_mixLL2 <- sparta::occDetFunc(taxa_name = "Pieris.rapae",
                                                           n_iterations = 50000,
                                                           burnin = 25000,
                                                           thinning = 3, 
                                                           occDetdata = occDetdata_merged_7April2020, 
                                                           spp_vis = spp_vis_merged_7April2020, 
                                                           modeltype = c('ranwalk', 'halfcauchy', 'mixlistlength2'), 
                                                           write_results = FALSE)
end.time <- Sys.time()
time.taken <- end.time - start.time
# Save outputs
saveRDS(results_Pieris_rapae_crick_mixLL2, "/home/galina/results_Pieris_rapae_crick_mixLL2.rds")
saveRDS(time.taken, "/home/galina/time.taken_results_Pieris_rapae_crick_mixLL2.rds")
















##########################################################################################
####################################### 4 JAN 2020 #######################################
##########################################################################################


# scp -o ProxyJump=galj@orca.nhm.ac.uk -r galina@157.140.15.119:/home/galina/ .
# scp -o ProxyJump=galj@orca.nhm.ac.uk -r galina@157.140.15.118:/home/galina/ .


############################################# watson
# rm -rf ~/sparta.zip
# rm -rf ~/sparta
# rm -rf ~/__MACOSX


############################################# crick
# rm -rf ~/sparta.zip
# rm -rf ~/sparta
# rm -rf ~/__MACOSX













##########################################################################################
##################################### 25 APRIL 2021 ######################################
##########################################################################################


# scp -o ProxyJump=galj@orca.nhm.ac.uk -r galina@ctag:/home/galina/results_Pieris_brassicae_crick_mixLL.rds .
# scp -o ProxyJump=galj@orca.nhm.ac.uk -r galina@ctag:/home/galina/time.taken_results_Pieris_brassicae_crick_mixLL.rds .
# scp -o ProxyJump=galj@orca.nhm.ac.uk spp_vis_merged_2020-04-07.csv galina@ctag:
# scp -o ProxyJump=galj@orca.nhm.ac.uk occDetdata_merged_2020-04-07.csv galina@ctag:





############################################# watson 29873

occDetdata_merged_7April2020 <- read.csv("/home/galina/occDetdata_merged_2020-04-07.csv", header=T, na.strings=c("","NA")) 
spp_vis_merged_7April2020 <- read.csv('/home/galina/spp_vis_merged_2020-04-07.csv', header=T, na.strings=c("","NA"))

library(sparta, lib = "~/R_libs")

start.time <- Sys.time()
results_Aglais_urticae_watson_catLL <- sparta::occDetFunc(taxa_name = "Aglais.urticae",
                                                    n_iterations = 50000,
                                                    burnin = 25000,
                                                    thinning = 5, 
                                                    occDetdata = occDetdata_merged_7April2020, 
                                                    spp_vis = spp_vis_merged_7April2020, 
                                                    modeltype = c('ranwalk', 'halfcauchy', 'catlistlength'), 
                                                    write_results = FALSE)
end.time <- Sys.time()
time.taken <- end.time - start.time
# Save outputs
saveRDS(results_Aglais_urticae_watson_catLL, "/home/galina/results_Aglais_urticae_watson_catLL.rds")
saveRDS(time.taken, "/home/galina/time.taken_results_Aglais_urticae_watson_catLL.rds")





############################################# watson 32046

occDetdata_merged_7April2020 <- read.csv("/home/galina/occDetdata_merged_2020-04-07.csv", header=T, na.strings=c("","NA")) 
spp_vis_merged_7April2020 <- read.csv('/home/galina/spp_vis_merged_2020-04-07.csv', header=T, na.strings=c("","NA"))

library(sparta, lib = "~/R_libs")

start.time <- Sys.time()
results_Carterocephalus_palaemon_watson_catLL <- sparta::occDetFunc(taxa_name = "Carterocephalus.palaemon",
                                                    n_iterations = 50000,
                                                    burnin = 25000,
                                                    thinning = 5, 
                                                    occDetdata = occDetdata_merged_7April2020, 
                                                    spp_vis = spp_vis_merged_7April2020, 
                                                    modeltype = c('ranwalk', 'halfcauchy', 'catlistlength'), 
                                                    write_results = FALSE)
end.time <- Sys.time()
time.taken <- end.time - start.time
# Save outputs
saveRDS(results_Carterocephalus_palaemon_watson_catLL, "/home/galina/results_Carterocephalus_palaemon_watson_catLL.rds")
saveRDS(time.taken, "/home/galina/time.taken_results_Carterocephalus_palaemon_watson_catLL.rds")





############################################# watson 34953

occDetdata_merged_7April2020 <- read.csv("/home/galina/occDetdata_merged_2020-04-07.csv", header=T, na.strings=c("","NA")) 
spp_vis_merged_7April2020 <- read.csv('/home/galina/spp_vis_merged_2020-04-07.csv', header=T, na.strings=c("","NA"))

library(sparta, lib = "~/R_libs")

start.time <- Sys.time()
results_Erebia_aethiops_watson_catLL <- sparta::occDetFunc(taxa_name = "Erebia.aethiops",
                                                    n_iterations = 50000,
                                                    burnin = 25000,
                                                    thinning = 5, 
                                                    occDetdata = occDetdata_merged_7April2020, 
                                                    spp_vis = spp_vis_merged_7April2020, 
                                                    modeltype = c('ranwalk', 'halfcauchy', 'catlistlength'), 
                                                    write_results = FALSE)
end.time <- Sys.time()
time.taken <- end.time - start.time
# Save outputs
saveRDS(results_Erebia_aethiops_watson_catLL, "/home/galina/results_Erebia_aethiops_watson_catLL.rds")
saveRDS(time.taken, "/home/galina/time.taken_results_Erebia_aethiops_watson_catLL.rds")





############################################# watson 5194

occDetdata_merged_7April2020 <- read.csv("/home/galina/occDetdata_merged_2020-04-07.csv", header=T, na.strings=c("","NA")) 
spp_vis_merged_7April2020 <- read.csv('/home/galina/spp_vis_merged_2020-04-07.csv', header=T, na.strings=c("","NA"))

library(sparta, lib = "~/R_libs")

start.time <- Sys.time()
results_Erebia_epiphron_watson_catLL <- sparta::occDetFunc(taxa_name = "Erebia.epiphron",
                                                    n_iterations = 50000,
                                                    burnin = 25000,
                                                    thinning = 5, 
                                                    occDetdata = occDetdata_merged_7April2020, 
                                                    spp_vis = spp_vis_merged_7April2020, 
                                                    modeltype = c('ranwalk', 'halfcauchy', 'catlistlength'), 
                                                    write_results = FALSE)
end.time <- Sys.time()
time.taken <- end.time - start.time
# Save outputs
saveRDS(results_Erebia_epiphron_watson_catLL, "/home/galina/results_Erebia_epiphron_watson_catLL.rds")
saveRDS(time.taken, "/home/galina/time.taken_results_Erebia_epiphron_watson_catLL.rds")





############################################# crick 21860

occDetdata_merged_7April2020 <- read.csv("/home/galina/occDetdata_merged_2020-04-07.csv", header=T, na.strings=c("","NA")) 
spp_vis_merged_7April2020 <- read.csv('/home/galina/spp_vis_merged_2020-04-07.csv', header=T, na.strings=c("","NA"))

library(sparta, lib = "~/R_libs")

start.time <- Sys.time()
results_Limenitis_camilla_crick_catLL <- sparta::occDetFunc(taxa_name = "Limenitis.camilla",
                                                    n_iterations = 50000,
                                                    burnin = 25000,
                                                    thinning = 5, 
                                                    occDetdata = occDetdata_merged_7April2020, 
                                                    spp_vis = spp_vis_merged_7April2020, 
                                                    modeltype = c('ranwalk', 'halfcauchy', 'catlistlength'), 
                                                    write_results = FALSE)
end.time <- Sys.time()
time.taken <- end.time - start.time
# Save outputs
saveRDS(results_Limenitis_camilla_crick_catLL, "/home/galina/results_Limenitis_camilla_crick_catLL.rds")
saveRDS(time.taken, "/home/galina/time.taken_results_Limenitis_camilla_crick_catLL.rds")





############################################# crick 21885

occDetdata_merged_7April2020 <- read.csv("/home/galina/occDetdata_merged_2020-04-07.csv", header=T, na.strings=c("","NA")) 
spp_vis_merged_7April2020 <- read.csv('/home/galina/spp_vis_merged_2020-04-07.csv', header=T, na.strings=c("","NA"))

library(sparta, lib = "~/R_libs")

start.time <- Sys.time()
results_Lycaena_phlaeas_crick_catLL <- sparta::occDetFunc(taxa_name = "Lycaena.phlaeas",
                                                    n_iterations = 50000,
                                                    burnin = 25000,
                                                    thinning = 5, 
                                                    occDetdata = occDetdata_merged_7April2020, 
                                                    spp_vis = spp_vis_merged_7April2020, 
                                                    modeltype = c('ranwalk', 'halfcauchy', 'catlistlength'), 
                                                    write_results = FALSE)
end.time <- Sys.time()
time.taken <- end.time - start.time
# Save outputs
saveRDS(results_Lycaena_phlaeas_crick_catLL, "/home/galina/results_Lycaena_phlaeas_crick_catLL.rds")
saveRDS(time.taken, "/home/galina/time.taken_results_Lycaena_phlaeas_crick_catLL.rds")





############################################# crick 21990

occDetdata_merged_7April2020 <- read.csv("/home/galina/occDetdata_merged_2020-04-07.csv", header=T, na.strings=c("","NA")) 
spp_vis_merged_7April2020 <- read.csv('/home/galina/spp_vis_merged_2020-04-07.csv', header=T, na.strings=c("","NA"))

library(sparta, lib = "~/R_libs")

start.time <- Sys.time()
results_Melitaea_athalia_crick_catLL <- sparta::occDetFunc(taxa_name = "Melitaea.athalia",
                                                    n_iterations = 50000,
                                                    burnin = 25000,
                                                    thinning = 5, 
                                                    occDetdata = occDetdata_merged_7April2020, 
                                                    spp_vis = spp_vis_merged_7April2020, 
                                                    modeltype = c('ranwalk', 'halfcauchy', 'catlistlength'), 
                                                    write_results = FALSE)
end.time <- Sys.time()
time.taken <- end.time - start.time
# Save outputs
saveRDS(results_Melitaea_athalia_crick_catLL, "/home/galina/results_Melitaea_athalia_crick_catLL.rds")
saveRDS(time.taken, "/home/galina/time.taken_results_Melitaea_athalia_crick_catLL.rds")





############################################# crick 22227

occDetdata_merged_7April2020 <- read.csv("/home/galina/occDetdata_merged_2020-04-07.csv", header=T, na.strings=c("","NA")) 
spp_vis_merged_7April2020 <- read.csv('/home/galina/spp_vis_merged_2020-04-07.csv', header=T, na.strings=c("","NA"))

library(sparta, lib = "~/R_libs")

start.time <- Sys.time()
results_Pararge_aegeria_crick_catLL <- sparta::occDetFunc(taxa_name = "Pararge.aegeria",
                                                    n_iterations = 50000,
                                                    burnin = 25000,
                                                    thinning = 5, 
                                                    occDetdata = occDetdata_merged_7April2020, 
                                                    spp_vis = spp_vis_merged_7April2020, 
                                                    modeltype = c('ranwalk', 'halfcauchy', 'catlistlength'), 
                                                    write_results = FALSE)
end.time <- Sys.time()
time.taken <- end.time - start.time
# Save outputs
saveRDS(results_Pararge_aegeria_crick_catLL, "/home/galina/results_Pararge_aegeria_crick_catLL.rds")
saveRDS(time.taken, "/home/galina/time.taken_results_Pararge_aegeria_crick_catLL.rds")





############################################# ctag 18776

occDetdata_merged_7April2020 <- read.csv("/home/galina/occDetdata_merged_2020-04-07.csv", header=T, na.strings=c("","NA")) 
spp_vis_merged_7April2020 <- read.csv('/home/galina/spp_vis_merged_2020-04-07.csv', header=T, na.strings=c("","NA"))

library(sparta, lib = "~/R_libs")

start.time <- Sys.time()
results_Pieris_rapae_ctag_catLL <- sparta::occDetFunc(taxa_name = "Pieris.rapae",
                                                    n_iterations = 50000,
                                                    burnin = 25000,
                                                    thinning = 5, 
                                                    occDetdata = occDetdata_merged_7April2020, 
                                                    spp_vis = spp_vis_merged_7April2020, 
                                                    modeltype = c('ranwalk', 'halfcauchy', 'catlistlength'), 
                                                    write_results = FALSE)
end.time <- Sys.time()
time.taken <- end.time - start.time
# Save outputs
saveRDS(results_Pieris_rapae_ctag_catLL, "/home/galina/results_Pieris_rapae_ctag_catLL.rds")
saveRDS(time.taken, "/home/galina/time.taken_results_Pieris_rapae_ctag_catLL.rds")





############################################# ctag 18819

occDetdata_merged_7April2020 <- read.csv("/home/galina/occDetdata_merged_2020-04-07.csv", header=T, na.strings=c("","NA")) 
spp_vis_merged_7April2020 <- read.csv('/home/galina/spp_vis_merged_2020-04-07.csv', header=T, na.strings=c("","NA"))

library(sparta, lib = "~/R_libs")

start.time <- Sys.time()
results_Polygonia_c_album_ctag_catLL <- sparta::occDetFunc(taxa_name = "Polygonia.c.album",
                                                    n_iterations = 50000,
                                                    burnin = 25000,
                                                    thinning = 5, 
                                                    occDetdata = occDetdata_merged_7April2020, 
                                                    spp_vis = spp_vis_merged_7April2020, 
                                                    modeltype = c('ranwalk', 'halfcauchy', 'catlistlength'), 
                                                    write_results = FALSE)
end.time <- Sys.time()
time.taken <- end.time - start.time
# Save outputs
saveRDS(results_Polygonia_c_album_ctag_catLL, "/home/galina/results_Polygonia_c_album_ctag_catLL.rds")
saveRDS(time.taken, "/home/galina/time.taken_results_Polygonia_c_album_ctag_catLL.rds")





############################################# ctag 18830

occDetdata_merged_7April2020 <- read.csv("/home/galina/occDetdata_merged_2020-04-07.csv", header=T, na.strings=c("","NA")) 
spp_vis_merged_7April2020 <- read.csv('/home/galina/spp_vis_merged_2020-04-07.csv', header=T, na.strings=c("","NA"))

library(sparta, lib = "~/R_libs")

start.time <- Sys.time()
results_Polyommatus_bellargus_ctag_catLL <- sparta::occDetFunc(taxa_name = "Polyommatus.bellargus",
                                                    n_iterations = 50000,
                                                    burnin = 25000,
                                                    thinning = 5, 
                                                    occDetdata = occDetdata_merged_7April2020, 
                                                    spp_vis = spp_vis_merged_7April2020, 
                                                    modeltype = c('ranwalk', 'halfcauchy', 'catlistlength'), 
                                                    write_results = FALSE)
end.time <- Sys.time()
time.taken <- end.time - start.time
# Save outputs
saveRDS(results_Polyommatus_bellargus_ctag_catLL, "/home/galina/results_Polyommatus_bellargus_ctag_catLL.rds")
saveRDS(time.taken, "/home/galina/time.taken_results_Polyommatus_bellargus_ctag_catLL.rds")





############################################# ctag 18862

occDetdata_merged_7April2020 <- read.csv("/home/galina/occDetdata_merged_2020-04-07.csv", header=T, na.strings=c("","NA")) 
spp_vis_merged_7April2020 <- read.csv('/home/galina/spp_vis_merged_2020-04-07.csv', header=T, na.strings=c("","NA"))

library(sparta, lib = "~/R_libs")

start.time <- Sys.time()
results_Thecla_betulae_ctag_catLL <- sparta::occDetFunc(taxa_name = "Thecla.betulae",
                                                    n_iterations = 50000,
                                                    burnin = 25000,
                                                    thinning = 5, 
                                                    occDetdata = occDetdata_merged_7April2020, 
                                                    spp_vis = spp_vis_merged_7April2020, 
                                                    modeltype = c('ranwalk', 'halfcauchy', 'catlistlength'), 
                                                    write_results = FALSE)
end.time <- Sys.time()
time.taken <- end.time - start.time
# Save outputs
saveRDS(results_Thecla_betulae_ctag_catLL, "/home/galina/results_Thecla_betulae_ctag_catLL.rds")
saveRDS(time.taken, "/home/galina/time.taken_results_Thecla_betulae_ctag_catLL.rds")









##########################################################################################
###################################### 16 May 2021 #######################################
##########################################################################################


# scp -o ProxyJump=galj@orca.nhm.ac.uk -r galina@157.140.15.119:/home/galina/results_Limenitis_camilla_crick_catLL.rds .
# scp -o ProxyJump=galj@orca.nhm.ac.uk -r galina@157.140.15.119:/home/galina/results_Melitaea_athalia_crick_catLL.rds .
# scp -o ProxyJump=galj@orca.nhm.ac.uk -r galina@157.140.15.119:/home/galina/time.taken_results_Limenitis_camilla_crick_catLL.rds .
# scp -o ProxyJump=galj@orca.nhm.ac.uk -r galina@157.140.15.119:/home/galina/time.taken_results_Melitaea_athalia_crick_catLL.rds .



##########################################################################################
###################################### 17 May 2021 #######################################
##########################################################################################


# scp -o ProxyJump=galj@orca.nhm.ac.uk -r galina@157.140.15.119:/home/galina/results_Lycaena_phlaeas_crick_catLL.rds .
# scp -o ProxyJump=galj@orca.nhm.ac.uk -r galina@157.140.15.119:/home/galina/results_Pararge_aegeria_crick_catLL.rds .
# scp -o ProxyJump=galj@orca.nhm.ac.uk -r galina@157.140.15.119:/home/galina/time.taken_results_Lycaena_phlaeas_crick_catLL.rds .
# scp -o ProxyJump=galj@orca.nhm.ac.uk -r galina@157.140.15.119:/home/galina/time.taken_results_Pararge_aegeria_crick_catLL.rds .

# scp -o ProxyJump=galj@orca.nhm.ac.uk -r galina@157.140.15.118:/home/galina/results_Carterocephalus_palaemon_watson_catLL.rds .
# scp -o ProxyJump=galj@orca.nhm.ac.uk -r galina@157.140.15.118:/home/galina/results_Erebia_aethiops_watson_catLL.rds .
# scp -o ProxyJump=galj@orca.nhm.ac.uk -r galina@157.140.15.118:/home/galina/results_Erebia_epiphron_watson_catLL.rds .
# scp -o ProxyJump=galj@orca.nhm.ac.uk -r galina@157.140.15.118:/home/galina/time.taken_results_Carterocephalus_palaemon_watson_catLL.rds .
# scp -o ProxyJump=galj@orca.nhm.ac.uk -r galina@157.140.15.118:/home/galina/time.taken_results_Erebia_aethiops_watson_catLL.rds .
# scp -o ProxyJump=galj@orca.nhm.ac.uk -r galina@157.140.15.118:/home/galina/time.taken_results_Erebia_epiphron_watson_catLL.rds .




##########################################################################################
###################################### 19 May 2021 #######################################
##########################################################################################


# scp -o ProxyJump=galj@orca.nhm.ac.uk -r galina@157.140.15.118:/home/galina/results_Aglais_urticae_watson_catLL.rds .
# scp -o ProxyJump=galj@orca.nhm.ac.uk -r galina@157.140.15.118:/home/galina/time.taken_results_Aglais_urticae_watson_catLL.rds .




##########################################################################################
###################################### 28 May 2021 #######################################
##########################################################################################


# scp -o ProxyJump=galj@orca.nhm.ac.uk -r galina@ctag:/home/galina .






##########################################################################################
###################################### 7 Sep 2021 ########################################
##########################################################################################

### Here I run A. urticae with priors for dtype3 at (-3, 0.001) instead of (0, 0.001)

library(sparta)

spp_vis_merged_7April2020 <- read.csv("./data/formattedData/spp_vis_merged_2020-04-07.csv", header=T, na.strings=c("","NA"))
occDetdata_merged_7April2020 <- read.csv("./data/formattedData/occDetdata_merged_2020-04-07.csv", header=T, na.strings=c("","NA")) 


results_Aglais_urticae_catLL <- sparta::occDetFunc(taxa_name = "Aglais.urticae",
                                                        n_iterations = 30000,
                                                        burnin = 15000,
                                                        thinning = 3, 
                                                        occDetdata = occDetdata_merged_7April2020, 
                                                        spp_vis = spp_vis_merged_7April2020, 
                                                        modeltype = c('ranwalk', 'halfcauchy', 'catlistlength'), 
                                                        write_results = FALSE)

# Save outputs
saveRDS(results_Aglais_urticae_catLL, "./outputs/catLL-outputs/results_Aglais_urticae_prior-3_catLL.rds")



##########################################################################################
###################################### 13 Sep 2021 ########################################
##########################################################################################

### Here I run A. urticae with priors for dtype3 at (-3, 0.001) instead of (0, 0.001)

library(sparta)

spp_vis_merged_7April2020 <- read.csv("./data/formattedData/spp_vis_merged_2020-04-07.csv", header=T, na.strings=c("","NA"))
occDetdata_merged_7April2020 <- read.csv("./data/formattedData/occDetdata_merged_2020-04-07.csv", header=T, na.strings=c("","NA")) 
occDetdata_merged_7April2020$L[occDetdata_merged_7April2020$L <= 200] <- 1
occDetdata_merged_7April2020$L[occDetdata_merged_7April2020$L == 22222] <- 2
occDetdata_merged_7April2020$L[occDetdata_merged_7April2020$L == 33333] <- 3

count(occDetdata_merged_7April2020, L)
#      freq
# 1 1135652
# 2  205976
# 3   24583


occDetdata_merged_7April2020$TP <- findInterval(occDetdata_merged_7April2020$TP, seq(1,116, 5))


#occDetdata <- subset(occDetdata_merged_7April2020, TP <77 & TP >60)
#count(occDetdata$L)
#   freq
# 1 5479
# 3 2824

results_Aglais_urticae_catLL_5yrTP <- sparta::occDetFunc(taxa_name = "Aglais.urticae",
                                                         n_iterations = 15000,
                                                         burnin = 7500,
                                                         thinning = 3, 
                                                         occDetdata = occDetdata_merged_7April2020, 
                                                         spp_vis = spp_vis_merged_7April2020, 
                                                         modeltype = c('ranwalk', 'halfcauchy', 'catlistlength'),  
                                                         write_results = FALSE)

# Save outputs
saveRDS(results_Aglais_urticae_catLL_5yrTP, "./outputs/results_Aglais_urticae_catLL_5yrTP_3prior.rds")


# In sparta::occDetFunc(taxa_name = "Aglais.urticae", n_iterations = 15000,  :
# JAGS returned an error when modellingAglais.urticaeerror:
# Error in jags.model(model.file, data = data, inits = init.values, n.chains = n.chains,  : 
# Duplicated names in data list: logL dtype2p_min dtype2p_max

# Save outputs
#saveRDS(results_Aglais_urticae_catLL_NEWprior, "./outputs/results_Aglais_urticae_prior-3_catLL2_7000iter.rds")






###### 10 yrs

spp_vis_merged_7April2020 <- read.csv("./data/formattedData/spp_vis_merged_2020-04-07.csv", header=T, na.strings=c("","NA"))
occDetdata_merged_7April2020 <- read.csv("./data/formattedData/occDetdata_merged_2020-04-07.csv", header=T, na.strings=c("","NA")) 
occDetdata_merged_7April2020$L[occDetdata_merged_7April2020$L <= 200] <- 1
occDetdata_merged_7April2020$L[occDetdata_merged_7April2020$L == 22222] <- 2
occDetdata_merged_7April2020$L[occDetdata_merged_7April2020$L == 33333] <- 3


occDetdata_merged_7April2020$TP <- findInterval(occDetdata_merged_7April2020$TP, seq(1,116, 10))


#occDetdata <- subset(occDetdata_merged_7April2020, TP <77 & TP >60)
#count(occDetdata$L)
#   freq
# 1 5479
# 3 2824

results_Aglais_urticae_catLL_10yrTP <- sparta::occDetFunc(taxa_name = "Aglais.urticae",
                                                         n_iterations = 15000,
                                                         burnin = 7500,
                                                         thinning = 3, 
                                                         occDetdata = occDetdata_merged_7April2020, 
                                                         spp_vis = spp_vis_merged_7April2020, 
                                                         modeltype = c('ranwalk', 'halfcauchy', 'catlistlength'),  
                                                         write_results = FALSE)

# Save outputs
saveRDS(results_Aglais_urticae_catLL_10yrTP, "./outputs/results_Aglais_urticae_catLL_10yrTP_3prior.rds")





###### 15 yrs

spp_vis_merged_7April2020 <- read.csv("./data/formattedData/spp_vis_merged_2020-04-07.csv", header=T, na.strings=c("","NA"))
occDetdata_merged_7April2020 <- read.csv("./data/formattedData/occDetdata_merged_2020-04-07.csv", header=T, na.strings=c("","NA")) 
occDetdata_merged_7April2020$L[occDetdata_merged_7April2020$L <= 200] <- 1
occDetdata_merged_7April2020$L[occDetdata_merged_7April2020$L == 22222] <- 2
occDetdata_merged_7April2020$L[occDetdata_merged_7April2020$L == 33333] <- 3


occDetdata_merged_7April2020$TP <- findInterval(occDetdata_merged_7April2020$TP, seq(1,116, 15))



results_Aglais_urticae_catLL_15yrTP <- sparta::occDetFunc(taxa_name = "Aglais.urticae",
                                                          n_iterations = 15000,
                                                          burnin = 7500,
                                                          thinning = 3, 
                                                          occDetdata = occDetdata_merged_7April2020, 
                                                          spp_vis = spp_vis_merged_7April2020, 
                                                          modeltype = c('ranwalk', 'halfcauchy', 'catlistlength'),  
                                                          write_results = FALSE)

# Save outputs
saveRDS(results_Aglais_urticae_catLL_15yrTP, "./outputs/results_Aglais_urticae_catLL_15yrTP_3prior.rds")







##########################################################################################
###################################### 23 Nov 2021 ########################################
##########################################################################################


spp_vis_merged_7April2020 <- read.csv("./data/formattedData/spp_vis_merged_2020-04-07.csv", header=T, na.strings=c("","NA"))
occDetdata_merged_7April2020 <- read.csv("./data/formattedData/occDetdata_merged_2020-04-07.csv", header=T, na.strings=c("","NA")) 

library(sparta)


results_Aglais_urticae_mixLL_3prior <- sparta::occDetFunc(taxa_name = "Aglais.urticae",
                                                         n_iterations = 10000,
                                                         burnin = 5000,
                                                         thinning = 3, 
                                                         occDetdata = occDetdata_merged_7April2020, 
                                                         spp_vis = spp_vis_merged_7April2020, 
                                                         modeltype = c('ranwalk', 'halfcauchy', 'mixlistlength'),  
                                                         write_results = FALSE)

# Save outputs
saveRDS(results_Aglais_urticae_mixLL_3prior, "./outputs/results_Aglais_urticae_mixLL_3prior_10k.rds")




