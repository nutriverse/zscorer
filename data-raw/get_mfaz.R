library(pdftools)


xx <- pdf_text("data-raw/mfaz.pdf")

xx1 <- stringr::str_split(string = xx[[1]], pattern = "\n")
xx1 <- xx1[[1]][4:61]

xx2 <- stringr::str_split(string = xx[[2]], pattern = "\n")
xx2 <- xx2[[1]][3:61]

xx3 <- stringr::str_split(string = xx[[3]], pattern = "\n")
xx3 <- xx3[[1]][3:54]

xx <- c(xx1, xx2, xx3)

xxx <- unlist(stringr::str_split(string = xx, pattern = "      |   :  |     |    |   |  | "))
xxx <- xxx[xxx != ""]

xxx <- matrix(data = as.numeric(xxx), ncol = 13, byrow = TRUE)

sex <- 1
xxx <- data.frame(sex, xxx)

xx <- pdf_text("data-raw/mfaz.pdf")

yy1 <- stringr::str_split(string = xx[[4]], pattern = "\n")
yy1 <- yy1[[1]][4:61]

yy2 <- stringr::str_split(string = xx[[5]], pattern = "\n")
yy2 <- yy2[[1]][3:61]

yy3 <- stringr::str_split(string = xx[[6]], pattern = "\n")
yy3 <- yy3[[1]][3:54]

yy <- c(yy1, yy2, yy3)

yyy <- unlist(stringr::str_split(string = yy, pattern = "      |    :   |     |    |   |  | "))
yyy <- yyy[yyy != ""]

yyy <- matrix(data = as.numeric(yyy), ncol = 13, byrow = TRUE)

sex <- 2
yyy <- data.frame(sex, yyy)


mfaz <- data.frame(rbind(xxx, yyy))
names(mfaz) <- c("sex", "year", "month", "month", "l", "m", "s", "-3", "-2", "-1", "0", "1", "2", "3")

mfaz <- mfaz[ , c(1, 4:7)]

days <- mfaz[ , 2] * (365/12)

mfaz <- data.frame(mfaz[ , 1:2], days, mfaz[ , 3:5])


write.csv(mfaz, "data-raw/mfaz.csv", row.names = FALSE)




