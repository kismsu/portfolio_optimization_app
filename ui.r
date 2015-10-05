library(shinydashboard)

dashboardPage(
    dashboardHeader(disable = TRUE),
    dashboardSidebar(disable = TRUE),
    dashboardBody(
        h1("Portfolio optiomisation app"),
        fluidRow(
            box(title = "Current portfolio",
                DT::dataTableOutput('portfolio_tbl')
            ),
            box("Add new investment to your portfolio",
                numericInput("new_volume", label = "Investment in $", 
                             value = 0),
                actionButton("find_button", label = "Find")
            )
        )
    )
)