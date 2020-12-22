## utility functions

search <- function(params){
  temp <- POST("https://efts.sec.gov/LATEST/search-index", 
               body = POST_body(params), 
               encode = "json") %>% 
    content('text', encoding = "UTF-8") %>% 
    fromJSON()
  n <- ceiling(temp$hits$total$value %>% as.numeric() / 100)
  table <- pblapply(1:n, function(x){
    tparams <- params
    tparams[['page']] <- x %>% as.character()
    tparams[['from']] <- ((x - 1)*100) %>% as.character()
    temp <- POST("https://efts.sec.gov/LATEST/search-index", 
                 body = POST_body(tparams), 
                 encode = "json") %>% 
      content('text', encoding = "UTF-8") %>% 
      fromJSON()
    result <- temp$hits$hits$`_source`
    result$link <- paste0("https://www.sec.gov/Archives/edgar/data/", 
                          result$ciks %>% clean() %>% as.numeric(), "/",
                          result$adsh %>% clean() %>% 
                            gsub(pattern = "-", replacement = ""), "/",
                          result$adsh %>% clean(), ".txt")
    result$file <- paste0(result$adsh %>% clean(), ".txt")
    result %>% return()
  }) %>% bind_rows()
  return <- table[, c(5, 10, 11, 15, 2, 8, 14, 9, 19, 20)]
  return[] <- return %>% lapply(clean)
  return[!duplicated(return), ] %>% return()
}

POST_body <- function(params){
  if(!('page' %in% names(params))){params[['page']] <- '1'}
  if(!('from' %in% names(params))){params[['from']] <- '0'}
  list('q'=params[['key']],
       'page'=params[['page']],
       'from'=params[['from']],
       'startdt'=params[['start_date']],
       'enddt'=params[['end_date']]) %>% return()
}

clean <- function(x){
  lapply(x, first) %>% unlist() %>% return()
}
