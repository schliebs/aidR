#!!!! https://tex.stackexchange.com/questions/125274/error-font-ts1-zi4r-at-540-not-found !!!
library(tidyverse)

devtools::document()
devtools::build()

############

# pdf vignette bauen
pack <- "aidR"
path <- "" #getwd()#find.package(pack)#
file.remove("aidR.pdf")
system(paste(shQuote(file.path(R.home("bin"), "R")),"CMD", "Rd2pdf", shQuote(path)))


source("helpers/update_yaml.R")
update_yaml("aidR", overwrite = T)

pkgdown::build_site()




