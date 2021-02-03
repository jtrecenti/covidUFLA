#' The application User-Interface
#' 
#' @param request Internal parameter for `{shiny}`. 
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_ui <- function(request) {
  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    # Your application UI logic 
    bs4Dash::dashboardPage(
      controlbar = bs4Dash::dashboardControlbar(
        skin = "light"
      ),
      
      navbar = bs4Dash::dashboardHeader(
        rightUi = auth0::logoutButton(icon = icon("sign-out-alt"))
      ),
      
      sidebar = bs4Dash::dashboardSidebar(
        skin = "light",
        title = "{covidUFLA}",
        bs4Dash::bs4SidebarMenu(
          bs4Dash::bs4SidebarMenuItem(
            "Principal",
            tabName = "principal",
            icon = "globe"
          )
        )
      ),
      
      body = bs4Dash::dashboardBody(
        # fresh::use_theme(create_theme_css()),
        bs4Dash::bs4TabItems(
          bs4Dash::bs4TabItem(
            tabName = "principal",
            mod_principal_ui("principal_ui_1")
          )
        )
      ),
      
      footer = bs4Dash::dashboardFooter(
        copyrights = a(
          href = "https://curso-r.com",
          target = "_blank", "Curso-R"
        ),
        right_text = "2021 | desenvolvido com <3 para a UFLA"
      )
      
    )
  )
}

#' Add external Resources to the Application
#' 
#' This function is internally used to add external 
#' resources inside the Shiny application. 
#' 
#' @import shiny
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @noRd
golem_add_external_resources <- function(){
  
  add_resource_path(
    'www', app_sys('app/www')
  )
 
  tags$head(
    favicon(),
    bundle_resources(
      path = app_sys('app/www'),
      app_title = 'covidUFLA'
    )
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert() 
  )
}

