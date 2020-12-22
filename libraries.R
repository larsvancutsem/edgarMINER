## install required packages if necessary
packages <- c("dplyr", "pbapply", "stringr", "httr", "jsonlite")
if (length(setdiff(packages, rownames(installed.packages()))) > 0) {
  install.packages(setdiff(packages, rownames(installed.packages())))  
}
lapply(packages, require, character.only = TRUE)

## specify download directory for filings  
ddir <- "/data"
dir.create(file.path(getwd(), ddir), showWarnings = FALSE)
