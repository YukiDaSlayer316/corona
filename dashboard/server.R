# ------------------ Dependencies -------------------------

library(shiny)
library(dplyr)
library(ggplot2)

# ------------------------ Lists -------------------------

list_countries <- levels(world$Country)
list_total_metrics <- c('confirmed', 'deaths', 'recovered')
list_daily_metrics <- c('total_confirmed', 'total_deaths', 'total_recovered')
list_all_metrics <- list(Total=list_total_metrics, 
                         Daily = list_daily_metrics)

list_dates <- world %>% distinct(Date)


today_date <- "2020-04-10"

# ------------------------- Server ---------------------

server <- function(input, output, session) {
    
    # ---------------- Timeline ------------------------
    
    output$timeline_uiOutput_country <- renderUI({
        selectInput("timeline_select_country", label = "Select a Country",
                    choices = list_countries)
    })
    
    country_selected <- reactive({
        input$timeline_select_country
    })
    
    output$timeline_uiOutput_metrics <- renderUI({
        selectInput("timeline_select_metric", label = "Select a Metric",
                    choices = list_total_metrics)
    })
    
    metric_selected <- reactive({
        input$timeline_select_metric
    })
    
    output$timeline_uiOutput_start_date <- renderUI({
        selectInput("timeline_select_start_date", label = "Select a date",
                    choices = list_dates)
    })
    
    output$timeline_table_leaderboard <- DT::renderDataTable({
        sub <-  world %>%
            filter(Date==today_date) %>%
            arrange(desc(deaths)) %>%
            select(Country, metric_selected())
        
        DT::datatable(sub[1:10,],
                      options = list(searching = FALSE, 
                                     paging = FALSE
                                     # pageLength = 10,
                                      ), rownames = FALSE)
    })
    
    output$timeline_plot_distribution <- renderPlot({
        # world %>%
        #     filter(Country=='Canada') %>%
        #     ggplot(aes(Date))+
        #     geom_bar(aes(confirmed))
    })
    
    
    
    
}