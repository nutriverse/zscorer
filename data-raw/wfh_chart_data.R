################################################################################
#
# Extract wfh data - zscore
#
################################################################################

get_wfh_zchart <- function(baseurl = "http://www.who.int/childgrowth/standards/",
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
    z_data_2 <- read.table(file = paste(baseurl, "wfl_", i, "_z_exp.txt", sep = ""),
                           header = TRUE)
    z_data_5 <- read.table(file = paste(baseurl, "wfh_", i, "_z_exp.txt", sep = ""),
                           header = TRUE)
    #
    #
    #
    z_data_2 <- data.frame("sex" = i, z_data_2)
    names(z_data_2) <- c("sex", "lh", "-4SD", "-3SD", "-2SD", "-1SD", "0", "1SD", "2SD", "3SD", "4SD")

    z_data_5 <- data.frame("sex" = i, z_data_5)
    names(z_data_5) <- c("sex", "lh", "-4SD", "-3SD", "-2SD", "-1SD", "0", "1SD", "2SD", "3SD", "4SD")

    z_data   <- data.frame(rbind(z_data_2, z_data_5))

    temp <- data.frame(rbind(temp, z_data))
  }
  #
  #
  #
  names(temp) <- c("sex", "lh", "-4SD", "-3SD", "-2SD", "-1SD", "0", "1SD", "2SD", "3SD", "4SD")
  #
  #
  #
  wfh_chart <- tidyr::gather(data = temp, key = "sd_type", value = "sd_value", names(temp)[3]:names(temp)[ncol(temp)])
  names(wfh_chart) <- c("sex", "lh", "sd_type", "sd_value")
  wfh_chart$sd_type <- factor(wfh_chart$sd_type, levels = c("4SD", "3SD", "2SD", "1SD", "0", "-1SD", "-2SD", "-3SD", "-4SD"))
  #
  #
  #
  return(wfh_chart)
}


#
#
#
xx <- get_wfh_zchart()


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
# Extract wfa data - p
#
################################################################################

get_wfh_pchart <- function(baseurl = "http://www.who.int/childgrowth/standards/",
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
    p_data_2 <- read.table(file = paste(baseurl, "wfl_", i, "_p_exp.txt", sep = ""),
                           header = TRUE)
    p_data_5 <- read.table(file = paste(baseurl, "wfh_", i, "_p_exp.txt", sep = ""),
                           header = TRUE)
    #
    #
    #
    p_data_2 <- data.frame("sex" = i, p_data_2)
    names(p_data_2) <- c("sex", "lh", "l", "m", "s",
                         "0.10th", "1st", "3rd", "5th", "10th", "15th", "25th", "50th",
                         "75th", "85th", "90th", "95th", "97th", "99th", "99.9th")
    p_data_5 <- data.frame("sex" = i, p_data_5)
    names(p_data_5) <- c("sex", "lh", "l", "m", "s",
                         "0.10th", "1st", "3rd", "5th", "10th", "15th", "25th", "50th",
                         "75th", "85th", "90th", "95th", "97th", "99th", "99.9th")
    #
    #
    #
    p_data <- data.frame(rbind(p_data_2, p_data_5))

    temp <- data.frame(rbind(temp, p_data))
  }
  #
  #
  #
  names(temp) <- c("sex", "lh", "l", "m", "s",
                   "0.10th", "1st", "3rd", "5th", "10th", "15th", "25th", "50th",
                   "75th", "85th", "90th", "95th", "97th", "99th", "99.9th")
  #
  #
  #
  wfh_chart <- tidyr::gather(data = temp, key = "p_type", value = "p_value", names(temp)[6]:names(temp)[ncol(temp)])
  names(wfh_chart) <- c("sex", "lh", "l", "m", "s", "p_type", "p_value")
  wfh_chart$p_type <- factor(wfh_chart$p_type,
                             levels = c("0.10th", "1st", "3rd", "5th", "10th",
                                        "15th", "25th", "50th", "75th", "85th",
                                        "90th", "95th", "97th", "99th", "99.9th"))
  #
  #
  #
  return(wfh_chart)
}


#
#
#
xx <- get_wfh_pchart()


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






