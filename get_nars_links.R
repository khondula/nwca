library(rvest)

webpage <- read_html("https://www.epa.gov/national-aquatic-resource-surveys/data-national-aquatic-resource-surveys")

# tbls <- html_nodes(webpage, "table")

tbls_ls <- webpage %>%
  html_nodes("table") %>%
  .[1] %>%
  html_table(fill = TRUE)

tbl <- tbls_ls[[1]]
