library(shiny)
library(shinydashboard)
library(ggplot2)
library(dplyr)
library(plotly)

# Datos simulados a partir del análisis del informe
datos <- data.frame(
  categoria = c("Frustración académica",
                "Problemas económicos",
                "Falta de apoyo institucional",
                "Estrés / salud mental",
                "Apoyo familiar",
                "Motivación educativa"),
  frecuencia = c(25,20,18,15,12,10)
)

# UI
ui <- dashboardPage(
  skin = "blue",
  
  dashboardHeader(title = "Madres Universitarias - Mag. José González y Prof. Miguel Lima"),
  
  dashboardSidebar(
    sidebarMenu(
      menuItem("Contexto", tabName = "contexto"),
      menuItem("Marco Teórico", tabName = "teoria"),
      menuItem("Metodología", tabName = "metodologia"),
      menuItem("Resultados", tabName = "resultados"),
      menuItem("Conclusiones", tabName = "conclusiones")
    )
  ),

  
  dashboardBody(
    
    tabItems(
      
      tabItem(tabName = "contexto",
              fluidRow(
                box(width=12, title="Problema de Investigación",
                    "La investigación analiza la calidad de vida de madres estudiantes universitarias y cómo perciben su identidad al desempeñar simultáneamente los roles de madre y estudiante dentro de la universidad.")
              ),
              
              fluidRow(
                valueBox(
                  value = "7",
                  subtitle = HTML("MADRES<br>ENTREVISTADAS"),
                  icon = icon("users")
                ),
                valueBox("Método", "Cualitativo", icon = icon("search")),
                valueBox("Lugar", "Salto, Uruguay", icon = icon("map")),
                br(),br(),
                tags$a(
                  href = "https://www.researchgate.net/publication/269874524_MADRES_UNIVERSITARIAS",
                  target = "_blank",
                  class = "btn",
                  style = "
    background-color:#CB181D;
    color:white;
    border:none;
    font-weight:bold;
    padding:10px 18px;
    font-size:16px;
  ",
                  icon("external-link-alt"),
                  " Ver Investigación Académica"
                ),
                br(),br(), 
              )
      ),
         
      
      tabItem(tabName = "teoria",
              fluidRow(
                box(width=6, title="Percepción",
                    "Proceso mediante el cual las personas interpretan su realidad social y construyen significados sobre su experiencia."),
                
                box(width=6, title="Calidad de vida",
                    "Estado de bienestar físico, psicológico y social asociado a condiciones materiales y subjetivas.")
              ),
              
              fluidRow(
                box(width=6, title="Derechos Humanos",
                    "Todos los individuos tienen derecho a igualdad y protección contra discriminación."),
                
                box(width=6, title="Derechos de las mujeres",
                    "La participación femenina en educación superior es clave para el desarrollo social.")
              )
      ),
      
      
      tabItem(tabName = "metodologia",
              fluidRow(
                box(width=12, title="Diseño de Investigación",
                    
                    tags$ul(
                      tags$li("Metodología cualitativa"),
                      tags$li("Grounded Theory"),
                      tags$li("Entrevistas en profundidad"),
                      tags$li("Análisis temático del discurso")
                    )
                )
              )
      ),
      
      
      tabItem(tabName = "resultados",
              
              fluidRow(
                box(width=12,
                    title="Principales problemáticas identificadas",
                    
                    plotlyOutput("grafico")
                )
              ),
              
              fluidRow(
                box(width=6, title="Testimonios",
                    "Las entrevistadas manifestaron frustración por dificultades para compatibilizar maternidad y estudios, especialmente en momentos de evaluaciones."),
                
                box(width=6, title="Barreras institucionales",
                    "La universidad no presenta políticas específicas para apoyar a madres estudiantes.")
              )
      ),
      
      
      tabItem(tabName = "conclusiones",
              fluidRow(
                box(width=12, title="Conclusiones de la investigación",
                    
                    tags$ul(
                      tags$li("La maternidad genera tensiones entre roles académicos y familiares"),
                      tags$li("Existen dificultades económicas y logísticas"),
                      tags$li("La universidad carece de políticas específicas para esta población"),
                      tags$li("El apoyo familiar resulta clave para la permanencia educativa")
                    )
                )
              )
      )
      
    )
  )
)

# SERVER
server <- function(input, output) {
  
  output$grafico <- renderPlotly({
    
    p <- ggplot(datos, aes(
      x = reorder(categoria, frecuencia),
      y = frecuencia,
      text = paste("Categoría:", categoria,
                   "<br>Frecuencia:", frecuencia)
    )) +
      geom_bar(stat="identity", fill="#1F4E79") +
      coord_flip() +
      labs(
        title="Problemas reportados por madres universitarias",
        x="Categoría",
        y="Frecuencia"
      ) +
      theme_minimal()
    
    ggplotly(p, tooltip = "text")
    
  })
  
}

shinyApp(ui, server)
