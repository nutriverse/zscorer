
anthro1 <- read.csv("data-raw/dist.ex01.csv")
devtools::use_data(anthro1, overwrite = TRUE)

anthro2 <- read.csv("data-raw/dp.ex01.csv")
devtools::use_data(anthro2, overwrite = TRUE)
