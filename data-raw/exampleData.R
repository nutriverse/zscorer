anthro1 <- read.csv("data-raw/dist.ex01.csv")
usethis::use_data(anthro1, compress = "xz", overwrite = TRUE)

anthro2 <- read.csv("data-raw/dp.ex01.csv")
usethis::use_data(anthro2, compress = "xz", overwrite = TRUE)

anthro3 <- read.csv("data-raw/z.ex01.csv")
usethis::use_data(anthro3, compress = "xz", overwrite = TRUE)

anthro4 <- read.csv("data-raw/for_Mark.csv")
usethis::use_data(anthro4, compress = "xz", overwrite = TRUE)
