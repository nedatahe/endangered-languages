#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  observe({
    filtered_df <- UN_UNESCO
    
    if (input$country != 'All') {
      filtered_df <- filter(filtered_df, Country == input$country)
    }
    if (input$language != 'All') {
      filtered_df <- filter(filtered_df, english_name == input$language)
    }
    if (input$iso != 'All') {
      filtered_df <- filter(filtered_df, `ISO639-3_codes` == input$iso)
    }
    #multi select makes a vector: different syntax
    if (!is.null(input$endangerment) &
        !any(input$endangerment %in% 'All')) {
      filtered_df <-
        filter(filtered_df,
               endangerment_degree %in% input$endangerment)
    }
    
    if (!is.na(input$min_speakers)  |
        !is.na(input$max_speakers)) {
      if (!is.na(input$min_speakers) & !is.na(input$max_speakers)) {
        filtered_df <-
          filter(
            filtered_df,
            between(
              number_of_speakers,
              input$min_speakers,
              input$max_speakers
            )
          )
      }
      if (is.na(input$min_speakers)) {
        filtered_df <-
          filter(filtered_df,
                 number_of_speakers <= input$max_speakers)
      }
      if (is.na(input$max_speakers)) {
        filtered_df <-
          filter(filtered_df,
                 number_of_speakers >= input$min_speakers)
      }
    }
    
    output$PopNumber <- renderText(
      {
        total_speakers <-
          filtered_df%>% 
          summarize(language_count = length(unique(english_name)), 
                    speakers_count = sum(number_of_speakers, na.rm = T))
        
        str_interp('Total endangered languages: ${total_speakers$language_count}. 
                   Total speakers: ${format(total_speakers$speakers_count, big.mark=",", scientific=FALSE, trim=TRUE)}')
        
      }
    )
    
    
    output$WorldMap <- renderLeaflet({
      
      
      popup <-
        paste(
          "<b>English name:</b>",
          filtered_df$english_name,
          "<br>",
          "<b>French name:</b>",
          filtered_df$french_name,
          "<br>",
          "<b>Spanish name:</b>",
          filtered_df$spanish_name,
          "<br>",
          
          "<b>Alternate name:</b>",
          filtered_df$alternate_names,
          "<br>",
          "<b>Family:</b>",
          filtered_df$family,
          "<br>",
          "<b>ISO639-3 code:</b>",
          filtered_df$`ISO639-3_codes`,
          "<br>",
          "<b>Endangerment degree:</b>",
          filtered_df$endangerment_degree,
          "<br>",
          "<b>Number of speakers:</b>",
          filtered_df$number_of_speakers,
          "<br>",
          "<b>Country:</b>",
          filtered_df$Country,
          "<br>",
          
          "<b>Specific location(s):</b>",
          filtered_df$location_description,
          "<br>"
        )
      
      pal <- colorFactor(palette = c('khaki4', 'yellow', 'orange', 'red', 'black'), 
                         levels = c("Vulnerable",
                                    "Definitely endangered",
                                    "Severely endangered", 
                                    "Critically endangered",
                                    "Extinct"))
      
      
      
      leaflet() %>%
        addProviderTiles(provider = "Esri", options = providerTileOptions(maxZoom = 6)) %>%
        
        addCircleMarkers(
          data = filtered_df,
          radius = log10(filtered_df$number_of_speakers),
          opacity = .6,
          color = pal(filtered_df$endangerment_degree),
          lng = ~ Longitude,
          lat = ~ Latitude,
          popup = popup
        ) %>%
        addLegend(
          pal = pal,
          position = 'bottomleft',
          values = factor(filtered_df$endangerment_degree),
          title = 'Endangerment degrees'
        )
      
    })
    
  })
  
  observe({
    output$BarPlot <- renderPlotly({
      
      plot <- UN_UNESCO %>% 
        {if (input$country == 'All') . else filter(., Country == input$country)} %>% 
        group_by(endangerment_degree) %>% 
        count() %>% 
        mutate(Percentage = round(100 *(n/sum(.$n)), digits = 2))%>%
        mutate(Levels = 'Endangerment Degree') %>% 
        arrange(ascending = T) %>% 
        ggplot(aes(x = Levels,
                   y = Percentage, 
                   fill = endangerment_degree,
                   text = sprintf('Count: %s', n))) +
         labs(fill = "Endangerment Degree")+
        geom_col()+
        
        geom_text(aes(label = paste(Percentage, '%')), 
                  position = position_stack(vjust = 0.5), color = 'springgreen4', size = 3)+
        
        
        scale_fill_manual(values = c(
          "Vulnerable" = "khaki4",
          "Critically endangered" = "red",
          "Extinct" = "black", 
          "Severely endangered" = "orange",
          "Definitely endangered" =  "yellow"
        ))+
        theme(axis.title.x=element_blank(),
              axis.text.x=element_blank(),
              axis.ticks.x=element_blank())
      
      ggplotly(plot, tooltip = "text")
    })
  })
  
  
  observe({
    output$ScatterPlot <-
      renderPlotly({
        plot2 <-
          UN_UNESCO %>%
          group_by(Country) %>%
          mutate(language_count = length(unique(english_name))) %>% 
          ggplot(aes_string(y = 'endangered_proportion', 
                            x = input$country_variable, 
                        
                            
                            color = 'Continent'
          )) +
          labs(y = "Countrie's Proportion of Endangered Languages", x = names(choices[which(choices == input$country_variable)])) +
          geom_smooth(method = 'lm', formula = y ~ x, color = "blue", size = .1)+
          geom_point(aes(text = Country), alpha = .5)+
          scale_x_log10(labels = scales::comma)+
          scale_y_continuous(labels = function(x) paste0(x*100, "%"))
        ggplotly(plot2, tooltip = "text")
        
      })
  })
  
})
