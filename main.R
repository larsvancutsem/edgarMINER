################################################################################
#              __                 __  ________   ____________ 
#    ___  ____/ /___ _____ ______/  |/  /  _/ | / / ____/ __ \
#   / _ \/ __  / __ `/ __ `/ ___/ /|_/ // //  |/ / __/ / /_/ /
#  /  __/ /_/ / /_/ / /_/ / /  / /  / // // /|  / /___/ _, _/ 
#  \___/\__,_/\__, /\__,_/_/  /_/  /_/___/_/ |_/_____/_/ |_|  
#            /____/                                           
#                                                                Lars Van Cutsem
################################################################################


## set directory to file directory
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))


## source libraries
source("libraries.R")


## source functions
source("util.R")


## quick search [boolean AND OR NOT; wildcards*; "full match"]
params <- list('key' = '"debt covenant"',
               'start_date' = '2018-01-01',
               'end_date' = '2020-12-31')
table <- search(params)


## only financial firms? (sic 6000:6999)
subset <- table %>% filter(sics %in% as.character(6000:6999))
