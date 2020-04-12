dataset1 <- read.delim("data-raw/Random_LabValuesInfo_2020.tsv")
dataset2 <- read.delim("data-raw/Random_PatientLevelInfo_2020.tsv")

usethis::use_data(dataset1)
usethis::use_data(dataset2)
