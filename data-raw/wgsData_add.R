################################################################################
#
# lhfa tables
#
################################################################################

get_lhfa_tables <- function(baseurl = "http://www.who.int/childgrowth/standards/",
                            gender = c("boys", "girls"),
                            age = c("0_2", "2_5")) {
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
    for(j in age) {
      #
      #
      #
      url <- paste(baseurl, "tab_lhfa_", i, "_p_", j, ".txt", sep = "")
      #
      #
      #
      lms <- read.table(file = url, header = TRUE)

      lms <- data.frame(indicator = "hfa",
                        sex = ifelse(i == "boys", 1, 2),
                        lms[ , 1:4])

      names(lms) <- c("indicator", "sex", "given", "l", "m", "s")

      temp <- data.frame(rbind(temp, lms))

      if(j == "0_2") {
        #
        # Remove row for 24 months
        #
        temp <- temp[-nrow(temp), ]
      }
    }
  }
  #
  #
  #
  return(temp)
}


################################################################################
#
# wfa tables
#
################################################################################

get_wfa_tables <- function(baseurl = "http://www.who.int/childgrowth/standards/",
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
    url <- paste(baseurl, "tab_wfa_", i, "_p_0_5.txt", sep = "")
    #
    #
    #
    lms <- read.table(file = url, header = TRUE)

    lms <- data.frame(indicator = "wfa",
                      sex = ifelse(i == "boys", 1, 2),
                      lms[ , 1:4])

    names(lms) <- c("indicator", "sex", "given", "l", "m", "s")

    temp <- data.frame(rbind(temp, lms))
  }
  #
  #
  #
  return(temp)
}


################################################################################
#
# wfh tables
#
################################################################################

get_wfh_tables <- function(baseurl = "http://www.who.int/childgrowth/standards/",
                           gender = c("boys", "girls"),
                           age = c("0_2", "2_5")) {
  #
  #
  #
  wfhDF <- NULL
  #
  #
  #
  for(i in gender) {
    #
    #
    #
    temp <- NULL
    #
    #
    #
    for(j in age) {
      #
      #
      #
      url <- ifelse(j == "0_2",
                    paste(baseurl, "tab_wfl_", i, "_p_", j, ".txt", sep = ""),
                    paste(baseurl, "tab_wfh_", i, "_p_", j, ".txt", sep = ""))
      #
      #
      #
      lms <- read.table(file = url, header = TRUE)

      lms <- data.frame(indicator = "wfh",
                        sex = ifelse(i == "boys", 1, 2),
                        lms[ , 1:4])

      names(lms) <- c("indicator", "sex", "given", "l", "m", "s")

      temp <- data.frame(rbind(temp, lms))
    }
    for(k in 1:(nrow(temp) - 1)) {

      tempDF <- data.frame(matrix(data = NA, nrow = 5, ncol = 6))
      names(tempDF) <- c("indicator", "sex", "given", "l", "m", "s")

      for(l in 1:5) {
        tempDF[l, 1] <- as.character(temp[k, 1])
        tempDF[l, 2] <- temp[k, 2]
        tempDF[l, 3] <- temp[k, 3] + 0.1 * (l - 1)
        tempDF[l, 4] <- temp[k, 4]
        tempDF[l, 5] <- temp[k, 5] + ((temp[k + 1, 5] - temp[k, 5]) / 5) * (l - 1)
        tempDF[l, 6] <- temp[k, 6] + ((temp[k + 1, 6] - temp[k, 6]) / 5) * (l - 1)
      }
      wfhDF <- data.frame(rbind(wfhDF, tempDF))
    }
    wfhDF <- data.frame(rbind(wfhDF, temp[nrow(temp), ]))
  }
  row.names(wfhDF) <- 1:nrow(wfhDF)
  #
  #
  #
  return(wfhDF)
}


################################################################################
#
# bfa tables
#
################################################################################

get_bfa_tables <- function(baseurl = "http://www.who.int/childgrowth/standards/",
                           gender = c("boys", "girls"),
                           age = c("0_2", "2_5")) {
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
    for(j in age) {
      #
      #
      #
      url <- paste(baseurl, "tab_bmi_", i, "_p_", j, ".txt", sep = "")
      #
      #
      #
      lms <- read.table(file = url, header = TRUE)

      lms <- data.frame(indicator = "bfa",
                        sex = ifelse(i == "boys", 1, 2),
                        lms[ , 1:4])

      names(lms) <- c("indicator", "sex", "given", "l", "m", "s")

      temp <- data.frame(rbind(temp, lms))

      if(j == "0_2") {
        #
        # Remove row for 24 months
        #
        temp <- temp[-nrow(temp), ]
      }
    }
  }
  #
  #
  #
  return(temp)
}


################################################################################
#
# hcfa tables
#
################################################################################

get_hcfa_tables <- function(baseurl = "http://www.who.int/childgrowth/standards/",
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
    url <- paste(baseurl, "second_set/tab_hcfa_", i, "_p_0_5.txt", sep = "")
    #
    #
    #
    lms <- read.table(file = url, header = TRUE)

    lms <- data.frame(indicator = "hcfa",
                      sex = ifelse(i == "boys", 1, 2),
                      lms[ , 1:4])

    names(lms) <- c("indicator", "sex", "given", "l", "m", "s")

    temp <- data.frame(rbind(temp, lms))
  }
  #
  #
  #
  return(temp)
}


################################################################################
#
# acfa tables
#
################################################################################

get_acfa_tables <- function(baseurl = "http://www.who.int/childgrowth/standards/",
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
    url <- paste(baseurl, "second_set/tab_acfa_", i, "_p_3_5.txt", sep = "")
    #
    #
    #
    lms <- read.table(file = url, header = TRUE)

    lms <- data.frame(indicator = "acfa",
                      sex = ifelse(i == "boys", 1, 2),
                      lms[ , 1:4])

    names(lms) <- c("indicator", "sex", "given", "l", "m", "s")

    temp <- data.frame(rbind(temp, lms))
  }
  #
  #
  #
  return(temp)
}


################################################################################
#
# ssfa tables
#
################################################################################

get_ssfa_tables <- function(baseurl = "http://www.who.int/childgrowth/standards/",
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
    url <- paste(baseurl, "second_set/tab_ssfa_", i, "_p_3_5.txt", sep = "")
    #
    #
    #
    lms <- read.table(file = url, header = TRUE)

    lms <- data.frame(indicator = "ssfa",
                      sex = ifelse(i == "boys", 1, 2),
                      lms[ , 1:4])

    names(lms) <- c("indicator", "sex", "given", "l", "m", "s")

    temp <- data.frame(rbind(temp, lms))
  }
  #
  #
  #
  return(temp)
}


################################################################################
#
# tsfa tables
#
################################################################################

get_tsfa_tables <- function(baseurl = "http://www.who.int/childgrowth/standards/",
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
    url <- paste(baseurl, "second_set/tab_tsfa_", i, "_p_3_5.txt", sep = "")
    #
    #
    #
    lms <- read.table(file = url, header = TRUE)

    lms <- data.frame(indicator = "tsfa",
                      sex = ifelse(i == "boys", 1, 2),
                      lms[ , 1:4])

    names(lms) <- c("indicator", "sex", "given", "l", "m", "s")

    temp <- data.frame(rbind(temp, lms))
  }
  #
  #
  #
  return(temp)
}


################################################################################
#
# create all tables
#
################################################################################


create_who_tables <- function(baseurl = "http://www.who.int/childgrowth/standards/",
                              index = c("hfa", "wfa", "wfh", "bfa",
                                        "acfa", "hcfa", "ssfa", "tsfa")) {
  #
  #
  #
  who_tables <- data.frame(rbind(get_lhfa_tables(), get_wfa_tables(),
                                 get_wfh_tables(), get_bfa_tables(),
                                 get_acfa_tables(), get_hcfa_tables(),
                                 get_ssfa_tables(), get_tsfa_tables()))
  #
  #
  #
  if(length(index) == 8) {
    #
    #
    #
    return(who_tables)
  }
  #
  #
  #
  return(who_tables[who_tables$indicator %in% index, ])
}


################################################################################
#
# Create tables for bfa, acfa, hcfa, ssfa, tsfa
#
################################################################################

wgsData <- data.frame(rbind(wgsData,
                            create_who_tables(index = c("bfa", "acfa", "hcfa",
                                                        "ssfa", "tsfa"))))

devtools::use_data(wgsData, overwrite = TRUE)
