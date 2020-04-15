# ------------------ Dependencies -------------------------

library(shiny)
library(dplyr)

# ------------------------- UI ---------------------
ui <- navbarPage( 
    title = "Corona Dashboard",
    
    # ------------------ Timeline ----------------
    
    tabPanel("Timeline", fluidPage(
        fluidRow(
            column(4, uiOutput("timeline_uiOutput_country")),
            column(4, uiOutput("timeline_uiOutput_metrics")),
            column(2, uiOutput("timeline_uiOutput_start_date")),
            column(2, uiOutput("timeline_uiOutput_end_date"))
        ),
        fluidRow(
            column(4, DT:: dataTableOutput("timeline_table_leaderboard")),
            column(8, plotOutput("timeline_plot_distribution")),
            
        )
    )
    
    
    ))