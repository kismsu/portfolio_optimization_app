library(xts)
library(Quandl)
library(readr)
library(dplyr)
library(tidyr)

snp_list <- read_csv("data/SP500.csv")

Quandl.api_key("tLso1HxzHrM2pnczA4Zx")

raw_data <- rbindlist(lapply(snp_list$Code, function(x) {
    tryCatch({
        result <- Quandl(x, type = "raw", column_index = 4)
        setDT(result)
        result[, contract_name := x]
    }, error = function(e) {
        cat(paste(x, e, "\n"))
        return(NULL)
    })
}))

setkey(raw_data, contract_name)

setDT(snp_list)

setnames(snp_list, "Code", "contract_name")
setkey(snp_list, contract_name)

full_data <- merge(snp_list, raw_data)

write.csv(full_data, file = "snp_data.csv", row.names = F)


