################################################################################
#
# Extract lhfa data
#
################################################################################

get_lhfa_zchart <- function(baseurl = "http://www.who.int/childgrowth/standards/",
                            gender = c("boys", "girls")) {
  #
  #
  #
  temp <- NULL
  #
  #
  #
  for(i in gender) {
    #
    #
    #
    z_data <- read.table(file = paste(baseurl, "lhfa_", i, "_z_exp.txt", sep = ""),
                         header = TRUE)
    #
    #
    #
    z_data <- data.frame("sex" = i, "month" = z_data$Day/30.4375, z_data)
    #
    #
    #
    temp <- data.frame(rbind(temp, z_data))
  }
  #
  #
  #
  names(temp) <- c("sex", "month", "day", "-4SD", "-3SD", "-2SD", "-1SD", "0", "1SD", "2SD", "3SD", "4SD")
  #
  #
  #
  lhfa_chart <- tidyr::gather(data = temp, key = "sd_type", value = "sd_value", names(temp)[4]:names(temp)[ncol(temp)])
  names(lhfa_chart) <- c("sex", "month", "day", "sd_type", "sd_value")
  lhfa_chart$sd_type <- factor(lhfa_chart$sd_type, levels = c("4SD", "3SD", "2SD", "1SD", "0", "-1SD", "-2SD", "-3SD", "-4SD"))
  #
  #
  #
  return(lhfa_chart)
}


xx <- get_lhfa_zchart()


p <- ggplot(xx[xx$sex == "boys" & xx$month < 24 & !xx$sd_type %in% c("-4SD", "4SD", "-1SD", "1SD"), ],
            aes(x = month, y = sd_value, group = sd_type))

p + geom_line(size = 1.5, aes(colour = sd_type)) +
    labs(x = "Month", y = "Length/Height (cms)", colour = "z-score") +
    scale_color_manual(values = c("red", "orange", "darkgreen", "orange", "red")) +
    scale_x_discrete(limits = 0:24) + scale_y_continuous(breaks = seq(45, 100, 5)) +
    theme_gray()


p <- ggplot(xx[xx$sex == "girls" & xx$month < 24 & !xx$sd_type %in% c("-4SD", "4SD", "-1SD", "1SD"), ],
            aes(x = month, y = sd_value, group = sd_type))

p + geom_line(size = 2, aes(colour = sd_type)) + scale_color_manual(values = c("red", "orange", "darkgreen", "yellow", "red"))




p <- ggplot(xx[xx$sex == "boys" & xx$month >= 24 & !xx$sd_type %in% c("-4SD", "4SD", "-1SD", "1SD"), ],
            aes(x = month, y = sd_value, group = sd_type))

p + geom_line(size = 2, aes(colour = sd_type)) + scale_color_manual(values = c("red", "yellow", "darkgreen", "yellow", "red"))








