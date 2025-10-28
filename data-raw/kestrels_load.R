bychick <- read.csv("~/PANJkestrels/data-raw/bychick.csv")
bybox <- read.csv("~/PANJkestrels/data-raw/bybox.csv")

usethis::use_data(bychick)
usethis::use_data(bybox)
