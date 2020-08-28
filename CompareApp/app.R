# Data Incite UI Template
# Uses Shinydashboard as a framework https://rstudio.github.io/shinydashboard/
# Created by Arielle Cerini, Brian Hotopp, Haoyu He, and James Young

library(shiny)
library(shinydashboard)
library(shinyjs)
library(tidyr)
library(ggplot2)
library(shinyWidgets)

#source('~/StudentNetwork/ComputeStats.R', chdir = TRUE)
monday = readRDS("~/ShinyApps/CompareApp/DayNets/monday_net2.rds")
tuesday = readRDS("~/ShinyApps/CompareApp/DayNets/tuesday_net2.rds")
wednesday = readRDS("~/ShinyApps/CompareApp/DayNets/wednesday_net2.rds")
thursday = readRDS("~/ShinyApps/CompareApp/DayNets/thursday_net2.rds")
friday = readRDS("~/ShinyApps/CompareApp/DayNets/friday_net2.rds")

mon_edge_diss <- readRDS(file = "~/ShinyApps/CompareApp/MondayPlots/mon_edge_diss.RDS")
tue_edge_diss <- readRDS(file = "~/ShinyApps/CompareApp/TuesdayPlots/tue_edge_diss.RDS")
wed_edge_diss <- readRDS(file = "~/ShinyApps/CompareApp/WednesdayPlots/wed_edge_diss.RDS")
thur_edge_diss <- readRDS(file = "~/ShinyApps/CompareApp/ThursdayPlots/thur_edge_diss.RDS")
fri_edge_diss <- readRDS(file = "~/ShinyApps/CompareApp/FridayPlots/fri_edge_diss.RDS")

mon_edge_form <- readRDS(file = "~/ShinyApps/CompareApp/MondayPlots/mon_edge_form.RDS")
tue_edge_form <- readRDS(file = "~/ShinyApps/CompareApp/TuesdayPlots/tue_edge_form.RDS")
wed_edge_form <- readRDS(file = "~/ShinyApps/CompareApp/WednesdayPlots/wed_edge_form.RDS")
thur_edge_form <- readRDS(file = "~/ShinyApps/CompareApp/ThursdayPlots/thur_edge_form.RDS")
fri_edge_form <- readRDS(file = "~/ShinyApps/CompareApp/FridayPlots/fri_edge_form.RDS")

mon_degree <- readRDS(file = "~/ShinyApps/CompareApp/MondayPlots/mon_degree.RDS")
tue_degree <- readRDS(file = "~/ShinyApps/CompareApp/TuesdayPlots/tue_degree.RDS")
wed_degree <- readRDS(file = "~/ShinyApps/CompareApp/WednesdayPlots/wed_degree.RDS")
thur_degree <- readRDS(file = "~/ShinyApps/CompareApp/ThursdayPlots/thur_degree.RDS")
fri_degree <- readRDS(file = "~/ShinyApps/CompareApp/FridayPlots/fri_degree.RDS")

mon_tie_dur <- readRDS(file = "~/ShinyApps/CompareApp/MondayPlots/mon_tie_dur.RDS")
tue_tie_dur <- readRDS(file = "~/ShinyApps/CompareApp/TuesdayPlots/tue_tie_dur.RDS")
wed_tie_dur <- readRDS(file = "~/ShinyApps/CompareApp/WednesdayPlots/wed_tie_dur.RDS")
thur_tie_dur <- readRDS(file = "~/ShinyApps/CompareApp/ThursdayPlots/thur_tie_dur.RDS")
fri_tie_dur <- readRDS(file = "~/ShinyApps/CompareApp/FridayPlots/fri_tie_dur.RDS")

mon_reach <- readRDS(file = "~/ShinyApps/CompareApp/MondayPlots/mon_reach.RDS")
tue_reach <- readRDS(file = "~/ShinyApps/CompareApp/TuesdayPlots/tue_reach.RDS")
wed_reach <- readRDS(file = "~/ShinyApps/CompareApp/WednesdayPlots/wed_reach.RDS")
thur_reach <- readRDS(file = "~/ShinyApps/CompareApp/ThursdayPlots/thur_reach.RDS")
fri_reach <- readRDS(file = "~/ShinyApps/CompareApp/FridayPlots/fri_reach.RDS")

mon_cent <- readRDS(file = "~/ShinyApps/CompareApp/MondayPlots/mon_cent.RDS")
tue_cent <- readRDS(file = "~/ShinyApps/CompareApp/TuesdayPlots/tue_cent.RDS")
wed_cent <- readRDS(file = "~/ShinyApps/CompareApp/WednesdayPlots/wed_cent.RDS")
thur_cent <- readRDS(file = "~/ShinyApps/CompareApp/ThursdayPlots/thur_cent.RDS")
fri_cent <- readRDS(file = "~/ShinyApps/CompareApp/FridayPlots/fri_cent.RDS")

mon_vertex_dur <- readRDS(file = "~/ShinyApps/CompareApp/MondayPlots/mon_vertex_dur.RDS")
tue_vertex_dur <- readRDS(file = "~/ShinyApps/CompareApp/TuesdayPlots/tue_vertex_dur.RDS")
wed_vertex_dur <- readRDS(file = "~/ShinyApps/CompareApp/WednesdayPlots/wed_vertex_dur.RDS")
thur_vertex_dur <- readRDS(file = "~/ShinyApps/CompareApp/ThursdayPlots/thur_vertex_dur.RDS")
fri_vertex_dur <- readRDS(file = "~/ShinyApps/CompareApp/FridayPlots/fri_vertex_dur.RDS")

mon_hr <- as.data.frame(mon_degree)
colnames(mon_hr) <- ("degree")
mon_hr <- mon_hr %>%
  filter(degree > 70)

tue_hr <- as.data.frame(tue_degree)
colnames(tue_hr) <- ("degree")
tue_hr <- tue_hr %>%
  filter(degree > 70)

wed_hr <- as.data.frame(wed_degree)
colnames(wed_hr) <- ("degree")
wed_hr <- wed_hr %>%
  filter(degree > 70)

thur_hr <- as.data.frame(thur_degree)
colnames(thur_hr) <- ("degree")
thur_hr <- thur_hr %>%
  filter(degree > 70)

fri_hr <- as.data.frame(fri_degree)
colnames(fri_hr) <- ("degree")
fri_hr <- fri_hr %>%
  filter(degree > 70)

hr <- c(nrow(mon_hr), nrow(tue_hr), nrow(wed_hr), nrow(thur_hr), nrow(fri_hr))


ui <- dashboardPage(skin = "black", title = "COVID BACK-TO-SCHOOL",
                    dashboardHeader(title = tags$div(
                        class = "title-text",
                        tags$div(id = "logo_block", tags$img(src="Rensselaer_round.png", id="header_logo"),
                                 HTML("<p style='display: inline; font-size: 1.2em; vertical-align: middle;'>COVID<b><span style = 'color: #990000;'><span style='padding-left:2px; padding-right: 2px;'>SAFE CAMPUS</span></span></b></p>"))
                    ),
                    
                    titleWidth = "330px"
                    ),
                    dashboardSidebar(
                        width = 320,
                        sidebarMenu(id = "tabs", collapsed = TRUE,
                                    menuItem("About", tabName = "about"),
                                    menuItem("Infection Analysis", tabName = "infection", selected = TRUE),
                                    menuItem("Student Risk", tabName = "risk"),
                                    menuItem("Time Analysis", tabName = "time"),
                                    uiOutput("side_ctrl")
                                    
                        )
                        
                    ),
                    dashboardBody(
                        style = "background-color: #FAFAFA; height: 100%; min-height: 100vh;",
                        shinyjs::useShinyjs(),
                        tabItems(
                            tabItem(tabName="main",
                                    #     h3("Log Scale"),
                                    #     switchInput("logscale", value = FALSE),
                                    #     plotOutput("default"),
                                    #     plotOutput("optimized"),
                                    #     plotOutput("rolling")
                            ),
                            tabItem(tabName = "about",
                                    uiOutput("about_body"),
                                    
                            ),
                            tabItem(tabName = "infection",
                                    fluidRow(
                                      column(6, align = "center", selectInput("paths1", label = ("Day 1"), choices = list("Monday" = '1', "Tuesday" = '2',
                                      "Wednesday" = '3', 'Thursday' = '4', 'Friday' = '5'),selected = '1'),),
                                      column(6, align = "center", selectInput("paths2", label = ("Day 2"), choices = list("Monday" = '1', "Tuesday" = '2',
                                      "Wednesday" = '3', 'Thursday' = '4', 'Friday' = '5'),selected = '2'),)
                                    ),
                                    fluidRow(
                                      column(12,align = "center", h3("When is a 'super-spreader' most likely to occur?"))
                                    ),
                                    fluidRow(
                                      column(6, plotOutput("cent1")),
                                      column(6, plotOutput("cent2"))
                                    ),
                                    fluidRow(
                                      column(12,align = "center", h3("How many students can an infected student reach?"))
                                    ),
                                    fluidRow(
                                      column(12, align = "center", plotOutput("boxplot"))
                                    )
                                    
                            ),
                            tabItem(tabName = "risk",
                                    fluidRow(
                                      column(6, align = "center", selectInput("risk1", label = ("Day 1"), choices = list("Monday" = '1', "Tuesday" = '2',
                                      "Wednesday" = '3', 'Thursday' = '4', 'Friday' = '5'),selected = '1'),),
                                      column(6, align = "center", selectInput("risk2", label = ("Day 2"), choices = list("Monday" = '1', "Tuesday" = '2',
                                      "Wednesday" = '3', 'Thursday' = '4', 'Friday' = '5'),selected = '2'),)
                                    ),
                                    fluidRow(
                                      column(12,align = "center", h3("How long do students stay in contact with other students?"))
                                    ),
                                    fluidRow(
                                      column(6, plotOutput("degree_tie1")),
                                      column(6, plotOutput("degree_tie2"))
                                    ),
                                    fluidRow(
                                      column(12,align = "center", h3("What days have the highest number of 'high-risk' students?"))
                                    ),
                                    fluidRow(
                                      #column(6, plotOutput("mean_degree")),
                                      column(12, plotOutput("high_risk"))
                                    )
                                    
                                    ),
                            tabItem(tabName = "time",
          
                                    fluidRow(
                                      column(6, align = "center", selectInput("edge1", label = ("Day 1"), choices = list("Monday" = '1', "Tuesday" = '2',
                                      "Wednesday" = '3', 'Thursday' = '4', 'Friday' = '5'),selected = '1'),),
                                      column(6, align = "center", selectInput("edge2", label = ("Day 2"), choices = list("Monday" = '1', "Tuesday" = '2',
                                      "Wednesday" = '3', 'Thursday' = '4', 'Friday' = '5'),selected = '2'),)
                                    ),
                                    fluidRow(
                                      column(12,align = "center", h3("At what times do students come into contact with each other?"))
                                    ),
                                    fluidRow(
                                      column(6, plotOutput("form1")),
                                      column(6, plotOutput("form2"))
                                    ),
                                    fluidRow(
                                      column(12,align = "center", h3("At what times do students end contacts?"))
                                    ),
                                    fluidRow(
                                      column(6, plotOutput("diss1")),
                                      column(6, plotOutput("diss2"))
                                    ),
                                    fluidRow(
                                      column(12,align = "center", h3("How long do students stay 'active' on campus?"))
                                    ),
                                    fluidRow(
                                      column(6, plotOutput("active1")),
                                      column(6, plotOutput("active2"))
                                    ),
                                    
                        )),
                        tags$script(HTML('
         $(document).ready(function() {
                     $(\'head\').append(\'<link rel="stylesheet" href="" type="text/css" />\');
                     $(\'head\').append(\'<link rel="stylesheet" href="brand_style.css" type="text/css" />\');
            //all related pages should be linked below
            
            $("header").find("nav").append(\'<p><div class="title-text title-rside"><a href = "https://covidminder.idea.rpi.edu/" style = "color: #222222;">COVID<b><span style = "color: #990000; padding-right: 5%">MINDER</span></b></a> <a href = "" style = "color: #222222;">COVID<b><span style = "color: #990000; padding-right: 5%">TWITTER</span></b></a><a href = "https://covidwarroom.idea.rpi.edu/" style = "color: #222222;">COVID<b><span style = "color: #990000; padding-right: 10%">WAR ROOM</span></b></a></div>\');
             // $(".sidebar-toggle").insertBefore(".tab-content");
          })
       ')),
                           
                        
                    )
)


# Define server logic required to draw a histogram
server <- function(input, output, session) {
    
    # About page body
    output$about_body <- renderUI({
        tags$div(
            HTML("
      <h1>About COVID __________</h1>
      <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas dictum vel ex id faucibus. Aenean dignissim rhoncus leo, ut porttitor elit laoreet a. Nulla mattis vitae nisl eget auctor. Cras vel accumsan urna. Vivamus euismod placerat dolor, vitae pharetra risus placerat vitae. Vivamus aliquam dui luctus fermentum sodales. Morbi rhoncus aliquet suscipit. Nullam a urna lacus. Nullam congue id elit non efficitur. Praesent fringilla nulla enim. Nullam eros dolor, sagittis sed fringilla sit amet, placerat a arcu. Cras pellentesque luctus tellus, vitae sollicitudin purus pharetra vel.</p>
                    <div style='margin-left: 5%'>
                    <h4>Lorem ipsum dolor sit amet,</h4>
                        <p>The first column shown contains a series of graphs using the current social distancing metric being implemented in the selected location. (See subsection entitled ‘Status Quo’ below for additional information.)</p>
                    <h4>Lorem ipsum dolor sit amet,</h4>
                        <p>The second column has two parts: The top-half shows the descriptive statistics for the location that the user selected as of the date that the analysis was last performed. The bottom-half shows a comparison of the predicted descriptive statistics for the area using a pre-defined date. The date of analysis and the predefined prediction date can be found in the text displayed above each of the tables respectively. </p>  
                    <h4>Lorem ipsum dolor sit amet,/h4>
                        <p>The third column contains a series of graphs using the social distancing model that the user selected when defining their parameters. (For additional information on our Social Distancing Models see section entitled ‘Social Distancing Models’ below.)</p>
                    </div>
          <hr>
          <h2>Lorem ipsum dolor sit amet,</h2>
              <p>The following is a brief explanation of the individual components of the COVID War Room application using ‘New York City” as an example. To view the NYC analysis that is being referred to in this example, please click here.</p>
              <p>Let us take New York City (Bronx, Kings, Manhattan, Queens and Richmond counties) as an example.</p>
              <p>Within both of the outside columns—column 1 and column 2—there are a total of four rows, each of which contains one of the following:</p>
              <p><b>Confirmed Daily infections:</b> daily counts of people who tested COVID-positive.</p>
              <p>This is not all infected people as many infections are mild and go untested.</p>
              <p><b>Hospital census:</b> the number of COVID-positive cases in the hospital. This model estimates the values using a disease progression model.</p>
              <p>Only some confirmed infections get hospitalized. We assumed 5%.</p>
              <p><b>Total Infections:</b> Model estimate of symptomatic, asymptomatic and recovered infections (not based on testing or antibody prevalence).</p>
              <p>Level of Social Distancing: the percentage of people staying at home.</p>
              
          <hr>
          <h2>Lorem ipsum dolor sit amet,/h2>
              <h3>Lorem ipsum dolor sit amet,</h3>
                 <p>Pellentesque vestibulum turpis a nibh finibus, non bibendum velit eleifend. Suspendisse potenti. Cras nec iaculis mi. Vestibulum et luctus eros. Donec non iaculis dui, ut aliquet nibh. In hac habitasse platea dictumst. Praesent fringilla dui sit amet quam tincidunt congue. Nam nec porttitor purus. Aenean id dui non metus ullamcorper scelerisque vel sed est. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Aliquam semper commodo sagittis.</p> 
                 <p>Lorem ipsum dolor sit amet,<</p>
<div style='margin-left: 5%'>
                 <h4>Lorem ipsum dolor sit amet,</h4>
                    <p>Pellentesque vestibulum turpis a nibh finibus, non bibendum velit eleifend. Suspendisse potenti. Cras nec iaculis mi. Vestibulum et luctus eros. Donec non iaculis dui, ut aliquet nibh. In hac habitasse platea dictumst. Praesent fringilla dui sit amet quam tincidunt congue. Nam nec porttitor purus. Aenean id dui non metus ullamcorper scelerisque vel sed est. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Aliquam semper commodo sagittis.</p>
                    <pPellentesque vestibulum turpis a nibh finibus, non bibendum velit eleifend. Suspendisse potenti. Cras nec iaculis mi. Vestibulum et luctus eros. Donec non iaculis dui, ut aliquet nibh. In hac habitasse platea dictumst. Praesent fringilla dui sit amet quam tincidunt congue. Nam nec porttitor purus. Aenean id dui non metus ullamcorper scelerisque vel sed est. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Aliquam semper commodo sagittis.</p>

                 <h4>Lorem ipsum dolor sit amet,</h4>
                    <p>Pellentesque vestibulum turpis a nibh finibus, non bibendum velit eleifend. Suspendisse potenti. Cras nec iaculis mi. Vestibulum et luctus eros. Donec non iaculis dui, ut aliquet nibh. In hac habitasse platea dictumst. Praesent fringilla dui sit amet quam tincidunt congue. Nam nec porttitor purus. Aenean id dui non metus ullamcorper scelerisque vel sed est. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Aliquam semper commodo sagittis.</p>
              </div>
              
              <h3>NOTES</h3>
                <p>Pellentesque vestibulum turpis a nibh finibus, non bibendum velit eleifend. Suspendisse potenti. Cras nec iaculis mi. Vestibulum et luctus eros. Donec non iaculis dui, ut aliquet nibh. In hac habitasse platea dictumst. Praesent fringilla dui sit amet quam tincidunt congue. Nam nec porttitor purus. Aenean id dui non metus ullamcorper scelerisque vel sed est. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Aliquam semper commodo sagittis.</p>
              <h3>DISCLAIMERS (the fine print)</h3>
                <p>Pellentesque vestibulum turpis a nibh finibus, non bibendum velit eleifend. Suspendisse potenti. Cras nec iaculis mi. Vestibulum et luctus eros. Donec non iaculis dui, ut aliquet nibh. In hac habitasse platea dictumst. Praesent fringilla dui sit amet quam tincidunt congue. Nam nec porttitor purus. Aenean id dui non metus ullamcorper scelerisque vel sed est. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Aliquam semper commodo sagittis.</p> 

           
           
           ")
            
        )
    })
    cent1 <- reactive({
      switch(input$paths1,
             '1' = plot(mon_cent, main = "Monday Changing Centrality", ylab =  "Centrality"),
             '2' = plot(tue_cent, main = "Tuesday Changing Centrality", ylab =  "Centrality"),
             '3' = plot(wed_cent, main = "Wednesday Changing Centrality", ylab =  "Centrality"),
             '4' = plot(thur_cent, main = "Thursday Changing Centrality", ylab =  "Centrality"),
             '5' = plot(fri_cent, main = "Friday Changing Centrality", ylab =  "Centrality")
      )
    })
    cent2 <- reactive({
      switch(input$paths2,
             '1' = plot(mon_cent, main = "Monday Changing Centrality", ylab =  "Centrality"),
             '2' = plot(tue_cent, main = "Tuesday Changing Centrality", ylab =  "Centrality"),
             '3' = plot(wed_cent, main = "Wednesday Changing Centrality", ylab =  "Centrality"),
             '4' = plot(thur_cent, main = "Thursday Changing Centrality", ylab =  "Centrality"),
             '5' = plot(fri_cent, main = "Friday Changing Centrality", ylab =  "Centrality")
      )
    })
    
    # md_df <- do.call(rbind, Map(data.frame, Degree=mon_degree, TD=mon_tie_dur))
    # md_df$group <- ifelse(md_df$Degree > 70, "A", "B")
    tie_dur_input1 <- reactive({
      switch(input$risk1,
             '1' = plot(mon_degree,mon_tie_dur,
                        xlim=c(0,max(mon_degree)),
                        ylim=c(0,max(mon_tie_dur)),
                        main='Monday Contacts vs Contact Hours',
                        xlab = "Contacts",
                        ylab = "Sum of Contact Hours"),
             # '1' = ggplot2.scatterplot(data = md_df, xName = "Degree",
             #                           yName = "TD",
             #                           groupName = "group"),
             '2' = plot(tue_degree,tue_tie_dur,
                        xlim=c(0,max(tue_degree)),
                        ylim=c(0,max(tue_tie_dur)),
                        main='Tuesday Contacts vs Contact Hours',
                        xlab = "Contacts",
                        ylab = "Sum of Contact Hours"),
             '3' = plot(wed_degree,wed_tie_dur,
                        xlim=c(0,max(wed_degree)),
                        ylim=c(0,max(wed_tie_dur)),
                        main='Wednesday Contacts vs Contact Hours',
                        xlab = "Contacts",
                        ylab = "Sum of Contact Hours"),
             '4' = plot(thur_degree,thur_tie_dur,
                        xlim=c(0,max(thur_degree)),
                        ylim=c(0,max(thur_tie_dur)),
                        main='Thursday Contacts vs Contact Hours',
                        xlab = "Contacts",
                        ylab = "Sum of Contact Hours"),
             '5' = plot(fri_degree,fri_tie_dur,
                        xlim=c(0,max(fri_degree)),
                        ylim=c(0,max(fri_tie_dur)),
                        main='Friday Contacts vs Contact Hours',
                        xlab = "Contacts",
                        ylab = "Sum of Contact Hours")
      )
    })
    tie_dur_input2 <- reactive({
      switch(input$risk2,
             '1' = plot(mon_degree,mon_tie_dur,
                        xlim=c(0,max(mon_degree)),
                        ylim=c(0,max(mon_tie_dur)),
                        main='Monday Contacts vs Contact Hours',
                        xlab = "Contacts",
                        ylab = "Sum of Contact Hours"),
             '2' = plot(tue_degree,tue_tie_dur,
                        xlim=c(0,max(tue_degree)),
                        ylim=c(0,max(tue_tie_dur)),
                        main='Tuesday Contacts vs Contact Hours',
                        xlab = "Contacts",
                        ylab = "Sum of Contact Hours"),
             '3' = plot(wed_degree,wed_tie_dur,
                        xlim=c(0,max(wed_degree)),
                        ylim=c(0,max(wed_tie_dur)),
                        main='Wednesday Contacts vs Contact Hours',
                        xlab = "Contacts",
                        ylab = "Sum of Contact Hours"),
             '4' = plot(thur_degree,thur_tie_dur,
                        xlim=c(0,max(thur_degree)),
                        ylim=c(0,max(thur_tie_dur)),
                        main='Thursday Contacts vs Contact Hours',
                        xlab = "Contacts",
                        ylab = "Sum of Contact Hours"),
             '5' = plot(fri_degree,fri_tie_dur,
                        xlim=c(0,max(fri_degree)),
                        ylim=c(0,max(fri_tie_dur)),
                        main='Friday Contacts vs Contact Hours',
                        xlab = "Contacts",
                        ylab = "Sum of Contact Hours")
      )
    })
    
    format1 <- reactive({
      switch(input$edge1,
             '1' = plot(mon_edge_form, main="Monday Number of Contacts Formed",
                        ylab = "Number of Contacts"),
             '2' = plot(tue_edge_form, main="Tuesday Number of Contacts Formed",
                        ylab = "Number of Contacts"),
             '3' = plot(wed_edge_form, main="Wednesday Number of Contacts Formed",
                        ylab = "Number of Contacts"),
             '4' = plot(thur_edge_form, main="Thursday Number of Contacts Formed",
                        ylab = "Number of Contacts"),
             '5' = plot(fri_edge_form, main="Friday Number of Contacts Formed",
                        ylab = "Number of Contacts")
      )
    })
    
    format2 <- reactive({
      switch(input$edge2,
             '1' = plot(mon_edge_form, main="Monday Number of Contacts Formed",
                        ylab = "Number of Contacts"),
             '2' = plot(tue_edge_form, main="Tuesday Number of Contacts Formed",
                        ylab = "Number of Contacts"),
             '3' = plot(wed_edge_form, main="Wednesday Number of Contacts Formed",
                        ylab = "Number of Contacts"),
             '4' = plot(thur_edge_form, main="Thursday Number of Contacts Formed",
                        ylab = "Number of Contacts"),
             '5' = plot(fri_edge_form, main="Friday Number of Contacts Formed",
                        ylab = "Number of Contacts")
      )
    })
    dissol1 <- reactive({
      switch(input$edge1,
             '1' = plot(mon_edge_diss,main="Monday Number of Contacts Ended",
                        ylab = "Number of Contacts"),
             '2' = plot(tue_edge_diss,main="Tuesday Number of Contacts Ended",
                        ylab = "Number of Contacts"),
             '3' = plot(wed_edge_diss,main="Wednesday Number of Contacts Ended",
                         ylab = "Number of Contacts"),
             '4' = plot(thur_edge_diss,main="Thursday Number of Contacts Ended",
                        ylab = "Number of Contacts"),
             '5' = plot(fri_edge_diss,main="Friday Number of Contacts Ended",
                        ylab = "Number of Contacts")
      )
    })
    dissol2 <- reactive({
      switch(input$edge2,
             '1' = plot(mon_edge_diss,main="Monday Number of Contacts Ended",
                        ylab = "Number of Contacts"),
             '2' = plot(tue_edge_diss,main="Tuesday Number of Contacts Ended",
                        ylab = "Number of Contacts"),
             '3' = plot(wed_edge_diss,main="Wednesday Number of Contacts Ended",
                        ylab = "Number of Contacts"),
             '4' = plot(thur_edge_diss,main="Thursday Number of Contacts Ended",
                        ylab = "Number of Contacts"),
             '5' = plot(fri_edge_diss,main="Friday Number of Contacts Ended",
                        ylab = "Number of Contacts")
      )
    })
    active1 <- reactive({
      switch(input$edge1,
             '1' = hist(mon_vertex_dur, main = "Monday Student 'Active Duration' Frequency",
                        xlab = "Time Active (Hours)"),
             '2' = hist(tue_vertex_dur, main = "Tuesday Student 'Active Duration' Frequency",
                        xlab = "Time Active (Hours)"),
             '3' = hist(wed_vertex_dur, main = "Wednesday Student 'Active Duration' Frequency",
                        xlab = "Time Active (Hours)"),
             '4' = hist(thur_vertex_dur, main = "Thursday Student 'Active Duration' Frequency",
                        xlab = "Time Active (Hours)"),
             '5' = hist(fri_vertex_dur, main = "Friday Student 'Active Duration' Frequency",
                        xlab = "Time Active (Hours)")
      )
    })
    active2 <- reactive({
      switch(input$edge2,
             '1' = hist(mon_vertex_dur, main = "Monday Student 'Active Duration' Frequency",
                        xlab = "Time Active (Hours)"),
             '2' = hist(tue_vertex_dur, main = "Tuesday Student 'Active Duration' Frequency",
                        xlab = "Time Active (Hours)"),
             '3' = hist(wed_vertex_dur, main = "Wednesday Student 'Active Duration' Frequency",
                        xlab = "Time Active (Hours)"),
             '4' = hist(thur_vertex_dur, main = "Thursday Student 'Active Duration' Frequency",
                        xlab = "Time Active (Hours)"),
             '5' = hist(fri_vertex_dur, main = "Friday Student 'Active Duration' Frequency",
                        xlab = "Time Active (Hours)")
      )
    
    
    
    #counts <- c(mean(mon_degree), mean(tue_degree),mean(wed_degree), mean(thur_degree), mean(fri_degree))
    
    
    })
    output$form1 <- renderPlot(format1())
    output$form2 <- renderPlot(format2())
    output$diss1 <- renderPlot(dissol1())
    output$diss2 <- renderPlot(dissol2())
    output$active1 <- renderPlot(active1())
    output$active2 <- renderPlot(active2())
    output$degree_tie1 <- renderPlot(tie_dur_input1())
    output$degree_tie2 <- renderPlot(tie_dur_input2())
    output$cent1 <- renderPlot(cent1())
    output$cent2 <- renderPlot(cent2())
    output$boxplot <- renderPlot(boxplot(cbind(mon_reach, tue_reach, wed_reach, thur_reach, fri_reach),
                                         main='Number of "Reachable" Students',
                                         names = c("Monday", "Tuesday", "Wednesday", 'Thursday', 'Friday'),
                                         ylab = "Number of Students"))
    # output$mean_degree <- renderPlot(barplot(counts, main="Degree Means", horiz=FALSE,
    #                                          names.arg=c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday")))
    output$high_risk <- renderPlot(barplot(hr, main="High Risk Students", horiz=FALSE,
                                           names.arg=c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday"),
                                           ylab = "Number of Students"))
    
}

# Run the application
shinyApp(ui = ui, server = server)
