#' Plot occDet Objects as annual occupancy lines with 95CIs ribbons (either one or two occDet objects can be plotted on one graph)
#' 
#' @param x An object of class occDet
#' @param y An object of class occDet
#' @param main The plot title, defaults to the species name
#' @param reg_agg The name of a region or region aggregate to plot.
#' If '' (default) then the overall occupancy estimates are plotted
#' @param ... Additional arguments passed to ggplot

#' @import ggplot2
#' @method plot occDet
#' @export

plot.occDet_G <- function(x, y = NULL, z = NULL, main = x$SPP_NAME, reg_agg = '', ...){
  
  require(ggplot2)
  
  ###############  x occDet  #################
  
  # gets summary output from the BUGS files 
  spp_data <- as.data.frame(x$BUGSoutput$summary)
  
  if(reg_agg != '') reg_agg <- paste0('.r_', reg_agg)
  
  # get rows we are interested in
  ### take psi.fs rows - these are the yearly proportion of occupied cells ###
  spp_data$X <- row.names(spp_data)
  new_data <- spp_data[grepl(paste0("^psi.fs", reg_agg, "\\["),spp_data$X),]
  new_data$year <- (Year = (x$min_year +1899) + as.numeric(gsub(paste0("psi.fs", reg_agg), "", gsub("\\[|\\]","", row.names(new_data)))))
  
  # rename columns, otherwise ggplot doesn't work properly    
  names(new_data) <- gsub("2.5%","quant_025", names(new_data))
  names(new_data) <- gsub("97.5%","quant_975", names(new_data))
  
  
  
  ##### PLOT ANNUAL OCCUPANCY #####
  # plot line with ribbon based on 95% CIs
  
  
  ### For three species:
  
  if(is.null(z)==FALSE){
    
    
    
    ###############  y occDet  #################
    
    # gets summary output from the BUGS files 
    spp_data2 <- as.data.frame(y$BUGSoutput$summary)
    
    if(reg_agg != '') reg_agg <- paste0('.r_', reg_agg)
    
    # get rows we are interested in
    ### take psi.fs rows - these are the yearly proportion of occupied cells ###
    spp_data2$X <- row.names(spp_data2)
    new_data2 <- spp_data2[grepl(paste0("^psi.fs", reg_agg, "\\["),spp_data2$X),]
    new_data2$year <- (Year = (y$min_year +1899) + as.numeric(gsub(paste0("psi.fs", reg_agg), "", 
                                                                   gsub("\\[|\\]","", row.names(new_data2)))))
    # rename columns, otherwise ggplot doesn't work properly    
    names(new_data2) <- gsub("2.5%","quant_025", names(new_data2))
    names(new_data2) <- gsub("97.5%","quant_975", names(new_data2))
    
    
    
    ###############  z occDet  #################
    
    # gets summary output from the BUGS files 
    spp_data3 <- as.data.frame(z$BUGSoutput$summary)
    
    if(reg_agg != '') reg_agg <- paste0('.r_', reg_agg)
    
    # get rows we are interested in
    ### take psi.fs rows - these are the yearly proportion of occupied cells ###
    spp_data3$X <- row.names(spp_data3)
    new_data3 <- spp_data3[grepl(paste0("^psi.fs", reg_agg, "\\["),spp_data3$X),]
    new_data3$year <- (Year = (z$min_year +1899) + as.numeric(gsub(paste0("psi.fs", reg_agg), "", 
                                                                   gsub("\\[|\\]","", row.names(new_data3)))))
    # rename columns, otherwise ggplot doesn't work properly    
    names(new_data3) <- gsub("2.5%","quant_025", names(new_data3))
    names(new_data3) <- gsub("97.5%","quant_975", names(new_data3))
    
    
    
    ###############  PLOT  #################
    ### lines with ribbons based on 95% CIs
    
    ggplot(new_data, aes_string(x = "year", y = "mean")) + 
      geom_ribbon(data = new_data3,
                  aes_string(group = 1, 
                             ymin = "quant_025", ymax = "quant_975"),
                  alpha = 0.3, fill = "#E69F00") +
      geom_ribbon(data = new_data2,
                  aes_string(group = 1, 
                             ymin = "quant_025", ymax = "quant_975"),
                  alpha = 0.3, fill= "#0072B2") +
      geom_ribbon(data = new_data,
                  aes_string(group = 1, 
                             ymin = "quant_025", ymax = "quant_975"),
                  alpha = 0.3, fill= "#000000") +
      geom_line(data = new_data, size = 1, 
                aes(col = c("#000000")), #colour = c("#000000"), 
                linetype = 2) +
      geom_line(data = new_data2, size = 1, 
                aes(col = c("#0072B2")), #colour = c("#E69F00"), 
                linetype = "solid") +
      geom_line(data = new_data3, size = 1, 
                aes(colour = c("#E69F00")), #colour = c("#56B4E9"), 
                linetype = "solid") +
      geom_vline(xintercept = 1976, linetype = "dashed") +   # Vertical line = 1976
      ylab("Occupancy") +
      xlab("Year") +
      scale_y_continuous(limits = c(0, 1)) +   # Limits to y-scale
      scale_x_continuous(breaks=seq(1900, 2020, 20), limits = c(1900, 2025)) +
      theme(legend.position="bottom") +
      #theme(plot.title = element_text(lineheight = .8, face = "bold"))+
      scale_colour_manual(name = 'Model', 
                          values =c("#000000" = "#000000",
                                    "#0072B2" = "#0072B2",
                                    "#E69F00" = "#E69F00"), 
                          labels = c("A",
                                     "B", 
                                     "C")) +
      #  scale_linetype_manual(name = 'Model',
      #                        values =c(#"#56B4E9" = 
      #                          "solid",
      #                               # "#E69F00" =  
       #                         "solid",
      #                              #  "#000000" = 
      ##                          "dotted"),
      #                      labels = c("A",
      #                                 "B", 
      #                                 "C")) +
  #  scale_color_manual(values = c("a" = "gray40", "b" = "gray70", "log2(x)" = "cadetblue2")) +
    #scale_color_manual(values = c("a" = "gray40", "b" = "gray70", "log2(x)" = "cadetblue2")) +
    #  scale_shape_manual(values = c("a" = 16, "b" = 17, "log2(x)" = NA)) +
    #  scale_linetype_manual(values = c("a" = "blank", "b" = "blank", "log2(x)" = "solid"))
    #  guides(fill = guide_legend(title = "Model",
    #         colour = c("#000000",
    #                    "#E69F00",
    #                    "#56B4E9"),
    #         linetype = c("blank", "blank", "solid"))) +
      theme(panel.grid.major = element_blank(), 
            panel.grid.minor = element_blank(),
            panel.background = element_blank(), 
            axis.line = element_line(colour = "black")) #+
      #guides(fill = guide_legend(title = 
      #                             title.theme = element_text(
       #   size = 15,
       #   face = "italic",
        #  colour = "red",
     #     angle = 0
    #    )) +
     # theme(text=element_text(size=25)) 
     # guides(shape = guide_legend(override.aes = list(color = c("gray40", "gray70", "cadetblue2"),
     #                                                 shape = c(16, 17, 16),
     #                                                 linetype = c("blank", "blank", "solid"))))
  } else if(is.null(y)==FALSE){
    
    
    
    ###############  y occDet  #################
    
    # gets summary output from the BUGS files 
    spp_data2 <- as.data.frame(y$BUGSoutput$summary)
    
    if(reg_agg != '') reg_agg <- paste0('.r_', reg_agg)
    
    # get rows we are interested in
    ### take psi.fs rows - these are the yearly proportion of occupied cells ###
    spp_data2$X <- row.names(spp_data2)
    new_data2 <- spp_data2[grepl(paste0("^psi.fs", reg_agg, "\\["),spp_data2$X),]
    new_data2$year <- (Year = (y$min_year +1899) + as.numeric(gsub(paste0("psi.fs", reg_agg), "", 
                                                                   gsub("\\[|\\]","", row.names(new_data2)))))
    # rename columns, otherwise ggplot doesn't work properly    
    names(new_data2) <- gsub("2.5%","quant_025", names(new_data2))
    names(new_data2) <- gsub("97.5%","quant_975", names(new_data2))
    
    
    
    
    ###############  PLOT  #################
    ### lines with ribbons based on 95% CIs
    
    ggplot(new_data, aes_string(x = "year", y = "mean")) + 
      geom_ribbon(data = new_data,
                  aes_string(group = 1, 
                             ymin = "quant_025", ymax = "quant_975"),
                  alpha = 0.2, fill = "black") +
      geom_ribbon(data = new_data2,
                  aes_string(group = 1, 
                             ymin = "quant_025", ymax = "quant_975"),
                  alpha = 0.2, fill="red") +
      geom_line(data = new_data, size = 1, 
                aes(col = "black"), linetype = "solid") +
      geom_line(data = new_data2, size = 1, 
                aes(col = "red"), linetype = "solid") +
      geom_vline(xintercept = 1976, linetype = "dashed") +   # Vertical line = 1976
      ylab("Occupancy") +
      xlab("Year") +
      scale_y_continuous(limits = c(0, 1)) +   # Limits to y-scale
      scale_x_continuous(breaks=seq(1900, 2020, 20), limits = c(1900, 2025)) +
      #theme(plot.title = element_text(lineheight = .8, face = "bold"))+
      scale_colour_manual(name = 'Model', 
                          values =c("red"="red",
                                    "black"="black"), 
                          labels = c("B", 
                                     "C")) +
      theme(panel.grid.major = element_blank(), 
            panel.grid.minor = element_blank(),
            panel.background = element_blank(), 
            axis.line = element_line(colour = "black")) +
      theme(text=element_text(size=25)) 
  } else if(is.null(y)==TRUE){
    
  ggplot(new_data, aes_string(x = "year", y = "mean"), ...) + 
    geom_ribbon(data = new_data,
                aes_string(group = 1, 
                           ymin = "quant_025", ymax = "quant_975"),
                alpha = 0.2) +
    geom_line(size = 1, col = "black") +   # Line colour
    geom_vline(xintercept = 1976, linetype = "dashed") +   # Vertical line = 1976
    ylab("Occupancy") +
    xlab("Year") +
    scale_y_continuous(limits = c(0, 1)) +   # Limits to y-scale
    scale_x_continuous(breaks=seq(1900, 2020, 20), limits = c(1900, 2025)) +
    ggtitle(main) + 
    theme(panel.grid.major = element_blank(), 
          panel.grid.minor = element_blank(),
          panel.background = element_blank(), 
          axis.line = element_line(colour = "black")) +
    theme(text=element_text(size=30))
    
    
    }
}
