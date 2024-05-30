####################### Intro Page #######################

output$intro_page_ui <-  renderUI({

  div(
	     fluidRow(
            h2("Background"),
	           p("THIS IS PLACEHOLDER TEXT. Add some text in this section explaining the long waits data and the charts/filters"), 
	           p(strong("This is some bold text"))
	      ) #fluidrow
   ) # div
}) # renderUI
