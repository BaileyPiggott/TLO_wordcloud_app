
source("set_up.R") #loads libraries and creates data frames for each discipline's scores


shinyServer(function(input, output) {
  
  output$wordcloud <- renderPlot({
    
    #if else statements for category
    if(input$category == 1){ #problem solving
      data = om
    }
    else if(input$category == 2){
      data = lb
    }
    else if(input$category == 3){
      data = se
    }
    else if(input$category == 4){
      data = tr
    }
    else if(input$category == 5){
      data = org
    }
    
    
    #if else statements for level   
    if(input$level == 1){
      data = data %>% filter(Average > 0 & Average <= 1)
    }
    else if(input$level == 2){
      data = data %>% filter(Average > 1 & Average <= 2)
    } 
    else if(input$level == 3){
      data = data %>% filter(Average > 2 & Average <= 3)
    }    
    else if(input$ level == 4){
      data = data %>% filter(Average > 3 & Average <= 4)
    }  
    else if(input$discipline == 7){
      data = data %>% filter(V3 == "MINE")
    } 
    else if(input$discipline == 8){
      data = data %>% filter(V3 == "GEOE")
    } 
    else if(input$discipline == 9){
      data = data %>% filter(V3 == "PHYS" | V3 == "ENPHE")
    } 
    else{ 
      data = data %>% filter(V3 == "MTHE")
    }    
    # end of if else statements
    
    
    
    #choose file to analyse and convert to corpus
    # choose discipline_level (exemplars for all data)
    exemplars <- data[, -1] #remove year and average)
    exemplars <-exemplars %>% apply(1,paste,collapse=" ") %>% t() %>% apply(1,paste,collapse=" ") #convert to string
    ex_corpus <- Corpus(VectorSource(exemplars)) 
    
    #view text: ex_corpus[[1]]$content
    
    # clean up text
    ex_corpus <- ex_corpus %>% 
      tm_map(stripWhitespace) %>% # take out white space
      tm_map(tolower) %>% # change everything to lower case
      tm_map(removeWords, stopwords("english")) %>% #remove common english words
      tm_map(removeWords, c("na", "will", "can", "must", "also", "used", "using", "cec")) %>%
      tm_map(removeNumbers) %>% 
      tm_map(stemDocument) %>% # reduce words to their stem
      tm_map(removePunctuation) %>% 
      tm_map(PlainTextDocument) # convert back to a text document for plotting
    
    
    #create word cloud:
    wordcloud(ex_corpus,
              scale=c(5,0.8), #size of words
              max.words=50,  
              min.freq = 2,
              # random.order=FALSE,
              rot.per=0.10, 
              use.r.layout=TRUE, 
              colors=brewer.pal(8, "Dark2"))
    
  }) # end render plot
  
  
  
})#end shiny server
