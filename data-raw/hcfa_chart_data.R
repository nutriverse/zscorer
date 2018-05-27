################################################################################
#
# Extract hcfa data - zscore
#
################################################################################

get_hcfa_zchart <- function(baseurl = "http://www.who.int/childgrowth/standards/",
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
    z_data <- read.table(file = paste(baseurl, "second_set/hcfa_", i, "_z_exp.txt", sep = ""),
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
  hcfa_chart <- tidyr::gather(data = temp, key = "sd_type", value = "sd_value", names(temp)[4]:names(temp)[ncol(temp)])
  names(hcfa_chart) <- c("sex", "month", "day", "sd_type", "sd_value")
  hcfa_chart$sd_type <- factor(hcfa_chart$sd_type, levels = c("4SD", "3SD", "2SD", "1SD", "0", "-1SD", "-2SD", "-3SD", "-4SD"))
  #
  #
  #
  return(hcfa_chart)
}


#
#
#
xx <- get_hcfa_zchart()


################################################################################
#
#
#
################################################################################

p <- ggplot(xx[xx$sex == "boys" & xx$month < 24 & !xx$sd_type %in% c("-4SD", "4SD", "-1SD", "1SD"), ],
            aes(x = month, y = sd_value, group = sd_type))

p + geom_line(size = 1, aes(colour = sd_type)) +
  labs(x = "Month", y = "Weight (kgs)", colour = "z-score") +
  scale_color_manual(guide = FALSE, values = c("red", "orange", "darkgreen", "orange", "red")) +
  scale_x_discrete(limits = 0:25) +
  scale_y_continuous(breaks = seq(45, 100, 5)) +
  geom_dl(aes(label = sd_type, colour = sd_type, size = 0.5), method = list(dl.trans(x = x + 0.2), "last.points")) +
  theme_gray()

################################################################################
#
#
#
################################################################################

p <- ggplot(xx[xx$sex == "girls" & xx$month < 24 & !xx$sd_type %in% c("-4SD", "4SD", "-1SD", "1SD"), ],
            aes(x = month, y = sd_value, group = sd_type))

p + geom_line(size = 1, aes(colour = sd_type)) +
  labs(x = "Month", y = "Length/Height (cms)", colour = "z-score") +
  scale_color_manual(values = c("red", "orange", "darkgreen", "orange", "red")) +
  scale_x_discrete(limits = 0:24) + scale_y_continuous(breaks = seq(45, 100, 5)) +
  theme_gray()


################################################################################
#
#
#
################################################################################

p <- ggplot(xx[xx$sex == "boys" & xx$month >= 24 & !xx$sd_type %in% c("-4SD", "4SD", "-1SD", "1SD"), ],
            aes(x = month, y = sd_value, group = sd_type))

p + geom_line(size = 1, aes(colour = sd_type)) +
  labs(x = "Month", y = "Length/Height (cms)", colour = "z-score") +
  scale_color_manual(values = c("red", "orange", "darkgreen", "orange", "red")) +
  scale_x_discrete(limits = 24:61) + scale_y_continuous(breaks = seq(75, 125, 5)) +
  theme_gray()


################################################################################
#
#
#
################################################################################

p <- ggplot(xx[xx$sex == "girls" & xx$month >= 24 & !xx$sd_type %in% c("-4SD", "4SD", "-1SD", "1SD"), ],
            aes(x = month, y = sd_value, group = sd_type))

p + geom_line(size = 1, aes(colour = sd_type)) +
  labs(x = "Month", y = "Length/Height (cms)", colour = "z-score") +
  scale_color_manual(values = c("red", "orange", "darkgreen", "orange", "red")) +
  scale_x_discrete(limits = 24:61) + scale_y_continuous(breaks = seq(75, 125, 5)) +
  theme_gray()


################################################################################
#
# Extract hcfa data - p
#
################################################################################

get_hcfa_pchart <- function(baseurl = "http://www.who.int/childgrowth/standards/",
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
    p_data <- read.table(file = paste(baseurl, "second_set/hcfa_", i, "_p_exp.txt", sep = ""),
                         header = TRUE)
    #
    #
    #
    p_data <- data.frame("sex" = i, "month" = p_data$Age/30.4375, p_data)
    #
    #
    #
    temp <- data.frame(rbind(temp, p_data))
  }
  #
  #
  #
  names(temp) <- c("sex", "month", "day", "l", "m", "s",
                   "0.10th", "1st", "3rd", "5th", "10th", "15th", "25th", "50th",
                   "75th", "85th", "90th", "95th", "97th", "99th", "99.9th")
  #
  #
  #
  hcfa_chart <- tidyr::gather(data = temp, key = "p_type", value = "p_value", names(temp)[7]:names(temp)[ncol(temp)])
  names(hcfa_chart) <- c("sex", "month", "day", "l", "m", "s", "p_type", "p_value")
  hcfa_chart$p_type <- factor(hcfa_chart$p_type,
                              levels = c("0.10th", "1st", "3rd", "5th", "10th",
                                         "15th", "25th", "50th", "75th", "85th",
                                         "90th", "95th", "97th", "99th", "99.9th"))
  #
  #
  #
  return(hcfa_chart)
}


#
#
#
xx <- get_hcfa_pchart()


################################################################################
#
#
#
################################################################################


labels <- c("3rd", "15th", "50th", "85th", "97th")
p_xloc   <- rep(24, 5)
p_yloc   <- c(81, 84, 87, 90, 93)

p_labels <- data.frame(labels, p_xloc, p_yloc)

p <- ggplot(xx[xx$sex == "boys" & xx$month < 24 & xx$p_type %in% c("3rd", "15th", "50th", "85th", "97th"), ],
            aes(x = month, y = p_value, group = p_type))

p + geom_line(size = 1, aes(colour = p_type)) +
  labs(x = "Month", y = "Length/Height (cms)", colour = "percentile") +
  scale_color_manual(values = c("red", "orange", "darkgreen", "orange", "red")) +
  scale_x_discrete(limits = 0:24) + scale_y_continuous(breaks = seq(45, 100, 5)) +
  theme_gray()

################################################################################
#
#
#
################################################################################

p <- ggplot(xx[xx$sex == "girls" & xx$month < 24 & xx$p_type %in% c("3rd", "15th", "50th", "85th", "97th"), ],
            aes(x = month, y = p_value, group = p_type))

p + geom_line(size = 1, aes(colour = p_type)) +
  labs(x = "Month", y = "Length/Height (cms)", colour = "percentile") +
  scale_color_manual(values = c("red", "orange", "darkgreen", "orange", "red")) +
  scale_x_discrete(limits = 0:24) + scale_y_continuous(breaks = seq(45, 100, 5)) +
  theme_gray()


################################################################################
#
#
#
################################################################################

p <- ggplot(xx[xx$sex == "boys" & xx$month >= 24 & xx$p_type %in% c("3rd", "15th", "50th", "85th", "97th"), ],
            aes(x = month, y = p_value, group = p_type))

p + geom_line(size = 1, aes(colour = p_type)) +
  labs(x = "Month", y = "Length/Height (cms)", colour = "percentile") +
  scale_color_manual(values = c("red", "orange", "darkgreen", "orange", "red")) +
  scale_x_discrete(limits = 24:61) + scale_y_continuous(breaks = seq(75, 125, 5)) +
  theme_gray()


################################################################################
#
#
#
################################################################################

p <- ggplot(xx[xx$sex == "girls" & xx$month >= 24 & xx$p_type %in% c("3rd", "15th", "50th", "85th", "97th"), ],
            aes(x = month, y = p_value, group = p_type))

p + geom_line(size = 1, aes(colour = p_type)) +
  labs(x = "Month", y = "Length/Height (cms)", colour = "percentile") +
  scale_color_manual(values = c("red", "orange", "darkgreen", "orange", "red")) +
  scale_x_discrete(limits = 24:61) + scale_y_continuous(breaks = seq(75, 125, 5)) +
  theme_gray()






