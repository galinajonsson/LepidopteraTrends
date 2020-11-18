plot.MSIgal <- function(x, y, z,  
                        MSI = TRUE, # Change to method = MSI or Trends
                        pointEstimates = FALSE) { 
  if(isTRUE(MSI)){
  x$results$Source <- "All Species (53)"
  x$results$MSI <- x$results$MSI-(x$results$MSI[1])
  x$results$lower_CL_MSI <- x$results$lower_CL_MSI-(x$results$lower_CL_MSI[1])
  x$results$upper_CL_MSI <- x$results$upper_CL_MSI-(x$results$upper_CL_MSI[1])
  y$results$Source <- "Specialist Species (29)"
  y$results$MSI <- y$results$MSI-(y$results$MSI[1])
  y$results$lower_CL_MSI <- y$results$lower_CL_MSI-(y$results$lower_CL_MSI[1])
  y$results$upper_CL_MSI <- y$results$upper_CL_MSI-(y$results$upper_CL_MSI[1])
  z$results$Source <- "Generalist Species (24)"
  z$results$MSI <- z$results$MSI-(z$results$MSI[1])
  z$results$lower_CL_MSI <- z$results$lower_CL_MSI-(z$results$lower_CL_MSI[1])
  z$results$upper_CL_MSI <- z$results$upper_CL_MSI-(z$results$upper_CL_MSI[1])
  new.data.results <- rbind(y$results, x$results)
  new.data.results <- rbind(new.data.results, z$results)
  new.data.results$Source <- as.factor(new.data.results$Source)
  }
  
  
  ########## Include:
  # else if(isFALSE(MSI)){}
  
  
  
  
  ggplot(data = new.data.results, aes(x = year, y = MSI, group = Source)) +
    
    ########## Include and fix:
    #if(isTRUE(pointEstimates)) {
    #+ geom_point(aes(colour= Source)) +
    #ylim(c(0, max(x$results$MSI) + (max(x$results$MSI)/100)*10)) +
    #geom_errorbar(aes(ymin = new.data.results$MSI - (new.data.results$sd_MSI*1.96),
    #                  ymax = new.data.results$MSI + (new.data.results$sd_MSI*1.96),
    #                  colour= Source)) +
    #}
    
    ylim(c(-100, 110)) +
    scale_x_continuous(breaks=seq(1900,2020,20)) +
    geom_hline(yintercept = 0) +
    geom_vline(xintercept = 1975, linetype = "dashed") +
    geom_ribbon(aes(ymin = lower_CL_MSI, 
                    ymax = upper_CL_MSI), 
                colour = "grey", fill = "grey", alpha = 0.4) +
    geom_line(aes(y = MSI, colour= Source, linetype=Source)) +
    scale_color_manual(values=c('chocolate3', 'royalblue4', "chartreuse4")) +
    theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
            panel.background = element_blank(), axis.line = element_line(colour = "black")) +
    theme(text = element_text(size=24)) + ylab("Occupancy Change (%)") + xlab("Year") +
    theme(legend.title=element_blank())
  
}