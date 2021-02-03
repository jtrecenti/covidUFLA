#' principal UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_principal_ui <- function(id){
  ns <- NS(id)
  tagList(
    
    shiny::fluidRow(
      bs4Dash::box(
        width = 6,
        reactable::reactableOutput(
          ns("tabela")
        )
      ),
      bs4Dash::box(
        width = 6,
        leaflet::leafletOutput(
          ns("mapa")
        )
      )
    )
    
    
 
  )
}
    
#' principal Server Functions
#'
#' @noRd 
mod_principal_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
 
    mapa <- geobr::read_state() %>% 
      sf::st_simplify(dTolerance = .1)
    
    output$tabela <- reactable::renderReactable({
      
      covidUFLA::covid %>% 
        dplyr::group_by(estado) %>% 
        dplyr::summarise(
          obitos = sum(obitos),
          taxa = sum(obitos / dplyr::first(populacao))
        ) %>% 
        reactable::reactable(columns = list(
          estado = reactable::colDef("Estado"),
          obitos = reactable::colDef("Obitos"),
          taxa = reactable::colDef(
            "Taxa",
            format = reactable::colFormat(
              percent = TRUE, 
              digits = 2
            )
          )
        ))
      
    })
    
    output$mapa <- leaflet::renderLeaflet({
      covidUFLA::covid %>% 
        dplyr::group_by(estado) %>% 
        dplyr::summarise(
          obitos = sum(obitos),
          taxa = sum(obitos / dplyr::first(populacao))
        ) %>% 
        dplyr::inner_join(
          mapa, 
          c("estado" = "abbrev_state")
        ) %>% 
        sf::st_as_sf() %>% 
        leaflet::leaflet() %>% 
        leaflet::addPolygons()
    })
    
    
  })
}
    
## To be copied in the UI
# mod_principal_ui("principal_ui_1")
    
## To be copied in the server
# mod_principal_server("principal_ui_1")
