##########################################################
# AHP-Long-Waits Shiny Dashboard
# Original author(s): Stewart Wilson
# Original date: 2024-07-10
# Written/run on RStudio server 2022.7.2.576.12 and R 4.1.2
# Created as part of my University course.
##########################################################


# Get packages
source("setup.R")

# UI
ui <- fluidPage(
  lang = "en",
  tagList(
    tags$style("@import url(https://use.fontawesome.com/releases/v6.1.2/css/all.css);"),
    navbarPage(
      id = "intabset",
      title = div(tags$a(img(src = "phs-logo.png", height = 40, alt = "Go to Public Health Scotland (external site)"),
                         href = "https://www.publichealthscotland.scot/",
                         target = "_blank"
      ),
      style = "position: relative; top: -5px;"),
      windowTitle = "AHP Long Waits",
      header = tags$head(includeCSS("www/styles.css"),
                         includeScript("www/javascript.js"),
                         tags$link(rel = "shortcut icon", href = "favicon_phs.ico")
      ),
      
      ##############################################.
      # INTRO PAGE ----
      ##############################################.
      tabPanel(title = "Introduction",
               icon = icon_no_warning_fn("book-open"),
               value = "intro",
               uiOutput("intro_page_ui")
               
      ), # tabpanel
      ##############################################.
      # PAGE 1 ----
      ##############################################.
      tabPanel(title = "Breakdown",
               # Look at https://fontawesome.com/search?m=free for icons
               icon = icon_no_warning_fn("chart-line"),
               value = "intro",
               uiOutput("page_1_ui"),
               
               
      ) # tabpanel
    ) # navbar
  ) # taglist
) # ui fluidpage

### END OF SCRIPT ###