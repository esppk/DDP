library(shiny)
library(ggplot2)
library(dplyr)
server <- function(input, output){
    
    mts <- reactive({
        mtcars %>% mutate(cyl = factor(cyl),
                          vs = factor(vs),
                          am = factor(am),
                          gear = factor(gear),
                          carb = factor(carb))
    })


    output$plot <- renderPlot({
        
        type <- switch(input$type,
                       point = geom_point,
                       hex = geom_hex)
        

        ggplot(mts(), aes_string(input$x, input$y, col = input$group, fill = input$group)) + type(alpha = 0.8) +
            labs(x = input$xlab, y = input$ylab) 
     
        })
    
}


