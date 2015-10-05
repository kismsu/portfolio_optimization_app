snp_data <- fread("snp_data.csv", verbose = FALSE) %>%
    tbl_df()
my_portfolio <- data_frame(
    stock_name = c("AAPL", "GOOG", "SBUX", "NKE"),
    volume     = c(1000, 1000, 1000, 1000)
)

function(input, output) { 
    my_portfolio <- reactiveValues(data = data_frame(
        ticker = c("AAPL", "GOOG", "SBUX", "NKE"),
        volume = c(1000, 1000, 1000, 1000)
    ))
    
    value_portfolio <- function(portfolio_data) {
        snp_data %>%
            filter(
                Date == max(Date)
            ) %>%
            right_join(portfolio_data, by = c("Ticker" = "ticker")) %>%
            mutate(
                value = Close * volume
            ) %>%
            select(
                Name, volume, value 
            )
    }
    output$portfolio_tbl <- DT::renderDataTable({
        my_portfolio$data %>%
            value_portfolio() %>%
            DT::datatable(rownames = FALSE, options = list(searching = FALSE),
                      colnames = c("Stock", "Volume", "Value")
                      ) %>%
            formatCurrency("value") 
    })
}