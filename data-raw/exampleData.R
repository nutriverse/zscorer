
anthro1 <- read.csv("data-raw/dist.ex01.csv")
devtools::use_data(anthro1, overwrite = TRUE)

anthro2 <- read.csv("data-raw/dp.ex01.csv")
devtools::use_data(anthro2, overwrite = TRUE)

anthro3 <- read.csv("data-raw/z.ex01.csv")
devtools::use_data(anthro3, overwrite = TRUE)
